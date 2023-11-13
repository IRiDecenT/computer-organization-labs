module or32(operendA, operendB, out);
	parameter n = 32;
	input[n-1:0] operendA;
	input[n-1:0] operendB;
	output[n-1:0] out;
	
	assign out = operendA | operendB;
	
endmodule