// 定义一个名为Reg的模块，该模块模拟了一个寄存器组
module Reg(Ra, Rb, Rv, RegWr, busV, Clock, busA, busB);

// 定义一个参数n，表示数据总线的宽度
parameter n = 32;

// 定义三个5位宽的输入线，分别是两个寄存器地址和一个寄存器值
input wire[4:0] Ra, Rb, Rv;

// 定义两个输入线，分别是写入使能信号和时钟信号
input wire RegWr, Clock;

// 定义一个32位宽的输入数据总线
input wire[n-1:0] busV;

// 定义两个32位宽的输出数据总线
output reg[n-1:0] busA, busB;

// 定义一个32个元素的寄存器数组，每个元素是一个4位宽的寄存器
reg [4:1] mem [31:0];

// 在仿真开始时，将寄存器数组的前四个元素初始化为11
initial
    begin
        mem[1] <= 11;
        mem[2] <= 22;
        mem[3] <= 33;
        mem[4] <= 44;
    end

// 在时钟信号的下降沿，如果Rv为1，则将输入数据总线的值写入到寄存器数组的Rv位置
always @ (negedge Clock)
    begin
        if (Rv == 1)
            mem[Rv] <= busV;
    end

// 当Ra或Rb的值发生变化时，将对应的寄存器值输出到数据总线
always @ (Ra or Rb)
    begin
        busA <= mem[Ra];
        busB <= mem[Rb];
    end
endmodule