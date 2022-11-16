// ROM simulation model
`timescale 1 ps / 1 ps
module ROM (addr, data, oeb);
    input   [3:0]  addr;  // change memory address length
    output   [7:0]  data;
    input           oeb;

    reg     [7:0]   mem [0:15];

   // Read delay
    parameter RDELAY = 1500;

    assign  #RDELAY data = (oeb==0) ? mem[addr] :8'hzz;

    // File load at simulation start
    initial $readmemb ("rom_data.bin", mem); // change hex to bin
endmodule