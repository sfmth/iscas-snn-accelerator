`default_nettype none
`timescale 1ns/1ns

// there is no need for this module
// yikes!

`define THRESH_LOW      8'd200
`define THRESH_HIGH     8'd230

module schmitt_trigger (
    input wire [7:0] potential,
    output reg spk,
    output reg spkblty
    );

    always @(*) begin
        if (potential < `THRESH_LOW) begin
            
        end
    end

    `ifdef COCOTB_SIM 
    initial begin
    $dumpfile ("schmitt_trigger.vcd");
    $dumpvars (0, schmitt_trigger);
    #1;
    end
    `endif

endmodule