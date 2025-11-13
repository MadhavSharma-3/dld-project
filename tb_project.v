

`timescale 1ns / 1ps

module tb_traffic_light_controller;

    
    
    
    localparam CLK_PERIOD = 1000_000_000; 

    // DUT Inputs
    reg clk;
    reg reset;
    reg pedestrian_request;

    // DUT Outputs
    wire [2:0] ns_light;
    wire [2:0] ew_light;
    wire [1:0] ped_light;
    wire [2:0] current_state;
    wire       ped_latch_status;
    wire       was_in_ns_phase_status; // <-- ADD THIS LINE

    // Helper reg for $monitor
    reg [63:0] current_state_string; // 64 bits = 8 characters

    traffic_light_controller #(
        .GREEN_DURATION(10), 
        .YELLOW_DURATION(3), 
        .PED_DURATION(5)   
    ) dut (
        .clk(clk),
        .reset(reset),
        .pedestrian_request(pedestrian_request),
        .ns_light(ns_light),
        .ew_light(ew_light),
        .ped_light(ped_light),
        .current_state(current_state),
        .ped_request_latched_out(ped_latch_status),
        .was_in_ns_phase_out(was_in_ns_phase_status) 
    );

    localparam [2:0]
        S_NS_GREEN  = 3'b000,
        S_NS_YELLOW = 3'b001,
        S_EW_GREEN  = 3'b010,
        S_EW_YELLOW = 3'b011,
        S_PED_GREEN = 3'b100;

    // Clock Generator
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    // Helper logic for $monitor
    always @(current_state) begin
        current_state_string = state_to_string(current_state);
    end

    
    task wait_cycles;
        input integer n;
        begin
            repeat (n) @(posedge clk);
        end
    endtask

    // Test Scenarios
    initial begin
        $dumpfile("simulation_waves.vcd");
        $dumpvars(0, tb_traffic_light_controller);

        $display("-------------------------------------------------");
        $display("Starting Testbench for Traffic Light Controller");
        $display("-------------------------------------------------");
        $monitor("Time: %0t | State: %s | NS: %b | EW: %b | PED: %b | PedReq: %b | LATCH: %b | PHASE: %b",
                 $time, current_state_string, ns_light, ew_light, ped_light, pedestrian_request, ped_latch_status, was_in_ns_phase_status); // <-- EDIT THIS LINE

        $display("\n[Scenario 1] Reset and Normal Cycle (No Ped Request)");
        reset = 1;
        pedestrian_request = 0;
        wait_cycles(2);

        reset = 0;
        $display("Reset released. Running for 2 full cycles...");
        wait_cycles(26 * 2);

        
        $display("\n[Scenario 2] Ped Request during NS_GREEN (Tests starvation fix)");
        @(posedge clk); 
        while (current_state != S_NS_GREEN) @(posedge clk);
        
        wait_cycles(2); 
        $display("--> Issuing pedestrian request at time %0t", $time);
        pedestrian_request = 1;
        @(posedge clk);
        pedestrian_request = 0;

        $display("...Verifying FSM goes to EW_GREEN after PED_GREEN...");
        wait_cycles(8 + 3 + 5 + 10 + 2);

        $display("\n[Scenario 3] Back-to-Back Ped Request (during PED_GREEN)");
        @(posedge clk);
        while (current_state != S_NS_GREEN) @(posedge clk);
        
        wait_cycles(2);
        $display("--> Issuing 1st request at time %0t", $time);
        pedestrian_request = 1;
        @(posedge clk);
        pedestrian_request = 0;

        @(posedge clk); 
        while (current_state != S_PED_GREEN) @(posedge clk);
        
        wait_cycles(1);
        $display("--> FSM is in PED_GREEN. Issuing 2nd request at time %0t", $time);
        pedestrian_request = 1;
        @(posedge clk);
        pedestrian_request = 0;

        $display("...Verifying FSM completes full cycle before servicing 2nd request...");
        wait_cycles(4 + 10 + 3 + 5 + 5); 

        $display("\n[Testbench] All scenarios complete.");
        $finish;
    end

    
    function [63:0] state_to_string; 
        input [2:0] state;
        case (state)
            S_NS_GREEN:  state_to_string = "NS_GRN";
            S_NS_YELLOW: state_to_string = "NS_YEL";
            S_EW_GREEN:  state_to_string = "EW_GRN";
            S_EW_YELLOW: state_to_string = "EW_YEL";
            S_PED_GREEN: state_to_string = "PED_GRN";
            default:     state_to_string = "XXXXXX";
        endcase
    endfunction

endmodule