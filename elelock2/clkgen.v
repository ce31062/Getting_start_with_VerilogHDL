/* Clock Generator */
module clkgen ( orgclk, resetn, ck, hz512, hz32 );
	input	resetn;
	output	ck;
	output	hz512;
	output	hz32;
	output	orgclk;

	/* System Clock (32768Hz) */
	reg			ck;
	reg	[9:0]	cnt;
	
	wire 		orgclk;
	wire	hz64k = (cnt==10'd750-1);
	assign  reset = ~resetn;

	always @(posedge orgclk or posedge reset) begin
		if (reset)
			cnt <= 10'h000;
		else if (hz64k)
			cnt <= 10'h000;
		else
			cnt <= cnt + 10'h001;
	end

	/* Internal Oscillator for MachXO3D (OSCJ) */
	defparam OSCJ_inst.NOM_FREQ = "44.33"; // 44.33MHz  
	OSCJ OSCJ_inst( 
		.STDBY(1'b0), // 0=Enabled, 1=Disabled
		.OSC(orgclk),
		.SEDSTDBY()
		);
	
	/* Divided to duty 50% */
	always @(posedge orgclk or posedge reset) begin
		if (reset)
			ck <= 1'b0;
		else if (hz64k)
			ck <= ~ck;
	end

	/* 512Hz and 32Hz */  //計算忦
	reg	[9:0]	cnt2;
	reg			hz512, hz32;

	always @(posedge ck or posedge reset) begin
		if (reset)
			cnt2 <= 10'h000;
		else
			cnt2 <= cnt2 + 10'h001;
	end

	always @(posedge ck or posedge reset) begin
		if (reset) begin
			hz512 <= 1'b0;
			hz32 <= 1'b0;
	end
	else begin
		hz512 <= (cnt2[5:0]==6'h3f);
		hz32 <= (cnt2==10'h3ff);
	end
	end
endmodule

	