//
// フル・アダー呼び出しによる加算回路2

module adder_ripple(a, b, q, LED);
	input [3:0] a, b;
	output [3:0] q;
	output [4:7] LED;
	
	wire [3:0] cout;
	assign LED = 4'b1111;
	
	fulladd add0 (.Q(q[0]), .COUT(cout[0]),
				  .A(a[0]), .B(b[0]), .CIN(1'b0));
	fulladd add1 (.Q(q[1]), .COUT(cout[1]),
				  .A(a[1]), .B(b[1]), .CIN(cout[0]));
	fulladd add2 (.Q(q[2]), .COUT(cout[2]),
				  .A(a[2]), .B(b[2]), .CIN(cout[1]));
	fulladd add3 (.Q(q[3]), .COUT(cout[3]),
				  .A(a[3]), .B(b[3]), .CIN(cout[2]));
	endmodule
	