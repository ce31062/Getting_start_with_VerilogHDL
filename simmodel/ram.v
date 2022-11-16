// RAM simulation model
`timescale 1 ps / 1 ps
module RAM (addr, data, ceb, web, oeb);
    input   [3:0]  addr; // Address size
    inout   [7:0]  data;
    input           ceb, web, oeb;

    reg     [7:0]   mem [0:15];
    wire            WRITE, READ;

    // write, read delay
    parameter   WDELAY = 1000, RDELAY = 1500;

    always @ (WRITE or data) begin
        #WDELAY
        if (WRITE)
            mem[addr] <= data;
    end

    assign  READ = (oeb==0) & (ceb==0);
    assign  WRITE = (web==0) & (ceb==0);

    assign #RDELAY data = READ ? mem[addr] : 8'hzz;

    initial $readmemb ("ram_data.bin", mem); // change hex to bin

endmodule