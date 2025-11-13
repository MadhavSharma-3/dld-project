`timescale 1ns / 1ps


module traffic_light_controller (
    input wire clk,
    input wire reset,
    input wire pedestrian_request,

    output reg [2:0] ns_light,
    output reg [2:0] ew_light,
    output reg [1:0] ped_light,
    output wire [2:0] current_state,
    output wire [3:0] timer_count_out, 
    output wire ped_request_latched_out,
    output wire was_in_ns_phase_out
);

    parameter S_NS_GREEN  = 3'b000;
    parameter S_NS_YELLOW = 3'b001;
    parameter S_EW_GREEN  = 3'b010;
    parameter S_EW_YELLOW = 3'b011;
    parameter S_PED_GREEN = 3'b100;

    reg [2:0] state_reg, next_state;

    parameter GREEN_DURATION  = 10;
    parameter YELLOW_DURATION = 3;
    parameter PED_DURATION    = 5;

    reg [$clog2(GREEN_DURATION > PED_DURATION ? GREEN_DURATION : PED_DURATION) : 0] timer_count;
    wire timer_done;

    reg ped_request_latched;
    
    reg was_in_ns_phase;

    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state_reg <= S_NS_GREEN;
            timer_count <= 0;
            was_in_ns_phase <= 1'b0; 
        end else begin
            
            if (next_state != state_reg) begin
                timer_count <= 0;
            end else if (!timer_done) begin
                timer_count <= timer_count + 1;
            end
            
            
            state_reg <= next_state;

            
            
            
            if (next_state == S_PED_GREEN) begin
                if (state_reg == S_NS_YELLOW)
                    was_in_ns_phase <= 1'b1; 
                else if (state_reg == S_EW_YELLOW)
                    was_in_ns_phase <= 1'b0; 
            end
            
        end
    end

    // Pedestrian Latch Sequential Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ped_request_latched <= 1'b0;
        end 
        
        else if (pedestrian_request) begin
            ped_request_latched <= 1'b1;
        end
        
        else if ((state_reg == S_NS_YELLOW && timer_done && ped_request_latched) ||
                 (state_reg == S_EW_YELLOW && timer_done && ped_request_latched)) 
        begin
            ped_request_latched <= 1'b0;
        end
    end

    
    assign timer_done = 
        (state_reg == S_NS_GREEN  && timer_count == GREEN_DURATION - 1) ||
        (state_reg == S_NS_YELLOW && timer_count == YELLOW_DURATION - 1) ||
        (state_reg == S_EW_GREEN  && timer_count == GREEN_DURATION - 1) ||
        (state_reg == S_EW_YELLOW && timer_count == YELLOW_DURATION - 1) ||
        (state_reg == S_PED_GREEN && timer_count == PED_DURATION - 1);

    // FSM Combinational Logic (Next State)
    always @(*) begin
        next_state = state_reg;

        case (state_reg)
            S_NS_GREEN: begin
                if (timer_done)
                    next_state = S_NS_YELLOW;
            end
            
            S_NS_YELLOW: begin
                if (timer_done) begin
                    if (ped_request_latched)
                        next_state = S_PED_GREEN; 
                    else
                        next_state = S_EW_GREEN;  
                end
            end
            
            S_EW_GREEN: begin
                if (timer_done)
                    next_state = S_EW_YELLOW;
            end
            
            S_EW_YELLOW: begin
                if (timer_done) begin
                    if (ped_request_latched)
                        next_state = S_PED_GREEN; 
                    else
                        next_state = S_NS_GREEN;  
                end
            end
            
            S_PED_GREEN: begin
                if (timer_done) begin
                    
                    if (was_in_ns_phase)
                        next_state = S_EW_GREEN; 
                    else
                        next_state = S_NS_GREEN; 
                end
            end

            default: begin
                next_state = S_NS_GREEN; 
            end
        endcase
    end

    // Moore Output Logic (Combinational)
    always @(*) begin
        ns_light  = 3'b001; 
        ew_light  = 3'b001; 
        ped_light = 2'b01;  

        case (state_reg)
            S_NS_GREEN:  ns_light = 3'b100;
            S_NS_YELLOW: ns_light = 3'b010;
            S_EW_GREEN:  ew_light = 3'b100;
            S_EW_YELLOW: ew_light = 3'b010;
            S_PED_GREEN: ped_light = 2'b10;
            default: ; 
        endcase
    end
    
    // Assign outputs for testbench
    assign current_state = state_reg;
    assign ped_request_latched_out = ped_request_latched;
    assign was_in_ns_phase_out = was_in_ns_phase;

    assign timer_count_out = timer_count; 
endmodule