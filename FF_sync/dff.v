module DFF (CK, D, Q, LD, RES);
    input         CK, LD, RES;
    input   [3:0] D;
    output  [3:0] Q;
    reg     [3:0] Q;

    always @(posedge CK) begin
        if (RES==1'b1)
            Q <= 4'h0;
        else if (LD==1'b1)
            Q <= D;
    end

endmodule

