//
// 加算演算子によるバイナリ・カウンタ
module counter(rstn, q, LED);
	input  rstn;
	output  [3:0] q;
	output  [4:7] LED;
	
	wire clk_1Hz;
	wire rst;
	wire osc_clk; // Internal OSCILLATOR clock
	reg [3:0] qn; 
	assign LED = 4'b1111; // 不要なLED(D2～D5)を消灯
	assign rst = ~rstn;
	
	always @(posedge clk_1Hz or posedge rst) begin
		if (rst==1'b1)
			qn <= 4'h0;
		else
			qn <= qn + 4'h1;
		
	end

	defparam OSCJ_inst.NOM_FREQ = "12.09"; // XO3D sample as is  
	OSCJ OSCJ_inst( 
		.STDBY(1'b0), // 0=Enabled, 1=Disabled
		.OSC(osc_clk),
		.SEDSTDBY()
		);
		
	heartbeat #(.clk_freq (12000000)) // １Hz生成: XO3D サンプルコードより拝借
    heartbeat_inst (
        .clk        (osc_clk),
        .rst        (rst),
        .heartbeat  (clk_1Hz)
        );

	assign q = ~qn;
endmodule