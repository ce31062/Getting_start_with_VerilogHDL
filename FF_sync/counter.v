module counter (ck, res, q);
    input           ck, res;
    output  [3:0]   q;
    reg     [3:0]   q;

    always @(posedge ck) begin
        if (res)
            q <= 4'h0;
        else
            q <= q + 4'h1;
    end
endmodule
