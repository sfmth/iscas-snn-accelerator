`default_nettype none
`timescale 1ns/1ns


`include "shift_add_mult.v"

module u_b_processor (
    // save
    input wire [127:0] save_16n_potential_in,
    input wire [15:0] save_16n_spk_in,
    output wire [127:0] save_16n_potential_out,

    //load
    output wire [127:0] load_16n_potential_out,
    input wire [127:0] load_16n_potential_in,
    input wire [63:0] load_16n_beta_in
    
    // input clk, reset
    );


    `ifdef COCOTB_SIM
    initial begin
    $dumpfile ("spk_processor.vcd");
    $dumpvars (0, spk_processor);
    #1;
    end
    `endif

endmodule
