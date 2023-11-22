`timescale 1ns/1ps
`include "/Users/yr/code/computer-organization/computer-organization-labs/ALU/user/src/ALU.v"

module testbench;
parameter n = 32;
reg [n-1:0] A;
reg [n-1:0] B;
reg [2:0] ALUctr;
//Instance
// outports wire

wire [n-1:0] 	Result;
wire         	Zero;
wire         	Overflow;
ALU u_ALU(
	.A        	( A         ),
	.B        	( B         ),
	.ALUctr   	( ALUctr    ),
	.Result   	( Result    ),
	.Zero     	( Zero      ),
	.Overflow 	( Overflow  )
);

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, testbench);

    // 无符号加法，不判溢出
    ALUctr = 3'b000;
    A = 32'd16;
    B = 32'd18;
    #10000
    A = 32'hfffffff1;
    B = 32'he;
    #10000
    B = B + 1;
    #10000

    // 带符号加法, 判溢出
    ALUctr = 3'b001;
    A = 32'h7ffffff1;
    B = 32'd5;
    #10000
    B = 32'hf; // 上溢
    #10000
    A = -32'd16;
    B = -32'd8;
    #10000
    // 下溢
    A = 32'h80000001;
    B = 32'h80000001;
    #10000

    // 或运算
    // 0001 | 1000 = 1001
    ALUctr = 3'b010;
    A = 32'h11111111;
    B = 32'h88888888;
    #10000

    // 无符号减法 不判溢出
    ALUctr = 3'b100;
    A = 32'd16;
    B = 32'd10;
    #10000
    B = 32'd16;
    #10000
    B = 32'd17;
    #10000

    // 带符号减法 判断溢出
    ALUctr = 3'b101;
    A = 32'd16;
    B = 32'd8;
    #10000
    B = 32'd16;
    #10000
    B = 32'd17;
    #10000
    A = 32'h7fffffff; // 上溢
    B = -32'd1;
    #10000
    A = 32'h80000001; // 下溢
    B = 32'd2;
    #10000

    // 无符号数 小于比较 小于置1
    ALUctr = 3'b110;
    A = 32'd16;
    B = 32'd8;
    #10000 B = 32'd16;
    #10000 B = 32'd17;
    #10000 B = -32'd1;
    #10000

    // 带符号数 小于比较 小于置1
    ALUctr = 3'b111;
    A = 32'd16;
    B = 32'd8;
    #10000 B = 32'd16;
    #10000 B = 32'd17;
    #10000 B = -32'd1;
    #10000 $finish;

end

endmodule  //TOP
