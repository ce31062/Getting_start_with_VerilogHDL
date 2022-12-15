// `timescale 1ns/1ns
`timescale 1us/1us
module tb_top_input;
    reg          resetn;
    reg [3:0]    colin;
    wire [2:0]   rowout;
    wire [3:0]   keycode;
    wire [3:0]   sftreg;


    
    // Setting 1000units/1cycle
    // parameter STEP = 100000; // 1us
    parameter STEP = 1000; // 1ms
    // Electronic lock cal
    top_input top_input (orgclk, resetn, ck, hz512, hz32, colin, rowout, keycode, keyenbl, ke1, ke2, sftreg);

    // Test input
    initial begin
                    resetn = 1; colin = 0;
        #(STEP)     resetn = 0;
        #(STEP)     resetn = 1;
        #(STEP*500)     colin[0] = 1;
        #(STEP*500)     colin[0] = 0;
        #(STEP*500)     colin[1] = 1;
        #(STEP*500)     colin[1] = 0;
        #(STEP*500)     colin[2] = 1;
        #(STEP*500)     colin[2] = 0;
        #(STEP*500)     colin[3] = 1;
        #(STEP*500)     colin[3] = 0;
        #(STEP*100)   $finish;
    end

    // Display
    initial $monitor($stime, "resetn = %b ck = %b hz32 = %b keyenbl = %b colin = %b rowout = %b keycode = %b ke1 = %b ke2 = %b sftreg = %b"
    , resetn, ck, hz32, keyenbl, colin[3], colin[2], colin[1], colin[0], rowout[2], rowout[1], rowout[0], keycode[3], keycode[2], keycode[1], keycode[0], ke1, ke2, sftreg[3],, sftreg[2], sftreg[1], sftreg[0] );
endmodule