// Modelsim-ASE requires a timescale directive
`timescale 1 ps / 1 ps
module tb_ram;
    reg [3:0] addr;
    reg oeb, web, ceb;
    reg     [7:0] regdata; // input
    wire    [7:0]   data;  // output

assign data = regdata; // for inout

parameter STEP = 10000; // 1time = 1ms

// Display monitor
initial $monitor($stime, "addr=%b data=%b ceb=%b web=%b oeb=%b", addr, data, ceb, web, oeb);

// Test call
RAM RAM  (addr, data, ceb, web, oeb);

// Test input
initial begin
                        addr = 4'b0000; ceb = 1'b1; web = 1'b1; oeb = 1'b1; regdata = 8'bz;
        #(STEP)         ceb = 1'b0; web = 1'b0; regdata = 8'bz;
        #(STEP*0.5)     regdata = 8'b00000001;               
        #(STEP)         ceb = 1'b1; web = 1'b1; regdata = 8'bz;
        #(STEP)         ceb = 1'b0; oeb = 1'b0; addr = 4'b1001; regdata = 8'bz;
        #(STEP)         ceb = 1'b1; oeb = 1'b1; regdata = 8'bz;
        #(STEP*2)   $finish;
end
endmodule

// http://siwiz.blog.fc2.com/blog-entry-8.html