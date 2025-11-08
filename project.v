`timescale 1ns / 1ps

module traffic_light_controller (
    input wire clk,
    input wire reset,
    input wire pedestrian_request,

    // Outputs (Moore machine, so these depend only on state)
    output reg [2:0] ns_light,       // North-South: 3'b100=G, 3'b010=Y, 3'b001=R
    output reg [2:0] ew_light,       // East-West:   3'b100=G, 3'b010=Y, 3'b001=R
    output reg [1:0] ped_light,      // Pedestrian:  2'b10=WALK, 2'b01=DON'T WALK
    output wire [2:0] current_state, // Expose current state for testbench
    output wire ped_request_latched_out, // Debugging
    output wire was_in_ns_phase_out    // Debugging
);

    // --- State Definitions ---
    parameter S_NS_GREEN  = 3'b000;
    parameter S_NS_YELLOW = 3'b001;
    parameter S_EW_GREEN  = 3'b010;
    parameter S_EW_YELLOW = 3'b011;
    parameter S_PED_GREEN = 3'b100;

    // --- State Registers ---
    reg [2:0] state_reg, next_state;

    // --- Timer Logic ---
    parameter GREEN_DURATION  = 10;
    parameter YELLOW_DURATION = 3;
    parameter PED_DURATION    = 5;

    reg [$clog2(GREEN_DURATION > PED_DURATION ? GREEN_DURATION : PED_DURATION) : 0] timer_count;
    wire timer_done;

    // --- Pedestrian Request Latch ---
    reg ped_request_latched;
    
    // --- Phase Memory Register ---
    // This is the new logic to remember which phase to return to.
    reg was_in_ns_phase;

    // --- FSM Sequential Logic (State, Timer, Phase Memory) ---
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state_reg <= S_NS_GREEN;
            timer_count <= 0;
            was_in_ns_phase <= 1'b0; // Default to EW phase (so it returns to NS)
        end else begin
            // On state change, reset the timer. Otherwise, increment.
            if (next_state != state_reg) begin
                timer_count <= 0;
            end else if (!timer_done) begin
                timer_count <= timer_count + 1;
            end
            
            // Update the state register
            state_reg <= next_state;

            // *** NEW LOGIC for Phase Memory ***
            // Store where we came from *before* we enter PED_GREEN
            // This is evaluated on the same clock as the state change.
            if (next_state == S_PED_GREEN) begin
                if (state_reg == S_NS_YELLOW)
                    was_in_ns_phase <= 1'b1; // We came from NS
                else if (state_reg == S_EW_YELLOW)
                    was_in_ns_phase <= 1'b0; // We came from EW
            end
            // Note: If we stay in PED_GREEN, this reg holds its value.
        end
    end

    // --- Pedestrian Latch Sequential Logic ---
    // This logic is unchanged and correct.
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ped_request_latched <= 1'b0;
        end 
        // Latch a new request FIRST (highest priority)
        else if (pedestrian_request) begin
            ped_request_latched <= 1'b1;
        end
        // Clear the latch ONLY when we are *about to service it*.
        else if ((state_reg == S_NS_YELLOW && timer_done && ped_request_latched) ||
                 (state_reg == S_EW_YELLOW && timer_done && ped_request_latched)) 
        begin
            ped_request_latched <= 1'b0;
        end
    end

    // --- Timer 'done' Combinational Logic ---
    assign timer_done = 
        (state_reg == S_NS_GREEN  && timer_count == GREEN_DURATION - 1) ||
        (state_reg == S_NS_YELLOW && timer_count == YELLOW_DURATION - 1) ||
        (state_reg == S_EW_GREEN  && timer_count == GREEN_DURATION - 1) ||
        (state_reg == S_EW_YELLOW && timer_count == YELLOW_DURATION - 1) ||
        (state_reg == S_PED_GREEN && timer_count == PED_DURATION - 1);

    // --- FSM Combinational Logic (Next State) ---
    always @(*) begin
        // Default assignment to avoid latches
        next_state = state_reg;

        case (state_reg)
            S_NS_GREEN: begin
                if (timer_done)
                    next_state = S_NS_YELLOW;
            end
            
            S_NS_YELLOW: begin
                if (timer_done) begin
                    if (ped_request_latched)
                        next_state = S_PED_GREEN; // Go to Ped
                    else
                        next_state = S_EW_GREEN;  // Go to EW
                end
            end
            
            S_EW_GREEN: begin
                if (timer_done)
                    next_state = S_EW_YELLOW;
            end
            
            S_EW_YELLOW: begin
                if (timer_done) begin
                    if (ped_request_latched)
                        next_state = S_PED_GREEN; // Go to Ped
                    else
                        next_state = S_NS_GREEN;  // Go to NS
                end
            end
            
            S_PED_GREEN: begin
                if (timer_done) begin
                    // *** THIS IS THE NEW LOGIC ***
                    if (was_in_ns_phase)
                        next_state = S_EW_GREEN; // Resume to EW
                    else
                        next_state = S_NS_GREEN; // Resume to NS
                end
            end

            default: begin
                next_state = S_NS_GREEN; // Safe state
            end
        endcase
    end

    // --- Moore Output Logic (Combinational) ---
    // This logic is unchanged.
    always @(*) begin
        // Default all lights to Red / Don't Walk
        ns_light  = 3'b001; // Red
        ew_light  = 3'b001; // Red
        ped_light = 2'b01;  // Don't Walk

        case (state_reg)
            // *** FIXED: Removed illegal 'break;' statements ***
            S_NS_GREEN:  ns_light = 3'b100;
            S_NS_YELLOW: ns_light = 3'b010;
            S_EW_GREEN:  ew_light = 3'b100;
            S_EW_YELLOW: ew_light = 3'b010;
            S_PED_GREEN: ped_light = 2'b10;
            default: ; // All Red
        endcase
    end
    
    // --- Assign outputs for testbench ---
    assign current_state = state_reg;
    assign ped_request_latched_out = ped_request_latched;
    assign was_in_ns_phase_out = was_in_ns_phase;

endmodule