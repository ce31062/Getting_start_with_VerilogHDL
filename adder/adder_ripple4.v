//
// IP‚ğŠˆ—p‚µ‚ÄA–¼‚Ü‚¦‚ÌŒÄ‚Ño‚µ‚É‚æ‚é‰ÁZ‰ñ˜H4

module adder_ripple(a, b, q, LED);
	input [3:0] a, b;
	output [3:0] q;
	output [4:7] LED;
	
	wire [3:0] cout;
	assign LED = 4'b1111;
	
	adder4 add (.Result(q), .Cout(cout),
				  .DataA(a), .DataB(b), .Cin(1'b0));
	endmodule
	