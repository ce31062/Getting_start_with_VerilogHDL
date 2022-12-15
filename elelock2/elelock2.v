/* Extended Electrical Lock */
module elelock2 (ck, resetn, hz32, keycode, keyenbl,lock,
                dig4, dig3,dig2, dig1, dig0, dispen, sw, state, regout);
    input           ck;
    input           resetn;
    input           hz32;
    input   [3:0]   keycode;
    input           keyenbl;
    output          lock;
    output  [3:0]   dig4, dig3, dig2, dig1, dig0;
    output  [4:0]   dispen;
    input   [2:0]   sw;
    output  [2:0]   state;
    output  [2:0]   regout;

    assign  reset = ~resetn;

    /* State value */
    parameter HALT=3'h0, MEMNUMIN=3'h1, OPENST=3'h2, CLOSE=3'h3,
              SECNUMIN=3'h4, MATCHDSP=3'h5;
    
    reg [2:0]   cur_st;
    reg [2:0]   next_st;

    wire        memkey = (keycode==4'he) && keyenbl;
    wire        clskey = (keycode==4'hc) && keyenbl;
    wire      validkey = (keycode==4'h9) && keyenbl;

    /* 4 seconds counter */
    reg [6:0]   sec4;

    always @(posedge ck or posedge reset) begin
        if (reset)
            sec4 <= 7'h00;
        else if (keyenbl && (cur_st != MATCHDSP))
            sec4 <= 7'h00;
        else if (hz32)
            sec4 <= sec4 + 7'h01;
    end

    wire nokey   = (sec4  ==7'h7f);
    wire halfsec = (sec4[3:0]==4'hf);
    wire hz8     = sec4[1];
    wire filled, match;

    /* State register */
    always @(posedge ck or posedge reset) begin
        if (reset)
            cur_st <= HALT;
        else
            cur_st <= next_st;
    end

    /* State generate circuit */
    always@ (cur_st or validkey or filled or nokey or clskey or memkey or match or halfsec)
    begin
        case (cur_st)
            HALT:     if (validkey)
                        next_st <= MEMNUMIN;
                      else
                        next_st <= HALT;
            MEMNUMIN: if (memkey && filled)
                        next_st <= OPENST;
                      else if (nokey)
                        next_st <= HALT;
                      else
                        next_st <= MEMNUMIN;
            OPENST:   if (clskey)
                        next_st <= CLOSE;
                      else
                        next_st <= OPENST;
            CLOSE:    if (validkey)
                        next_st <= SECNUMIN;
                      else
                        next_st <= CLOSE;
            SECNUMIN: if (match)
                        next_st <= MATCHDSP;
                      else if (nokey)
                        next_st <= CLOSE;
                      else
                        next_st <= SECNUMIN;
            MATCHDSP: if (halfsec)
                        next_st <= OPENST;
                      else
                        next_st <= MATCHDSP;
            default:  next_st <= HALT;
        endcase
    end
    /* Key input register */
    reg [3:0]   key [0:3];

    always @(posedge ck or posedge reset) begin
        if (reset) begin
            key[3] <= 4'b1111;
            key[2] <= 4'b1111;
            key[1] <= 4'b1111;
            key[0] <= 4'b1111;
        end
        else if (((cur_st==MEMNUMIN || cur_st==SECNUMIN) && nokey) || (cur_st==OPENST && clskey) ) begin
            key[3] <= 4'b1111;
            key[2] <= 4'b1111;
            key[1] <= 4'b1111;
            key[0] <= 4'b1111;
        end
        else if (validkey && (cur_st != MATCHDSP)) begin
            key[3] <= key[2];
            key[2] <= key[1];
            key[1] <= key[0];
            key[0] <= keycode;
        end
    end

    /* 4 digits entered */
    assign filled = (key[3] != 4'hf);

    /* PIN register */
    reg [3:0]   secret [0:3];
    wire        mem_set;
    assign mem_set = filled && (cur_st==MEMNUMIN) && memkey;

    always @(posedge ck or posedge reset) begin
        if (reset) begin
            secret[3] <= 4'b1111;
            secret[2] <= 4'b1111;
            secret[1] <= 4'b1111;
            secret[0] <= 4'b1111;
        end
        else if (mem_set) begin
            secret[3] <= key[3];
            secret[2] <= key[2];
            secret[1] <= key[1];
            secret[0] <= key[0];
        end
    end
    /* PIN match signal */
    assign match = (key[0]==secret[0]) && (key[1]==secret[1]) && (key[2]==secret[2]) && (key[3]==secret[3]);

    /* Electronic lock output */
    reg lock;
    always @(posedge ck or posedge reset) begin
        if (reset)
            lock <= 1'b0;
        else if (cur_st==CLOSE)
            lock <= 1'b1;
        else if (match==1'b1)
            lock <= 1'b0;
    end

    /* Display output */
    reg [3:0]   dig4, dig3, dig2, dig1, dig0;
    reg [4:0]   dispen;
    wire    [4:0]   numdisp = {1'b0, (key[3] != 4'hf), (key[2]!=4'hf), (key[2]!=4'hf), 1'b1};

    always @(cur_st or key[3] or key[2] or key[1] or key[0] or numdisp or hz8)
    begin
        case (cur_st)   
            HALT:      begin
                            dispen <= 5'b01111;
                            dig4 <= 4'h0; dig3 <= 4'ha; dig2 <= 4'ha;
                            dig1 <= 4'ha; dig0 <= 4'ha;
                        end
            MEMNUMIN:   begin
                            dispen <= numdisp;
                            dig4 <= 4'h0; dig3 <= key[3]; dig2 <= key[2];
                            dig1 <= key[1]; dig0 <= key[0];
                        end
            OPENST:     begin
                            dispen <= 5'b01111;
                            dig4 <= 4'h0; dig3 <= 4'h0; dig2 <= 4'hf;
                            dig1 <= 4'he; dig0 <= 4'hd;
                        end
            CLOSE:      begin
                            dispen <= 5'b11111;
                            dig4 <= 4'hc; dig3 <= 4'hb; dig2 <= 4'h0;
                            dig1 <= 4'h5; dig0 <= 4'he;
                        end
            SECNUMIN:   begin
                            dispen <= numdisp;
                            dig4 <= 4'h0; dig3 <= key[3]; dig2 <= key[2];
                            dig1 <= key[1]; dig0 <= key[0];
                        end
            MATCHDSP:   begin
                            if (hz8)
                                dispen <= numdisp;
                            else
                                dispen <= 5'b00000;
                            dig4 <= 4'h0; dig3 <= 4'ha; dig2 <= 4'ha;
                            dig1 <= 4'ha; dig0 <= 4'ha;
                        end
        endcase
    end

    /* Internal signal display (debug) */
    assign regout = (sw[2]==1'b1) ? secret[sw[1:0]]: key[sw[1:0]];
    assign state = cur_st;
endmodule

