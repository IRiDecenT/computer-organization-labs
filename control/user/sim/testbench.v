`timescale 1ns / 1ps
`include "/Users/yr/code/computer-organization/computer-organization-labs/control/user/src/cpuCtr.v"
module testbench();

parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 32;
parameter MAIN_FRE   = 100; //unit MHz
reg                   sys_clk = 0;
reg                   sys_rst = 1;
reg [DATA_WIDTH-1:0]  data = 0;
reg [ADDR_WIDTH-1:0]  addr = 0;

always begin
    #(500/MAIN_FRE) sys_clk = ~sys_clk;
end

always begin
    #50 sys_rst = 0;
end

always @(posedge sys_clk) begin
    if (sys_rst)
        addr = 0;
    else
        addr = addr + 1;
end
always @(posedge sys_clk) begin
    if (sys_rst)
        data = 0;
    else
        data = data + 1;
end

//Instance
// outports wire
wire       	RegWr;
wire       	ALUSrc;
wire       	RegDst;
wire       	MemtoReg;
wire       	MemWr;
wire       	branch;
wire       	Jump;
wire       	ExtOp;
wire [2:0] 	ALUctr;
wire       	rtype;

// input
reg[5:0] op;
reg[5:0] func;

cpuCtr u_cpuCtr(
	.op       	( op        ),
	.func     	( func      ),
	.RegWr    	( RegWr     ),
	.ALUSrc   	( ALUSrc    ),
	.RegDst   	( RegDst    ),
	.MemtoReg 	( MemtoReg  ),
	.MemWr    	( MemWr     ),
	.branch   	( branch    ),
	.Jump     	( Jump      ),
	.ExtOp    	( ExtOp     ),
	.ALUctr   	( ALUctr    ),
	.rtype    	( rtype     )
);



initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, testbench);

    #1000 op = 6'b000000; func = 6'b100000; // add
    #1000 op = 6'b000000; func = 6'b100010; // sub
    #1000 op = 6'b000000; func = 6'b100100; // and
    #1000 op = 6'b000000; func = 6'b100101; // or
    #1000 op = 6'b000000; func = 6'b101010; // slt
    #1000 op = 6'b001101; func = 6'b000000; // ori
    #1000 op = 6'b001001; func = 6'b000000; // addiu
    #1000 op = 6'b100011; func = 6'b000000; // lw
    #1000 op = 6'b101011; func = 6'b000000; // sw
    #1000 op = 6'b000100; func = 6'b000000; // beq
    #1000 op = 6'b000010; func = 6'b000000; // jump

    #50000 $finish;
end

endmodule  //TOP
