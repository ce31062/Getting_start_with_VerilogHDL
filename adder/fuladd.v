//
// フル・アダ―呼び出しによる加算回路1 -ポート・リスト順の接続
module fulladd(A, B, CIN, Q, COUT);
	input A, B, CIN;
	output Q, COUT;
	
	assign Q = A ^ B ^ CIN;
	assign COUT = (A & B) | (B & CIN) | (CIN & A);
	
	endmodule