//
// ƒZƒ‹ŒÄ‚Ño‚µ‚É‚æ‚é4bit‰ÁZ‰ñ˜H
module adder_macro(a, b, q);
	input [3:0] a, b;
	output [3:0] q;
	
/*	MKAD4 adder(.A(a[0]), .A2(a[1]), .A3(a[2]), .A4(a[3]),
				 .B1(b[0]), .B2(b[1]), .B3(b[2]), .B4(b[3]),
				 .S1(q[0]), .S2(q[1]), .S3(q[2]), .S4(q[3]),
				 .CI(1'b0);
*/

	adder4 adder(.A(a[0]), .A2(a[1]), .A3(a[2]), .A4(a[3]),
				 .B1(b[0]), .B2(b[1]), .B3(b[2]), .B4(b[3]),
				 .S1(q[0]), .S2(q[1]), .S3(q[2]), .S4(q[3]),
				 .CI(1'b0);



endmodule
