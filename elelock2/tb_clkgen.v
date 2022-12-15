`timescale 1ns/1ns
module tb_clkgen;
    reg         resetn;
    
    // Setting 100000units/1cycle
    parameter STEP = 100000; // 1us

    // Electronic lock cal
    clkgen clkgen ( orgclk, resetn, ck, hz512, hz32 );

    // Test input
    initial begin
                    resetn = 1;
        #(STEP)     resetn = 0;
        #(STEP)     resetn = 1;

        #(STEP*1000)   $finish;
    end

    // Display
    initial $monitor($stime, "ck = %b hz32 = %b  hz512 = %b", ck, hz32, hz512);
endmodule