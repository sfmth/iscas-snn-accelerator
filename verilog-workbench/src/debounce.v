`default_nettype none
`timescale 1ns/1ns

module debounce (
    input wire clk,
    input wire reset,
    input wire button,
    output reg debounced
    );
    wire out_EN, all0, all1;
    reg [7:0] shreg;
    assign out_EN = all0 | all1;

    // output flop
    always @(posedge clk) begin
        if (out_EN) begin
            debounced = (reset) ? 1'b0 : (all1) ? 1'b1 : 1'b0;
        end
    end

    // input shift register
    always @(posedge clk) begin
        if(reset) begin
            shreg <= 8'b0;
        end else begin
            shreg[7] <= button;
            shreg[6] <= shreg[7];
            shreg[5] <= shreg[6];
            shreg[4] <= shreg[5];
            shreg[3] <= shreg[4];
            shreg[2] <= shreg[3];
            shreg[1] <= shreg[2];
            shreg[0] <= shreg[1];
        end
    end

    // comparators
    assign all1 = (shreg == 8'hff) ? 1'b1 : 1'b0;
    assign all0 = (shreg == 8'h0) ? 1'b1 : 1'b0;

endmodule