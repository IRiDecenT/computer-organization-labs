// 定义一个名为Reg的模块，该模块模拟了一个寄存器组
module Reg(Ra, Rb, Rw, RegWr, busW, Clock, busA, busB);

// 定义一个参数n，表示数据总线的宽度
parameter n = 32;

// 定义三个5位宽的输入线，分别是两个寄存器地址和一个寄存器值
input wire[4:0] Ra, Rb, Rw;

// 定义两个输入线，分别是写入使能信号和时钟信号
input wire RegWr, Clock;

// 定义一个32位宽的输入数据总线
input wire[n-1:0] busW;

// 定义两个32位宽的输出数据总线
output reg[n-1:0] busA, busB;

// 定义一个32个元素的寄存器数组，每个元素是一个32位宽的寄存器
reg [31:0] mem [0:31];

// 初始化时将前四个寄存器的值设置为32'h0，
initial
    begin
        mem[0] <= 32'h0;
        mem[1] <= 32'h0;
        mem[2] <= 32'h0;
        mem[3] <= 32'h0;
    end

// 在时钟信号的下降沿，如果Rw为1，则将输入数据总线的值写入到寄存器数组的Rw位置
always @ (negedge Clock)
    begin
        if (RegWr == 1)begin
            mem[Rw] <= busW;
            $display("[DEBUG] write %h to reg%h", busW, Rw);
        end
    end

always @ (*)
    begin
        busA <= mem[Ra];
        busB <= mem[Rb];
    end
endmodule