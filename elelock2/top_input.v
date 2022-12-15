/* Top module for input including clkgen and tenkey */
module top_input (orgclk, resetn, ck, hz512, hz32, colin, rowout, keycode, keyenbl, ke1, ke2, sftreg);
	input   resetn;
    output  ck;
	output	hz512;
	output	hz32;
	output	orgclk;
    input   [3:0]   colin;
    output  [2:0]   rowout;
    output  [3:0]   keycode;
    output          keyenbl;
    output          ke1, ke2;
    output  [3:0]   sftreg;

    /* module call */
    keyscan keyscan (ck, resetn, hz32, colin, rowout, keycode, keyenbl, ke1, ke2, sftreg);
    clkgen clkgen ( orgclk, resetn, ck, hz512, hz32 );

endmodule

