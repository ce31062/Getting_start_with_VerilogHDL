/* Display */
module  display (ck, resetn, hz512, dig4, dig3, dig2, dig1, dig0, dispen, common, segment);
    input   ck;
    input   resetn;
    input   hz512;
    input   [3:0]   dig4, dig3, dig2, dig1, dig0;
    input   [4:0]   dispen;
    output  [4:0]   common;
    output  [6:0]   segment;

    assign  reset = ~resetn;

    /* Ring-counter for display */
    reg     [3:0]   cnt;
    wire    [4:0]   ring = {cnt, ~|cnt};

    always @(posedge ck or posedge reset) begin
        if (reset)
            cnt <= 4'h0;
        else if (hz512)
            cnt <= ring[3:0];
    end

    assign  common = ring & dispen;

    /* 7segment-decoder */
    function    [6:0] segdec;
    input   [3:0]   din;
    begin
        case (din)
            4'h0    :  segdec = 7'b1111110;
            4'h1    :  segdec = 7'b0110000;
            4'h2    :  segdec = 7'b1101101;
            4'h3    :  segdec = 7'b1111001;
            4'h4    :  segdec = 7'b0110011;
            4'h5    :  segdec = 7'b1011011;
            4'h6    :  segdec = 7'b1011111;
            4'h7    :  segdec = 7'b1110010;
            4'h8    :  segdec = 7'b1111111;
            4'h9    :  segdec = 7'b1111011;
            4'ha    :  segdec = 7'b0000001; // '-'
            4'hb    :  segdec = 7'b0001110; // 'L'
            4'hc    :  segdec = 7'b1001110; // 'C'
            4'hd    :  segdec = 7'b0010101; // 'n'
            4'he    :  segdec = 7'b1001111; // 'E'
            4'hf    :  segdec = 7'b1100111; // 'P'
            default :  segdec = 7'bxxxxxxx;
        endcase
    end
    endfunction

    /* Segment output */
    reg [6:0]   segment;

    always @(common or dig4 or dig3 or dig2 or dig1 or dig0) begin
        case (common)
            5'b00001: segment <= segdec (dig0);
            5'b00010: segment <= segdec (dig1);
            5'b00100: segment <= segdec (dig2);
            5'b01000: segment <= segdec (dig3);
            5'b10000: segment <= segdec (dig4);
            default : segment <= 7'bxxxxxxx;
        endcase
    end
endmodule