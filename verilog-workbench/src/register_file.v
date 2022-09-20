`default_nettype none
`timescale 1ns/1ns

module register_file (
    input wire [4:0] address_1, address_2, address_3,
    input wire [31:0] write_data,
    output reg [31:0] read_data_1, read_data_2,
    input wire write_enable,
    input wire clk
    )
    

endmodule