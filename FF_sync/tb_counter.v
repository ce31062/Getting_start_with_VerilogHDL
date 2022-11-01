`timescale 1 ps / 1 ps
module tb_counter;
    reg             ck, res;
    wire    [3:0]   q;

parameter STEP = 100000; // 1time = 1ms

// Display monitor
initial $monitor($stime, "ck=%b res=%b q=%b", ck, res, q);

// Clock
always begin
    ck = 0; #(STEP/2);
    ck = 1; #(STEP/2);
end

// Test call
counter counter  (ck, res, q);

// Test input
initial begin
                        res = 1'b0;
        #(STEP*1.25)    res = 1'b1; // Reset
        #(STEP)         res = 1'b0;
        #(STEP*30)   $finish;
end




endmodule
