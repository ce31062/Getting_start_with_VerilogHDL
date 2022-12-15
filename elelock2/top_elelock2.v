/* Extended Electronical Lock */
module top_elelock2 (orgclk, resetn, colin, rowout, lock,
                    common, segment, sw, state, regout);
    input           orgclk;
    input           resetn;
    input   [3:0]   colin;
    output  [2:0]   rowout;
    output          lock;
    output  [4:0]   common;
    output  [6:0]   segment;

    input   [2:0]   sw;
    output  [2:0]   state;
    output  [3:0]   regout;

    /* Signals between modules */
    wire    [3:0]   keycode;
    wire            keyenbl;
    wire            ck, hz512, hz32;
    wire    [3:0]   dig4, dig3, dig2, dig1, dig0;
    wire    [4:0]   dispen;

    assign  reset = ~resetn;
    
    /* Connection to each modules */
    clkgen clkgen  ( orgclk, resetn, ck, hz512, hz32 );
    keyscan keyscan  (ck, resetn, hz32, colin, rowout, keycode, keyenbl, ke1, ke2, sftreg);
    elelock2 elelock2  (ck, resetn, hz32, keycode, keyenbl,lock, dig4, dig3,dig2, dig1, dig0, dispen, sw, state, regout);
    display display (ck, resetn, hz512, dig4, dig3, dig2, dig1, dig0, dispen, common, segment);
endmodule
