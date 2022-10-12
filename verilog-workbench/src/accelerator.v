`default_nettype none
`timescale 1ns/1ns

`include "accumulator.v"
`include "neuron_selector.v"
`include "neuron.v"
`include "spk_processor.v"
`include "u_b_processor.v"
`include "u_b_memory_controler.v"
`include "spk_memory_controler.v"

module accelerator (
    input wire [2047:0] w_read_sram,

    input wire [127:0] u_read_sram,
    output wire [8:0] u_read_sram_addr,
    output wire [127:0] u_write_sram,
    output wire [8:0] u_write_sram_addr,

    input wire [15:0] spk_read_sram,
    output wire [8:0] spk_read_sram_addr,
    output wire [15:0] spk_write_sram,
    output wire [8:0] spk_write_sram_addr,
    output wire spk_write_sram_we,

    input wire [15:0] spkblty_read_sram,
    output wire [8:0] spkblty_read_sram_addr,
    output wire [15:0] spkblty_write_sram,
    output wire [8:0] spkblty_write_sram_addr,
    output wire spkblty_write_sram_we,

    input wire [127:0] in_spk_read_sram,
    output wire [8:0] in_spk_read_sram_addr,

    input wire [63:0] b_read_sram,
    output wire [8:0] b_read_sram_addr,

    input wire clk, reset
    );

    //neurons I/O selector
    neuron_selector ns(
        .potential_out_all(neu_ns_u),
        .potential_out_16n(),
        .cntrl_potential_out_sel(),

        .spk_out(ns_ac_spk),
        .in_spk(),
        .processed_spk(),
        .cntrl_spk_select(),

        .potential_in_16n(),
        .potential_in_all(ns_neu_u_in),
        .potential_in_ien_all(ns_neu_u_ien),
        .cntrl_potential_in_sel()
    );

    wire [2047:0] ns_ac_spk;
    wire [1023:0] ns_neu_u_ien;
    wire [8191:0] neu_ns_u;
    wire [8191:0] ns_neu_u_in;

    // generate 1024 accumlators
    wire cntrl_ac_reset;
    wire cntrl_ac_oen;
    genvar i;
    generate
        for (i=0;i<1024;i=i+1) begin
            accumulator acm_i(
                .w_read(w_read_sram[(i*2)+1:i*2]),
                .spk_in(ns_ac_spk),
                .oen(cntrl_ac_oen),
                .accumulated_potential(ac_neu_u[(i*8)+7:i*8]),
                .clk(clk),
                .reset(cntrl_ac_reset)
            );
        end
    endgenerate

    wire [8191:0] ac_neu_u;

    // generate 1024 neurons
    wire cntrl_neu_reset;
    genvar j;
    generate
        for (j=0;j<1024;j=j+1) begin
            neuron neu(
                .potential_accumulated(ac_neu_u[(j*8)+7:j*8]),
                .potential_previous(neu_ns_u_in[(j*8)+7:j*8]),
                .potential_final(neu_ns_u[(j*8)+7:j*8]),
                .ien(ns_neu_u_ien[j]),
                .clk(clk),
                .reset(cntrl_neu_reset)
            );
        end
    endgenerate


    `ifdef COCOTB_SIM
    initial begin
    $dumpfile ("accelerator.vcd");
    $dumpvars (0, accelerator);
    #1;
    end
    `endif

endmodule
