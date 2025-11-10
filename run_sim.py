import time
import asyncio
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

def get_state_string(state_val):
    return STATE_MAP.get(state_val, "XXXX")

def get_light_tuple(light_val, num_bits):
    if num_bits == 3: 
        return (bool(light_val & 1), bool(light_val & 2), bool(light_val & 4))
    if num_bits == 2:
        return (bool(light_val & 1), bool(light_val & 2))
    return ()

# We DELETED the command_listener function

@cocotb.test
async def run_fsm_simulation(dut):
    """The main cocotb test routine."""
    
    dut._log.info("[cocotb] Starting simulation...")
    
    # We DELETED cocotb.start_soon(command_listener(dut))
    
    # --- Do the initial reset ---
    dut.clk.value = 0
    dut.reset.value = 1
    dut.pedestrian_request.value = 0
    
    # Manually tick the clock twice for the 2-cycle reset
    await Timer(10, 'ns')
    dut.clk.value = 1
    await Timer(10, 'ns')
    dut.clk.value = 0
    await Timer(10, 'ns')
    dut.clk.value = 1
    await Timer(10, 'ns')
    dut.clk.value = 0
    
    dut.reset.value = 0 # Release the reset
    await Timer(10, 'ns')
    
    dut._log.info("[cocotb] Reset released. Main loop starting.")

    while True:
        
        # --- NEW: Check for commands at the start of the loop ---
        try:
            if os.path.exists(COMMAND_FILE):
                with open(COMMAND_FILE, 'r') as f:
                    command = f.read().strip()
                os.remove(COMMAND_FILE) 

                dut._log.info(f"[cocotb] Received command: {command}")

                if command == "reset":
                    # We will pulse reset high *during* this 1-second 'tick'
                    dut.reset.value = 1
                    dut._log.info("[cocotb] Reset command received.")
                
                elif command == "pedestrian_request":
                    dut.pedestrian_request.value = 1
                    dut._log.info("[cocotb] Pedestrian request command received.")
                        
        except Exception as e:
            dut._log.error(f"[cocotb] Command check error: {e}")
        # --- END OF NEW LOGIC ---

        # 1. Wait for 1 real-world second.
        dut._log.info("[cocotb] MAIN_LOOP: Waiting 1 second...")
        time.sleep(1)
        dut._log.info("[cocotb] MAIN_LOOP: Wait complete!") 
        
        # 2. Manually create ONE 'posedge' clock pulse
        dut.clk.value = 1
        await Timer(10, 'ns') 
        
        # 3. Read all outputs from the DUT (while clock is high)
        try:
            state_int = int(dut.current_state.value)
            state = get_state_string(state_int)
            timer_count = int(dut.timer_count_out.value)
            
            dut._log.info(f"[cocotb] WRITING STATUS: {state}, timer={timer_count}")

            ns_light_val = int(dut.ns_light.value)
            ew_light_val = int(dut.ew_light.value)
            ped_light_val = int(dut.ped_light.value)
            
            ns_light = get_light_tuple(ns_light_val, 3)
            ew_light = get_light_tuple(ew_light_val, 3)
            ped_light = get_light_tuple(ped_light_val, 2)
            
            fsm_state = {
                "state": state,
                "timer_count": timer_count,
                "ns_light": ns_light,
                "ew_light": ew_light,
                "ped_light": ped_light
            }

            with open(STATUS_FILE, 'w') as f:
                json.dump(fsm_state, f)

        except Exception as e:
            dut._log.error(f"[cocotb] Main loop error: {e}")
            with open(STATUS_FILE, 'w') as f:
                json.dump({"state": "SIM_ERROR", "timer_count": -1}, f)
        
        # 4. Finish the clock pulse (negedge)
        dut.clk.value = 0
        await Timer(10, 'ns')
        
        # 5. --- NEW: De-assert signals after the tick ---
        # Set signals back to 0 so they are ready for the next loop.
        dut.pedestrian_request.value = 0
        if dut.reset.value == 1:
            dut.reset.value = 0 # Release the reset
            dut._log.info("[cocotb] Reset released.")