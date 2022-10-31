`timescale 1 ps / 1 ps
module tb_srff_sync;
    reg CK, SB, RB;
    wire Q, QB;

parameter STEP = 100000; // 1time = 1ms

// Display monitor
initial $monitor($stime, "CK=%b RB=%b SB=%b Q=%b QB=%b", CK, RB, SB, Q, QB);

// Clock
always begin
    CK = 0; #(STEP/2);
    CK = 1; #(STEP/2);
end

// Test call
SRFF_sync SRFF_sync (CK, SB, RB, Q, QB);

// Test input
initial begin
                        SB = 0; RB = 0;
        #(STEP*1.25)    RB = 1'b1;
        #(STEP)     RB = 1'b0;
        #(STEP)     SB = 1'b1;
        #(STEP)     SB = 1'b0;
        #(STEP*2)   $finish;
end




endmodule
