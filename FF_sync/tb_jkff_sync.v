`timescale 1 ps / 1 ps
module tb_jkff_sync;
    reg CK, J, K, RB, SB;
    wire Q;

parameter STEP = 100000; // 1time = 1ms

// Display monitor
initial $monitor($stime, "CK=%b J=%b K=%b Q=%b RB=%b SB=%b", CK, J, K, Q, RB, SB);

// Clock
always begin
    CK = 0; #(STEP/2);
    CK = 1; #(STEP/2);
end

// Test call
JKFF_sync JKFF_sync (CK, J, K, Q, RB, SB);

// Test input
initial begin
                        SB = 1'b1; RB = 1'b1; J = 1'b0; K = 1'b0;
        #(STEP*1.25)    SB = 1'b0; // Set
        #(STEP)         SB = 1'b1;
        #(STEP)         RB = 1'b0; // Reset
        #(STEP)         RB = 1'b1;
        #(STEP)         J = 1'b0; K = 1'b0;
        #(STEP)         J = 1'b0; K = 1'b1;
        #(STEP)         J = 1'b1; K = 1'b0;
        #(STEP)         J = 1'b1; K = 1'b1;
        #(STEP*2)   $finish;
end




endmodule
