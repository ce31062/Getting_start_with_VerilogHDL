module TFF_sync (CK, EN, Q, RB);
    input   CK, EN, RB;
    output  Q;
    reg     Q;

    always @(posedge CK) begin
        if (RB==1'b0)
            Q <= 1'b0;
        else if (EN==1'b1)
            Q <= ~Q;
    end
endmodule
