`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2024 06:19:47 PM
// Design Name: 
// Module Name: tb_Rx_FSM
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


module tb_Rx_FSM;
    logic clk, reset_n;
    logic start_Rx, count_samples_f, count_bits_f;
    logic  en_samples_count, en_bits_count, enRx_out_reg, clear_samples_count, clear_bits_count;
    
    Rx_FSM dut (.*);
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        start_Rx = 0; count_samples_f = 0; count_bits_f = 0;
        reset_n = 0; #10; reset_n = 1; #30;
        
        start_Rx = 1; #10; start_Rx = 0;
        count_samples_f = 1; #10; count_samples_f = 0; 
        count_bits_f = 1; #10; count_bits_f = 0;
         
        $finish;
    end
endmodule
