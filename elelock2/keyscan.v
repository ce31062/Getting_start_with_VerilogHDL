/* Tenkey Input */
module  keyscan (ck, resetn, hz32, colin, rowout, keycode, keyenbl, ke1, ke2, sftreg);
    input           ck;
    input           resetn;
    input           hz32;
    input   [3:0]   colin;
    output  [2:0]   rowout;
    output  [3:0]   keycode;
    output          keyenbl;
    output          ke1, ke2; // add
    output  [3:0]   sftreg; // add

    reg     [3:0]   keycode;
    assign  reset = ~resetn;

    /* 4-bit shift-register for keyscan */
    reg     [3:0]   sftreg;

    always  @(posedge ck or posedge reset) begin
        if (reset)
            sftreg <= 4'h0;
        else
            sftreg <= {sftreg[2:0], hz32};
    end

    /* Use lower 3-bit of shift-register for keyscan */
    assign  rowout = sftreg[2:0];

    /* ON/OFF holding register for each key */
    reg [3:0]   row0, row1, row2; // debug

    /* Keep line 1 */
    always  @(posedge ck or posedge reset) begin
        if (reset)
            row0 <= 4'h0;
        else if (sftreg[0])
            row0 <= colin;
    end

    /* keep line 2 */
    always  @(posedge ck or posedge reset) begin
        if (reset)
            row1 <= 4'h0;
        else if (sftreg[1])
            row1 <= colin;
    end

    /* keep line 3 */
    always  @(posedge ck or posedge reset) begin
        if (reset)
            row2 <= 4'h0;
        else if (sftreg[2])
            row2 <= colin;
    end

    /* key encode */
    reg [3:0]   keyenc;
    always @(row0 or row1 or row2) begin
        if  (row0[0])
            keyenc <= 4'h9;
        else if (row0[1])
            keyenc  <= 4'h8;
        else if (row0[2])
            keyenc  <= 4'h7;
        else if (row0[3])
            keyenc  <= 4'he;
        else if (row1[0])
            keyenc  <= 4'h6;
        else if (row1[1])
            keyenc  <= 4'h5;
        else if (row1[2])
            keyenc  <= 4'h4;
        else if (row1[3])
            keyenc  <= 4'hc;
        else if (row2[0])
            keyenc  <= 4'h3;
        else if (row2[1])
            keyenc  <= 4'h2;
        else if (row2[2])
            keyenc  <= 4'h1;
        else if (row2[3])
            keyenc  <= 4'h0;
        else
            keyenc <= 4'hf;
    end

    /* Create keycode output */
    always @(posedge ck or posedge reset) begin
        if (reset)
            keycode <= 4'h0;
        else if (sftreg[3])
            keycode <= keyenc;
    end
    
    /* Eliminate chattering and create keyenb output */
    reg ke1, ke2;
    always @(posedge ck or posedge reset) begin
        if (reset) begin
            ke1 <= 1'b0;
            ke2 <= 1'b0;
        end
        else if (sftreg[3]) begin
            ke2 <= ke1;
            ke1 <= |( row0 | row1 | row2);
        end
    end
    assign keyenbl = ke1 & ~ke2 & hz32;
endmodule
        
        
        
        
        
        
        