// A/D conversion simulation model
`timescale 1 ps / 1 ps
module AD_block (adck, reset, out);
    input           adck, reset;
    output  [7:0]   out;

    parameter   LINENUM = 9; // change line pixels
    parameter   OUTDELAY = 1000;

    reg [9:0]   addr;
    
    // 1-line memory
    reg [7:0]   mem[0:LINENUM-1];

    always  @(posedge adck) begin
        if (reset)
            addr <= 0;
        else
            addr <= addr + 1;
    end

    assign #OUTDELAY out = mem[addr];
    
    // File load at simulation start
    initial $readmemb ("ad_data.bin", mem);

endmodule