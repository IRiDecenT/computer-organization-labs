module mux2to1_32bit_01mux(sel, out);
	input sel;
	output reg[31:0] out;
	
	always @(*)begin
		case(sel)
		0: out = 32'b0;
		1: out = 32'hffffffff;
		endcase
	end
endmodule
