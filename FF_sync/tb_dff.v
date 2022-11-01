`timescale 1 ps / 1 ps
module tb_dff;
    reg CK, D, LD, RES;
    wire Q;

parameter STEP = 100000; // 1time = 1ms

// Display monitor
initial $monitor($stime, "CK=%b D=%b LD=%b RES=%b Q=%b", CK, D, LD, RES, Q);

// Clock
always begin
    CK = 0; #(STEP/2);
    CK = 1; #(STEP/2);
end

// Test call
DFF DFF  (CK, D, Q, LD, RES);

// Test input
initial begin
                        RES = 1'b0; LD = 1'b0; D = 1'b0;
        #(STEP*1.25)    RES = 1'b1; // Reset
        #(STEP)         RES = 1'b0;
        #(STEP)         LD = 1'b1;  // Load
        #(STEP)         D = 1'b1;
        #(STEP)         D = 1'b0;
        #(STEP*2)   $finish;
end




endmodule
