`include "/Users/yr/code/computer-organization/computer-organization-labs/REGS/user/src/Reg.v"
module testbench;
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
wire [31:0] 	busA;
wire [31:0] 	busB;

reg [4:0] Ra;
reg [4:0] Rb;
reg [4:0] Rw;
reg RegWr;
reg [31:0] busW;
reg Clock = 0;


Reg u_Reg(
	.Ra    	( Ra     ),
	.Rb    	( Rb     ),
	.Rw    	( Rw     ),
	.RegWr 	( RegWr  ),
	.Clock 	( Clock  ),
	.busW  	( busW   ),
	.busA  	( busA   ),
	.busB  	( busB   )
);

always begin
    #500 Clock = ~Clock;
end


initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, testbench);
    #1000
    Ra = 1;
    Rb = 2;
    #1000
    Ra = 3;
    Rb = 4;
    #1000
    Ra = 5;
    Rb = 6;
    #1000
    Rw = 1;
    RegWr = 1;
    busW = 32'd20;




    #50000 $finish;
end

endmodule  //TOP


// // 导入被测试的寄存器组模块
// `include "/Users/yr/code/computer-organization/computer-organization-labs/REGS/user/src/Reg.v"

// // 定义一个模块，用于测试寄存器组模块
// module Reg_tb;

// // 定义一个时钟信号
// reg Clock;

// // 定义一个寄存器地址信号
// reg [4:0] Ra, Rb, Rw;

// // 定义一个写入使能信号
// reg RegWr;

// // 定义一个输入数据总线
// reg [31:0] busW;

// // 定义一个输出数据总线
// wire [31:0] busA, busB;

// // 实例化被测试的寄存器组模块
// Reg UUT (.Ra(Ra), .Rb(Rb), .Rw(Rw), .RegWr(RegWr), .busW(busW), .Clock(Clock), .busA(busA), .busB(busB));

// // 初始化信号
// initial
// begin
//     // 初始化时钟信号
//     Clock = 0;

//     // 初始化寄存器地址信号
//     Ra = 0;
//     Rb = 0;
//     Rw = 0;

//     // 初始化写入使能信号
//     RegWr = 0;

//     // 初始化输入数据总线
//     busW = 0;

//     // 打印测试开始信息
//     // $display("Test started");

//     // 模拟时钟信号

// end

// always begin
//     Clock = ~Clock;
//     #1;
// end

// // 在时钟信号的上升沿，进行测试
// always @(posedge Clock)
// begin
//     $dumpfile("wave.vcd");
//     $dumpvars(0, Reg_tb);
//     // 设置寄存器地址信号
//     Ra = 1;
//     Rb = 2;
//     Rw = 3;

//     // 设置写入使能信号
//     RegWr = 1;

//     // 设置输入数据总线的值
//     busW = 55;

//     // 等待一个时钟周期
//     #10;

//     // 打印寄存器组的输出结果
//     $display("busA = %d, busB = %d", busA, busB);

//     // 设置寄存器地址信号
//     Ra = 2;
//     Rb = 3;
//     Rw = 4;

//     // 设置写入使能信号
//     RegWr = 0;

//     // 设置输入数据总线的值
//     busW = 0;

//     // 等待一个时钟周期
//     #10;

//     // 打印寄存器组的输出结果
//     $display("busA = %d, busB = %d", busA, busB);

//     // 结束仿真
//     $finish;
// end

// endmodule

