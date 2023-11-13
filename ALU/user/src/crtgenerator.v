module crtgenerator(ALUctr, SUBctr, OPctr, OVctr, SIGctr);
	parameter n = 3;
	input[n-1:0] ALUctr;
	output reg SUBctr, OVctr, SIGctr;
	output reg[1:0] OPctr; 
	
	always @(*) begin
		SUBctr = ALUctr[2];
		OVctr = !ALUctr[1] & ALUctr[0];
		SIGctr = ALUctr[0];
		OPctr[1] = ALUctr[2] & ALUctr[1];
		OPctr[0] = !ALUctr[2] & ALUctr[1] & !ALUctr[0];
	end

endmodule
	