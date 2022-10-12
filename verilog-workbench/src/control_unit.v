`default_nettype none
`timescale 1ns/1ns

module control_unit (
    // neuron selector
    output wire [5:0] cntrl_u_out_select,
    output wire cntrl_spk_select,
    output wire [5:0] cntrl_u_in_select,

    // accumlators
    output wire cntrl_ac_reset,
    output wire cntrl_ac_oen,

    //neurons
    output wire cntrl_neu_reset,

    //spk procssor
    output wire [2:0] cntrl_in_spk_reg_mask,
    output wire cntrl_in_spk_reg_we,
    output wire cntrl_proc_reset,

    //u_b_processor


    //spk_memory_controler
    output wire [8:0] cntrl_spkblty_read_addr,
    output wire [2:0] cntrl_ac_spk_read_switch,
    output wire [8:0] cntrl_ac_spk_read_addr,
    output wire [8:0] cntrl_in_spk_read_addr,
    output wire [8:0] cntrl_spk_write_addr,
    output wire cntrl_spk_write_we,
    output wire [8:0] cntrl_spkblty_write_addr,
    output wire cntrl_spkblty_write_we,

    //u_b_memory_controler
    output wire [8:0] cntrl_potential_read_addr,
    output wire [8:0] cntrl_beta_read_addr,
    output wire [8:0] cntrl_potential_write_addr,
    output wire cntrl_potential_write_we,

    input wire clk, reset
    );


    `ifdef COCOTB_SIM
    initial begin
    $dumpfile ("accelerator.vcd");
    $dumpvars (0, accelerator);
    #1;
    end
    `endif

endmodule
