`default_nettype none
`timescale 1ns/1ns

`define STATE_INIT       4'd0
`define STATE_INPUT      4'd1
`define STATE_HIDDEN     4'd2
`define STATE_OUTPUT     4'd3

module control_unit (
    // w sram addr
    output reg [10:0] w_read_sram_addr,

    // neuron selector
    output reg [5:0] cntrl_u_out_select,                // potential write
    output reg cntrl_spk_select,                        // input layer
    output reg [5:0] cntrl_u_in_select,                 // potential read

    // accumlators
    output reg cntrl_ac_reset,                          // reset ac when changing layers
    output reg cntrl_ac_oen,                            // read ac into the neuron when ready

    //neurons
    output reg cntrl_neu_reset,                         // reset neurons (on reset) (prob useless)

    //spk procssor
    output reg [2:0] cntrl_in_spk_reg_mask,             // read in_spk input layer
    output reg cntrl_in_spk_reg_we,                     // read in_spk input layer
    output reg cntrl_proc_reset,                        // reset in_spk (prob uselss)

    //u_b_processor


    //spk_memory_controler
    output reg [8:0] cntrl_spkblty_read_addr,           // spkblty read
    output reg [8:0] cntrl_spkblty_write_addr,          // spkblty write
    output reg cntrl_spkblty_write_we,                  // spkblty write
    output reg [2:0] cntrl_ac_spk_read_switch,          // spk read
    output reg [8:0] cntrl_ac_spk_read_addr,            // spk read
    output reg [8:0] cntrl_spk_write_addr,              // spk write
    output reg cntrl_spk_write_we,                      // spk write
    output reg [8:0] cntrl_in_spk_read_addr,            // in_spk read

    //u_b_memory_controler
    output reg [8:0] cntrl_potential_read_addr,         // potential read
    output reg [8:0] cntrl_potential_write_addr,        // potential write
    output reg cntrl_potential_write_we,                // potential write
    output reg [8:0] cntrl_beta_read_addr,              // beta read

    input reg clk, reset
    );

    reg [3:0] state;
    reg [7:0] time_step;
    reg [1:0] layer;
    always @(posedge clk) begin
        case (state)
            `STATE_INIT: begin

            end
            `STATE_INPUT: begin

            end
            `STATE_HIDDEN: begin
                

            end
            `STATE_OUTPUT: begin

            end
            default:
        endcase
    end

    `ifdef COCOTB_SIM
    initial begin
    $dumpfile ("accelerator.vcd");
    $dumpvars (0, accelerator);
    #1;
    end
    `endif

endmodule
