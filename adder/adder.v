//
// ���Z���Z�q�ɂ��4-bit���Z��H
module adder (a, b, q, LED);
	input [3:0] a, b;
	output [3:0] q;
	output [4:7] LED;
	
	assign q = a + b;
	assign LED = 4'b1111;
	
	endmodule