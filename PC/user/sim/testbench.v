`include "/Users/yr/code/computer-organization/computer-organization-labs/PC/user/src/IFU.v"
`timescale 1ns/1ps;
module testbench();

parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 32;
parameter MAIN_FRE   = 100; //unit MHz
reg                   sys_clk = 0;
reg                   sys_rst = 1;
reg [DATA_WIDTH-1:0]  data = 0;
reg [ADDR_WIDTH-1:0]  addr = 0;

always begin
    #100 sys_clk = ~sys_clk;
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
wire [31:0] 	instruction;
reg jump = 0;
reg branch = 0;
reg zero = 0;

IFU u_IFU(
	.clk         	( sys_clk          ),
	.jump        	( jump         ),
	.branch      	( branch       ),
	.zero        	( zero         ),
	.instruction 	( instruction  )
);



initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, testbench);
    #3300 branch = 1; zero = 1;
    #200 branch = 0; zero = 0;
    #50000 $finish;
end

endmodule  //TOP
