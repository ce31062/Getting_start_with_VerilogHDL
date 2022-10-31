// Synchronous SR Flip-flop
module SRFF_sync(CK, SB, RB, Q, QB);
    input   CK, SB, RB;
    output  Q, QB;
    reg     Q;

    always @(posedge CK) begin
        if (RB==1'b0)
            Q <= 1'b0;
        else if (SB==1'b0)
            Q <= 1'b1;
    end
    
    assign QB = ~Q;

endmodule
