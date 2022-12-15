`timescale 1us/1us
module tb_display;
    reg          resetn;
    reg  [3:0]   dig4, dig3, dig2, dig1, dig0;
    reg  [4:0]   dispen;
    wire [4:0]   common;
    wire [6:0]   segment;
    wire         hz512;
    wire         ck;

    assign  reset = ~resetn;
    parameter STEP = 1000; // 1ms

    // Call module
    display display (ck, resetn, hz512, dig4, dig3, dig2, dig1, dig0, dispen, common, segment);
    clkgen clkgen ( orgclk, resetn, ck, hz512, hz32 );

    /* Convert segment pattern to character */
    reg [7:0]   seg;

    always @(segment) begin
        case (segment)
            7'b1111110: seg = "0";
            7'b0110000: seg = "1";
            7'b1101101: seg = "2";
            7'b1111001: seg = "3";
            7'b0110011: seg = "4";
            7'b1011011: seg = "5";
            7'b1011111: seg = "6";
            7'b1110010: seg = "7";
            7'b1111111: seg = "8";
            7'b1111011: seg = "9";
            7'b0000001: seg = "-";
            7'b0001110: seg = "L";
            7'b1001110: seg = "C";
            7'b0010101: seg = "n";
            7'b1001111: seg = "E";
            7'b1100111: seg = "P";
            default:    seg = "?";
        endcase
    end

    initial begin
                dispen = 5'b11111;
                resetn = 0;
    #STEP       resetn = 1;
    #(STEP*20);
                dig4=4'h0; dig3=4'h1; dig2=4'h2; dig1=4'h3; dig0=4'h4;
    #(STEP*20);
                dig4=4'h5; dig3=4'h6; dig2=4'h7; dig1=4'h8; dig0=4'h9;
    #(STEP*20);  
                dig4=4'ha; dig3=4'hb; dig2=4'hc; dig1=4'hd; dig0=4'he;
    #(STEP*20);  
                dig4=4'hc; dig3=4'hb; dig2=4'h0; dig1=4'h5; dig0=4'he; // CLOSE
    #(STEP*20);  
                dispen = 5'b01111;
                dig4=4'h0; dig3=4'h0; dig2=4'hf; dig1=4'he; dig0=4'hd; // OPEn
    #(STEP*20);  
                dispen = 5'b00000;
    #(STEP*20);
                $finish;
    end
    
    // Display
    // initial $monitor($stime, "resetn = %b ck = %b hz32 = %b keyenbl = %b colin = %b rowout = %b keycode = %b ke1 = %b ke2 = %b sftreg = %b"
    // , resetn, ck, hz32, keyenbl, colin[3], colin[2], colin[1], colin[0], rowout[2], rowout[1], rowout[0], keycode[3], keycode[2], keycode[1], keycode[0], ke1, ke2, sftreg[3],, sftreg[2], sftreg[1], sftreg[0] );
endmodule