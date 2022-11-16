// D/A conversion simulation model
`timescale 1 ps / 1 ps
module DA_block (dack, reset, we, din, outflag);
    input           dack, reset, we;
    input   [7:0]   din;
    input           outflag;
    parameter   LINENUM = 9; // chenge line pixels

    reg     [9:0]   addr;
    reg     [7:0]   mem[0:LINENUM-1];
    // reg             outflag_;

    integer         i, mcd;
    // parameter DELAY = 120000;

    always @ (posedge dack) begin
        if (reset)
            addr <= 0;
        else if (we) begin
            mem[addr] <= din;
            addr      <= addr + 1;
        end
        // else if (outflag) begin
            // outflag_ <= outflag;
        // end
    end

    // Decimal output to file
    // Output when outputflag is set to 1 on the calling module side
    initial begin
        wait (outflag);
        mcd = $fopen ("DA_out.dat");
        for (i=0; i<LINENUM; i=i+1)
            $fdisplay (mcd, "%b", mem[i]);
        $fclose (mcd);
    end
endmodule
