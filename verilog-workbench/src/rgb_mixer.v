`default_nettype none
`timescale 1ns/1ns
module rgb_mixer (
    input clk,
    input reset,
    input enc0_a,
    input enc0_b,
    input enc1_a,
    input enc1_b,
    input enc2_a,
    input enc2_b,
    output pwm0_out,
    output pwm1_out,
    output pwm2_out 
    );
    // 0=r 1=g 2=b

    //debouncy stage r
    wire dbnc0a, dbnc0b;
    debounce dbnc0_a(clk, reset, enc0_a, dbnc0a);
    debounce dbnc0_b(clk, reset, enc0_b, dbnc0b);

    //debouncy stage g
    wire dbnc1a, dbnc1b;
    debounce dbnc1_a(clk, reset, enc1_a, dbnc1a);
    debounce dbnc1_b(clk, reset, enc1_b, dbnc1b);

    //debouncy stage g
    wire dbnc2a, dbnc2b;
    debounce dbnc2_a(clk, reset, enc2_a, dbnc2a);
    debounce dbnc2_b(clk, reset, enc2_b, dbnc2b);


    //encoder stage r
    wire [7:0] enc0;
    encoder enc_0(clk, reset, dbnc0a, dbnc0b, enc0);

    //encoder stage g
    wire [7:0] enc1;
    encoder enc_1(clk, reset, dbnc1a, dbnc1b, enc1);

    //encoder stage b
    wire [7:0] enc2;
    encoder enc_2(clk, reset, dbnc2a, dbnc2b, enc2);


    //pwm stage r
    pwm pwm_0(clk, reset, pwm0_out, enc0);

    //pwm stage g
    pwm pwm_1(clk, reset, pwm1_out, enc1);

    //pwm stage b
    pwm pwm_2(clk, reset, pwm2_out, enc2);

    `ifdef COCOTB_SIM
    initial begin
    $dumpfile ("rgb_mixer.vcd");
    $dumpvars (0, rgb_mixer);
    #1;
    end
    `endif
endmodule
