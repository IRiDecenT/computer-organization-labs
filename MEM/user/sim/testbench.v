`include "/Users/yr/code/computer-organization/computer-organization-labs/MEM/user/src/MEM.v"
`timescale 1ns/1ps
module testbench();

parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 32;
parameter MAIN_FRE   = 500; //unit MHz
reg                   sys_clk = 0;
reg                   sys_rst = 1;
reg [DATA_WIDTH-1:0]  data = 0;
reg [ADDR_WIDTH-1:0]  addr = 0;

always begin
    #100 sys_clk = ~sys_clk;
end

always begin
    #2 sys_rst = 0;
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

// Instance
// outports wire
parameter n = 32;
wire [n-1:0] dataout;
reg WE;

MEM u_MEM(
	.Address 	( addr     ),
	.data    	( data     ),
	.WE      	( WE       ),
	.clk     	( sys_clk  ),
	.dataout 	( dataout  )
);



initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, testbench);

    // 内存被全部初始化为1
    // 希望把所有的内存读一遍，看看是否都是1
    WE = 0;
    // WE = 1;
    // #20
    // WE = 0;
    // addr = 0;
    // #21
    // WE = 1;
    // addr = 30; // 往30地址及以后写入数据

    // #20
    // // 读取刚刚写的数据
    // WE = 0;
    // addr = 30;
    #25200

    WE = 1;
    addr = 0;
    data = 10;
    #200
    WE = 0;
    addr = 0;


    #10000 $finish;
end

endmodule  //TOP
