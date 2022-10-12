module decoder_if(din, dout);
	input	[1:0]	din;
	output	[3:0]	dout;

	function	[3:0]	dec;
	input	[1:0]	din;
		if	(din==2'h0)
			dec = 4'b0001;
		else if (din==2'h1)
			dec = 4'b0010;
		else if (din==2'h2)
			dec = 4'b0100;
		else
			dec = 4'b1000;
	endfunction
	
	assign dout = dec(din);

endmodule