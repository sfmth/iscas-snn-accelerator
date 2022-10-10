`default_nettype none
`timescale 1ns/1ns


/* `include "shift_add_mult.v" */

module neuron_selector(
    // generated potential by neurons:
    // output potential selector
    input wire [8191:0] potential_out_all,
    output wire [127:0] potential_out_16n,
    input wire [5:0] cntrl_potential_out_sel,

    // accumulator input spk selector
    output wire [2047:0] spk_out,
    input wire [1023:0] in_spk,
    input wire [1:0] processed_spk,

    // existing potential from the previous time step:
    // input potential
    input wire [127:0] potential_in_16n,
    output wire [8191:0] potential_in_all,
    output wire [1023:0] potential_in_ien_all,

    input wire [5:0] cntrl_potential_in_sel,
    input wire cntrl_potential_in_ien
    );

    // potential out selector
    reg [127:0] potential_out [0:63];

    genvar i;
    generate
        for (i=0;i<64;i=i+1) begin
            assign potential_out[i] = potential_out_all[(i*128)+127:i*128];
        end
    endgenerate

    assign potential_out_16n = potential_out[cntrl_potential_out_sel];

    // potential in selector

    genvar j;
    generate
        for (j=0;j<64;j=j+1) begin
            assign potential_in_all[(j*128)+127:j*128] = (cntrl_potential_in_sel == j) ?
                potential_in_16n : 128'bx;
        end
    endgenerate

    genvar k;
    generate
        for (k=0;k<64;k=k+1) begin
            assign potential_in_ien_all[(k*16)+15:k*16] = (cntrl_potential_in_sel == k) ?
                16'b1111111111111111 : 16'b0;
        end
    endgenerate




    /* genvar i; */
    /* generate */
    /*     for (i=0;i<64;i=i+1) begin */
    /*         if (cntrl_potential_out_sel == i) */
    /*             assign potential_out_16n = potential_out_all[(i*128)+127:i*128]; */
    /*     end */
    /* endgenerate */





    /* int i; */
    /* always @(*) begin */
    /*     for (i=0;i<64;i=i+1) begin */
    /*         if (cntrl_potential_out_sel == i) */
    /*             potential_out_16n = potential_out_all[i*128+:i*128]; */
    /*     end */
    /* end */


    `ifdef COCOTB_SIM
    initial begin
    $dumpfile ("neuron_selector.vcd");
    $dumpvars (0, neuron_selector);
    #1;
    end
    `endif

endmodule

