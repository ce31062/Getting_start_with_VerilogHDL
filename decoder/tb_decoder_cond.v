`timescale 1 ps / 1 ps
module tb_decoder;
    reg [1:0] din ;
    wire [3:0] dout ;

parameter STEP = 100000; // 1time = 1ms

// Test call
decoder_cond decoder_cond (din, dout);

// Test input
initial begin
                din = 2'b00; 
        #STEP   din = 2'b01;
        #STEP   din = 2'b10;
        #STEP   din = 2'b11;
        #STEP   $finish;
end

// Display monitor
initial $monitor($stime, "din=%b dout=%b", din, dout);

endmodule