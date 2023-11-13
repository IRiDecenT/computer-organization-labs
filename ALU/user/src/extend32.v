module extend32(SUBctr, extend_out);
	input SUBctr;
	output reg[31:0] extend_out;
	always @(*) begin
	if(SUBctr == 1)
		extend_out = 32'hffffffff;
	else
		extend_out = 32'b0;
	end

endmodule