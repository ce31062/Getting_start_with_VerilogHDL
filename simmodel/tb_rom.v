// Modelsim-ASE requires a timescale directive
`timescale 1 ps / 1 ps
module tb_rom;
    reg [3:0] addr;
    reg oeb;
    wire [7:0] data;

parameter STEP = 10000; // 1time = 1ms

// Display monitor
initial $monitor($stime, "addr=%b data=%b oeb=%b", addr, data, oeb);

// Test call
ROM ROM  (addr, data, oeb);

// Test input
initial begin
                        addr = 4'b0000; oeb = 1'b1;
        #(STEP)         oeb = 1'b0;                
        #(STEP*1.25)    addr = 4'b0001;
        #(STEP)         addr = 4'b0010;
        #(STEP)         addr = 4'b0011;
        #(STEP)         addr = 4'b0100;
        #(STEP)         addr = 4'b0101;
        #(STEP)         addr = 4'b0110;
        #(STEP)         addr = 4'b0111;
        #(STEP)         addr = 4'b1000;
        #(STEP)         addr = 4'b1001;
        #(STEP)         addr = 4'b1010;
        #(STEP)         addr = 4'b1011;
        #(STEP)         addr = 4'b1100;
        #(STEP)         addr = 4'b1101;
        #(STEP)         addr = 4'b1110;
        #(STEP)         addr = 4'b1111;
        
        #(STEP*2)   $finish;
end
endmodule
