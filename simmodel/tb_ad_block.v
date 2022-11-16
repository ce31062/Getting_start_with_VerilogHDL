// Modelsim-ASE requires a timescale directive
`timescale 1 ps / 1 ps
module tb_ad_block;
    reg     adck, reset;
    wire    [7:0]   out;  

parameter STEP = 10000; // 1time = 1ms

// Display monitor
initial $monitor($stime, "adck=%b reset=%b out=%b", adck, reset, out);

// Clock
always begin
    adck = 0; #(STEP/2);
    adck = 1; #(STEP/2);
end

// Test call
AD_block AD_block  (adck, reset, out);

// Test input
initial begin
                      reset = 1'b1;
        #(STEP)       reset = 1'b0;
        #(STEP*10)   $finish;
end
endmodule