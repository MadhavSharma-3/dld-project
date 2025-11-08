Project Plan: FSM Traffic Light Controller
This document outlines the design and implementation strategy for the FSM-based traffic light controller, as specified in the project objectives.
1. Core Design Strategy
We will build a Moore FSM. The system will be composed of three main logical components integrated into a single Verilog module:
FSM State Logic: A set of registers (state, next_state) that manage the 5 states.
Integrated Timer: A single counter (timer_count) that resets on every state change. A combinational signal (timer_done) will tell the FSM when the current state's time has expired.
Pedestrian Latch: A 1-bit register (ped_request_latched) that "remembers" a pedestrian_request button press until it can be serviced.
2. State Diagram
The FSM will have 5 states as defined in the localparam block. The outputs are determined only by the current state (Moore Machine).
States & Outputs
S_NS_GREEN
NS Lights: GREEN
EW Lights: RED
Ped Lights: DON'T WALK
Timer: GREEN_CYCLES
S_NS_YELLOW
NS Lights: YELLOW
EW Lights: RED
Ped Lights: DON'T WALK
Timer: YELLOW_CYCLES
S_EW_GREEN
NS Lights: RED
EW Lights: GREEN
Ped Lights: DON'T WALK
Timer: GREEN_CYCLES
S_EW_YELLOW
NS Lights: RED
EW Lights: YELLOW
Ped Lights: DON'T WALK
Timer: YELLOW_CYCLES
S_PED_GREEN
NS Lights: RED
EW Lights: RED
Ped Lights: WALK
Timer: PED_CYCLES
Transitions (on timer_done)
S_NS_GREEN -> S_NS_YELLOW
Condition: timer_done
S_NS_YELLOW -> S_PED_GREEN
Condition: timer_done AND ped_request_latched == 1
S_NS_YELLOW -> S_EW_GREEN
Condition: timer_done AND ped_request_latched == 0
S_EW_GREEN -> S_EW_YELLOW
Condition: timer_done
S_EW_YELLOW -> S_PED_GREEN
Condition: timer_done AND ped_request_latched == 1
S_EW_YELLOW -> S_NS_GREEN
Condition: timer_done AND ped_request_latched == 0
S_PED_GREEN -> S_NS_GREEN
Condition: timer_done (Return to main cycle)
3. Verilog Module Architecture
We will use three always blocks for a standard, robust FSM design:
always_ff (Sequential): This is the "memory" of the FSM. On the posedge clk, it updates:
state <= next_state
The timer_count (increments or resets to 0 if timer_done).
The ped_request_latched register (sets to 1 on pedestrian_request, clears to 0 when the S_PED_GREEN state is entered).
always_comb (Next-State Logic): This is the "brain" (transitions). It's a case (state) statement that looks at the current state and inputs (timer_done, ped_request_latched) to decide what next_state should be.
always_comb (Output Logic): This is the "Moore" part. It's a case (state) statement that looks only at the current state to determine the outputs (ns_light, ew_light, ped_light).
4. Testbench Plan
The testbench will simulate three scenarios as requested:
Reset & Normal Cycle:
Assert reset.
De-assert reset and let the FSM cycle through NS_GREEN -> NS_YELLOW -> EW_GREEN -> EW_YELLOW -> NS_GREEN...
Verify timings are correct.
Pedestrian Request (during NS_GREEN):
While in S_NS_GREEN, pulse pedestrian_request = 1.
Verify the FSM cycles S_NS_GREEN -> S_NS_YELLOW and then transitions to S_PED_GREEN.
Verify it returns to S_NS_GREEN after.
Back-to-Back Request:
Trigger a pedestrian request as above.
While the FSM is in S_PED_GREEN, pulse pedestrian_request again.
Verify the FSM completes the full next vehicle cycle (NS -> EW) before servicing the new pedestrian request.
