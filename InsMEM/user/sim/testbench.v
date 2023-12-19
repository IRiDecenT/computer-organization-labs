`timescale 1ns/1ps
`include "/Users/yr/code/computer-organization/computer-organization-labs/InsMEM/user/src/InsMEM.v"
module testbench();

parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 32;
parameter MAIN_FRE   = 500; //unit MHz
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
        addr = addr + 4;
end
always @(posedge sys_clk) begin
    if (sys_rst)
        data = 0;
    else
        data = data + 1;
end

//Instance
// outports wire
wire [31:0] 	InsData;

InsMEM u_InsMEM(
	.InsAddr 	( addr  ),
	.InsData 	( InsData  )
);



initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, testbench);
    #50000 $finish;
end

endmodule  //TOP
