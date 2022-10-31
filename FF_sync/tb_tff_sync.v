`timescale 1 ps / 1 ps
module tb_tff_sync;
    reg CK, EN, RB;
    wire Q;

parameter STEP = 100000; // 1time = 1ms

// Display monitor
initial $monitor($stime, "CK=%b EN=%b RB=%b Q=%b", CK, EN, RB, Q);

// Clock
always begin
    CK = 0; #(STEP/2);
    CK = 1; #(STEP/2);
end

// Test call
TFF_sync TFF_sync (CK, EN, Q, RB);

// Test input
initial begin
                        EN = 1'b0; RB = 1'b1;
        #(STEP*1.25)    RB = 1'b0; // Reset
        #(STEP)         RB = 1'b1;
        #(STEP)         EN = 1'b1; // Enable
        #(STEP)         EN = 1'b0; 
        #(STEP)         EN = 1'b1; // Enable
        #(STEP)         EN = 1'b0; 
        #(STEP*2)   $finish;
end




endmodule
