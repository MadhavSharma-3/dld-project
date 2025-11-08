import cocotb
import os
import json
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge

# --- State Definitions (must match Verilog) ---
S_NS_GREEN  = 0
S_NS_YELLOW = 1
S_EW_GREEN  = 2
S_EW_YELLOW = 3
S_PED_GREEN = 4

STATE_MAP = {
    S_NS_GREEN: "NS_GRN",
    S_NS_YELLOW: "NS_YEL",
    S_EW_GREEN: "EW_GRN",
    S_EW_YELLOW: "EW_YEL",
    S_PED_GREEN: "PED_GRN",
}

# --- File-based Communication ---
COMMAND_FILE = "command.txt"
STATUS_FILE = "status.json"
# --- FIX ---
# Removed STATUS_FILE_TMP, we write directly now
# --- End of Fix ---


def get_state_string(state_val):
    """Converts the integer state from Verilog to a string."""
    return STATE_MAP.get(state_val, "XXXX")

def get_light_tuple(light_val, num_bits):
    """Converts a Verilog light value (int) to a boolean tuple for JSON."""
    # Verilog: 3'b100=G, 3'b010=Y, 3'b001=R  -> JSON: (R, Y, G)
    if num_bits == 3: 
        return (bool(light_val & 1), bool(light_val & 2), bool(light_val & 4))
    # Verilog: 2'b10=WALK, 2'b01=DON'T WALK -> JSON: (DONT, WALK)
    if num_bits == 2:
        return (bool(light_val & 1), bool(light_val & 2))
    return ()

async def command_listener(dut):
    """
    This coroutine polls the command.txt file for commands
    from the Flask server and drives the Verilog signals.
    """
    
    # FIX: Use cocotb v2.0.0 API: dut.signal.value = value
    dut.pedestrian_request.value = 0
    dut.reset.value = 1 # Start in reset
    
    while True:
        try:
            # Check if the command file exists
            if os.path.exists(COMMAND_FILE):
                with open(COMMAND_FILE, 'r') as f:
                    command = f.read().strip()
                
                # Command read, delete the file so we don't run it again
                os.remove(COMMAND_FILE)

                dut._log.info(f"[cocotb] Received command: {command}")

                if command == "reset":
                    # FIX: Use cocotb v2.0.0 API
                    dut.reset.value = 1
                    await RisingEdge(dut.clk)
                    dut.reset.value = 0
                
                elif command == "pedestrian_request":
                    # FIX: Use cocotb v2.0.0 API
                    dut.pedestrian_request.value = 1
                    await RisingEdge(dut.clk)
                    dut.pedestrian_request.value = 0
            
            # Poll the file every 100ms
            await Timer(100, 'ms')

        except Exception as e:
            dut._log.error(f"[cocotb] Command listener error: {e}")
            await Timer(100, 'ms')

@cocotb.test
async def run_fsm_simulation(dut):
    """The main cocotb test routine."""
    
    dut._log.info("[cocotb] Starting simulation...")
    
    # Create a 1-second clock
    cocotb.start_soon(Clock(dut.clk, 1, unit="sec").start())
    
    # Start the command listener coroutine
    cocotb.start_soon(command_listener(dut))
    
    # Let reset apply for 2 clock cycles
    dut.reset.value = 1
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    dut.reset.value = 0
    await RisingEdge(dut.clk)
    dut._log.info("[cocotb] Reset released. Main loop starting.")

    while True:
        # Wait for the next clock tick
        await RisingEdge(dut.clk)
        
        # Read all outputs from the DUT
        try:
            # Use .value to read the signal
            state_int = int(dut.current_state.value)
            state = get_state_string(state_int)
            timer_count = int(dut.timer_count.value)
            
            # Read the raw integer value from Verilog
            ns_light_val = int(dut.ns_light.value)
            ew_light_val = int(dut.ew_light.value)
            ped_light_val = int(dut.ped_light.value)
            
            # Convert to boolean tuples
            ns_light = get_light_tuple(ns_light_val, 3)
            ew_light = get_light_tuple(ew_light_val, 3)
            ped_light = get_light_tuple(ped_light_val, 2)
            
            # Create the status dictionary
            fsm_state = {
                "state": state,
                "timer_count": timer_count,
                "ns_light": ns_light,
                "ew_light": ew_light,
                "ped_light": ped_light
            }

            # --- FIX for Race Condition ---
            # We now write directly to the main status file.
            # This will fix the [WinError 5] Access Denied error.
            with open(STATUS_FILE, 'w') as f:
                json.dump(fsm_state, f)
            # --- End of Fix ---

        except Exception as e:
            dut._log.error(f"[cocotb] Main loop error: {e}")
            # Write error to file so front-end can see it
            # This write is also fixed to be direct
            with open(STATUS_FILE, 'w') as f:
                json.dump({"state": "SIM_ERROR", "timer_count": -1}, f)
            # --- End of Fix ---