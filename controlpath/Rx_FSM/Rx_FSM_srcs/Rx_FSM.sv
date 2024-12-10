`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2024 03:45:29 PM
// Design Name: 
// Module Name: Rx_FSM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Rx_FSM(
    input logic clk,
    input logic reset_n,
    input logic start_Rx,
    input logic count_samples_f, // flag when sample_count = 15
    input logic count_bits_f, // flag when bit_count = 9
    output logic en_samples_count,
    output logic en_bits_count,
    output logic enRx_out_reg,
    output logic clear_samples_count,
    output logic clear_bits_count

    );
    typedef enum logic [1:0] {
        IDLE,
        start,
        detect
    } state_t;
    
    state_t current_state, next_state;
    
    // State transition:
    always_ff @(posedge clk, negedge reset_n) begin
        if (!reset_n)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end
    
    // Next-state logic:
    always_comb begin
        case (current_state)
            IDLE: begin
                if (start_Rx)
                    next_state = start;
                else
                    next_state = IDLE;
            end
            start: begin
                if (count_samples_f)
                    next_state = detect;
                else
                    next_state = start;    
            end
            detect: begin
                if (count_bits_f)
                    next_state = IDLE;
                else
                    next_state = start;
            end
            default: next_state = IDLE;
        endcase
    end
    
    // Output logic:
    always_comb begin
        case (current_state)
            IDLE: begin
                en_samples_count = 0;
                en_bits_count = 0;
                clear_samples_count = 0;
                clear_bits_count = 0;
                enRx_out_reg = 0;
            end
            start: begin
                en_samples_count = 1;
                en_bits_count = 0;
                if (count_samples_f) clear_samples_count = 1;
                clear_bits_count = 0;
                enRx_out_reg = 0;
            end
            detect: begin
                en_samples_count = 0;
                en_bits_count = 1;
                clear_samples_count = 0;
                if (count_bits_f) clear_bits_count = 1;
                enRx_out_reg = 1;
            end
            default: begin
                en_samples_count = 0;
                en_bits_count = 0;
                clear_samples_count = 0;
                clear_bits_count = 0;
                enRx_out_reg = 0;
            end
         endcase   
    end
    
endmodule
