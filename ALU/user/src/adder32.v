module adder32(A, B, Cin, Add_Carry, Add_Overflow, Add_Sign, Add_Result, Zero);
	parameter n = 32;
	input [n-1:0] A;
	input [n-1:0] B;
	input Cin;
	output Add_Carry, Add_Overflow, Add_Sign, Zero;
	output[n-1:0] Add_Result;

	wire cout;

	assign {cout, Add_Result} = A + B + Cin;
	assign Add_Carry = ~(cout ^ Cin);
	assign Add_Overflow = cout ^ Add_Result[n-1] ^ A[n-1] ^ B[n-1];
	assign Add_Sign = Add_Result[n-1];
	/*
	if(Add_Result == 32'b0)
		assign Zero = 1;
	else
		assign Zero = 0;
	*/
	assign Zero = ~(| Add_Result);

endmodule

