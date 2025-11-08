import os
import subprocess
import atexit
import json
import time
from flask import Flask, render_template, jsonify, request
from multiprocessing import Process

# --- Global Process Variables ---
sim_process = None
COMMAND_FILE = "command.txt"
STATUS_FILE = "status.json"

# --- FIX for Race Condition ---
# This cache holds the last valid state we read.
# If we read an empty file, we'll send this instead.
g_last_known_state = {
    "state": "STARTING", 
    "timer_count": 0, 
    "ns_light": (1,0,0), 
    "ew_light": (1,0,0), 
    "ped_light": (1,0)
}
# --- End of Fix ---

def run_cocotb():
    """
    This function runs in a separate process.
    It just runs 'make sim' and exits.
    All communication is now done via files.
    """
    print("[Flask Process] Starting cocotb process...")
    
    # Clear any old command/status files
    if os.path.exists(COMMAND_FILE):
        os.remove(COMMAND_FILE)
    if os.path.exists(STATUS_FILE):
        os.remove(STATUS_FILE)

    try:
        # Run 'make sim' to start the cocotb simulation
        subprocess.run(["make", "sim"], check=True, stdin=subprocess.DEVNULL)
    except Exception as e:
        print(f"[cocotb Process] Simulation failed: {e}")
    finally:
        print("[cocotb Process] Simulation process finished.")
        # Clean up files on exit
        if os.path.exists(COMMAND_FILE):
            os.remove(COMMAND_FILE)
        if os.path.exists(STATUS_FILE):
            os.remove(STATUS_FILE)

def setup_simulation_process():
    """Start the cocotb simulation process."""
    global sim_process
    
    # Start the cocotb simulation in its own process
    sim_process = Process(target=run_cocotb)
    sim_process.start()


# --- Flask Web Server ---
app = Flask(__name__, template_folder='.')

@app.route('/')
def index():
    """Serve the main HTML page."""
    return render_template('index.html')

@app.route('/api/status')
def api_status():
    """Provide the current FSM state as JSON by reading the status file."""
    
    # --- FIX for Race Condition ---
    # We now use a global cache.
    global g_last_known_state
    
    try:
        # Try to read the status file
        with open(STATUS_FILE, 'r') as f:
            fsm_state = json.load(f)
        
        # We got a good read! Cache it and send it.
        g_last_known_state = fsm_state
        return jsonify(fsm_state)
        
    except FileNotFoundError:
        # Sim is starting or file is gone. Send the last known state.
        return jsonify(g_last_known_state)
        
    except json.JSONDecodeError:
        # This is the key: we hit the race condition and read an empty file.
        # This is not an error. Just send the last known state
        # so the UI doesn't flicker or show an error.
        return jsonify(g_last_known_state)
        
    except Exception as e:
        # This is a *real* error
        print(f"[Flask] Error reading status file: {e}")
        return jsonify({"state": "ERROR", "timer_count": -1}), 500
    # --- End of Fix ---

@app.route('/api/input', methods=['POST'])
def api_input():
    """Handle inputs from the web page (send to cocotb via file)."""
    data = request.get_json()
    command = data.get('signal')
    
    if not command:
        return jsonify({"status": "error", "message": "no signal provided"}), 400
        
    try:
        # Write the command to the command file
        with open(COMMAND_FILE, 'w') as f:
            f.write(command)
        
        print(f"[Flask] Sent command to cocotb: {command}")
        return jsonify({"status": "ok"})
        
    except Exception as e:
        print(f"[Flask] Error writing command file: {e}")
        return jsonify({"status": "error", "message": "failed to send command"}), 500

@atexit.register
def cleanup():
    """Ensure the simulation process is killed on exit."""
    global sim_process
    
    print("[Flask] Shutting down...")
    if sim_process and sim_process.is_alive():
        print("[Flask] Terminating simulation process.")
        sim_process.terminate()
        sim_process.join()
    
    # Final cleanup of communication files
    if os.path.exists(COMMAND_FILE):
        os.remove(COMMAND_FILE)
    if os.path.exists(STATUS_FILE):
        os.remove(STATUS_FILE)
    # --- FIX for Race Condition ---
    # Clean up the .tmp file if it exists
    if os.path.exists("status.json.tmp"):
        os.remove("status.json.tmp")
    # --- End of Fix ---
    print("[Flask] Cleanup complete.")

if __name__ == '__main__':
    # 1. Start the simulation process
    setup_simulation_process()
    
    # 2. Start the Flask web server
    print("[Flask] Starting Flask server on http://127.0.0.1:5000")
    # debug=False is CRITICAL for multiprocessing to work correctly
    app.run(debug=False, host='0.0.0.0', port=5000)