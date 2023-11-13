module xor32(operendA, operendB, out);
	parameter n = 32;
	input[n-1:0] operendA;
	input[n-1:0] operendB;
	output reg[n-1:0] out;
	
	always @(*) begin
		out = operendA ^ operendB;
	end

endmodule