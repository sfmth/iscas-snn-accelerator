`default_nettype none
`timescale 1ns/1ns


/* `include "shift_add_mult.v" */

module neuron_selector(
    // generated potential by neurons:
    // output potential selector
    input [8191:0] potential_out_all,
    output [127:0] potential_out_16n,
    input [5:0] cntrl_potential_out_sel,

    // accumulator input spk selector
    output [2047:0] spk_out,
    input [1023:0] in_spk,
    input [1:0] processed_spk,

    // 
    // input potential 







    //potential read
    input wire [127:0] potential_read_sram,
    output wire [8:0] potential_read_sram_addr,

    output wire [127:0] potential_read_out,

    input wire [8:0] cntrl_potential_read_addr,

    //beta read
    input wire [63:0] beta_read_sram,
    output wire [8:0] beta_read_sram_addr,

    output wire [63:0] beta_read_out,

    input wire [8:0] cntrl_beta_read_addr,

    // potential write
    output wire [127:0] potential_write_sram,
    output wire [8:0] potential_write_sram_addr,

    input wire [127:0] potential_write_in,

    input wire [8:0] cntrl_potential_write_addr
    );

    //potential read
    assign potential_read_out = potential_read_sram;
    assign potential_read_sram_addr = cntrl_potential_read_addr;

    //beta read
    assign beta_read_out = beta_read_sram;
    assign beta_read_sram_addr = cntrl_beta_read_addr;

    //potential write
    assign potential_write_sram = potential_write_in;
    assign potential_write_sram_addr = cntrl_potential_write_addr;

    `ifdef COCOTB_SIM
    initial begin
    $dumpfile ("neuron_selector.vcd");
    $dumpvars (0, neuron_selector);
    #1;
    end
    `endif

endmodule

