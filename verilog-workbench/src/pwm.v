`default_nettype none
`timescale 1ns/1ns

module pwm #( 
    parameter N = 8,
    parameter INV = 0
    )(
    input wire clk,
    input wire reset,
    output wire out,
    input wire [N-1:0] level
    );
    
    reg [N-1:0] counter;

    always @(posedge clk)
    begin
        if (reset)
            counter <= 8'b00000000;
        else
            counter <= counter + 1'b1;
    end

    if (!INV)
        assign out = (reset) ? 0 : (counter < level) ? 1 : 0;
    else
        assign out = (reset) ? 0 : (counter < level) ? 0 : 1;

endmodule
