// Modelsim-ASE requires a timescale directive
`timescale 1 ps / 1 ps
module tb_da_block;
    reg     dack, reset, we;
    reg     [7:0]   din; 
    reg     outflag;

parameter STEP = 10000; // 1time = 1ms

// Display monitor
initial $monitor($stime, "dack=%b reset=%b we=%b  din=%b outflag=%b", dack, reset, we, din, outflag);

// Clock
always begin
    dack = 0; #(STEP/2);
    dack = 1; #(STEP/2);
end

// Test call
DA_block DA_block  (dack, reset, we, din, outflag);

// Test input
initial begin
                      reset = 1'b1; we = 1'b0; outflag = 1'b0;
                      din = 8'b0000_0000;
        #(STEP)       reset = 1'b0;
        #(STEP/2)     we    = 1'b1;
        #(STEP)       din   = 8'b0000_0001;
        #(STEP)       din   = 8'b0000_0010;
        #(STEP)       din   = 8'b0000_0011;
        #(STEP)       din   = 8'b0000_0100;
        #(STEP)       din   = 8'b0000_0101;        
        #(STEP)       din   = 8'b0000_0110;        
        #(STEP)       din   = 8'b0000_0111;
        #(STEP)       din   = 8'b0000_1000;   
        #(STEP)       we = 1'b0;             
        #(STEP)       outflag = 1'b1;        
        #(STEP*5)   $finish;
end
endmodule