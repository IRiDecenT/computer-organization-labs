module mux2to1_1bit(choice1, choice2, out, sel);
	input choice1, choice2, sel;
	output reg out;
	
	always @(*)begin
		case(sel)
		0: out = choice1;
		1: out = choice2;
		endcase
	end
endmodule