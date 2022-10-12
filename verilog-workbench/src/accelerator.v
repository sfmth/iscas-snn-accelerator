`default_nettype none
`timescale 1ns/1ns

`include "accumulator.v"

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

    // generate 1024 accumlators
    wire ac_reset;
    genvar i;
    generate
        for (i=0;i<1024;i=i+1) begin
            accumulator acm_i(
                .w_read(),
                .spk_in(),
                .oen(),
                .accumulated_potential(),
                .clk(clk),
                .reset(ac_reset)
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
