module mux3to1_32bit(choice1, choice2, choice3, out, sel);
	parameter n = 32;
	input[n-1:0] choice1;
	input[n-1:0] choice2;
	input[n-1:0] choice3;
	input[1:0] sel;
	output reg[n-1:0] out;

	always @(*) begin
		case(sel)
		2'b00: out = choice1;
		2'b01: out = choice2;
		2'b10: out = choice3;
		endcase
	end

endmodule	