`default_nettype none
`timescale 1ns/1ns


/* `include "shift_add_mult.v" */

module spk_memory_controler (
	// spkblty read
	input wire [15:0] spkblty_read_sram,
	output wire [8:0] spkblty_read_sram_addr,

	output wire [15:0] spkblty_read_out,
	
	// AC spk read
	input wire [15:0] ac_spk_read_sram,
	output wire [8:0] ac_spk_read_sram_addr,

	output wire []
);


    `ifdef COCOTB_SIM
    initial begin
    $dumpfile ("spk_processor.vcd");
    $dumpvars (0, spk_processor);
    #1;
    end
    `endif

endmodule
