`timescale 1 ps / 1 ps
module tb_dff_sync;
    reg CK, D, LD, RB, SB;
    wire Q, QB;

parameter STEP = 100000; // 1time = 1ms

// Display monitor
initial $monitor($stime, "CK=%b D=%b LD=%b RB=%b SB=%b Q=%b QB=%b", CK, D, LD, RB, SB, Q, QB);

// Clock
always begin
    CK = 0; #(STEP/2);
    CK = 1; #(STEP/2);
end

// Test call
DFF_sync DFF_sync (CK, D, LD, Q, QB, RB, SB);

// Test input
initial begin
                        SB = 1; RB = 1; D = 0; LD = 0;
        #(STEP*1.25)    SB = 1'b0;
        #(STEP)         SB = 1'b1;
        #(STEP)         RB = 1'b0;
        #(STEP)         RB = 1'b1;
        #(STEP)         LD = 1'b1; D = 1;
        #(STEP)         LD = 1'b0;
        #(STEP*2)   $finish;
end




endmodule
