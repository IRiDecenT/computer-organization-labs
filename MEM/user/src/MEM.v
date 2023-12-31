// module MEM (Address, VE, dataout, clk)
// 定义一个名为MEM的模块，该模块模拟了一个内存模块
module MEM (Address, WE, data, dataout, clk);

// 定义一个参数n，表示数据总线的宽度
parameter n = 32;

// 定义两个32位宽的输入线，分别是地址和数据
input wire[n-1:0] Address, data;

// 定义两个输入线，分别是写入使能信号和时钟信号
input wire WE, clk;

// 定义一个32位宽的输出数据总线
output reg[n-1:0] dataout;

// 定义一个256个元素的内存数组，每个元素是一个8位宽的寄存器
(* ram_style = "distributed" *) reg [7:0] mem [255:0];

initial
    begin
        // $readmemh("/Users/yr/code/computer-organization/computer-organization-labs/MEM/user/data/data.txt", mem);
        $readmemh("/Users/yr/code/computer-organization/computer-organization-labs/MEM/user/data/fibData.txt", mem);
    end

// 在时钟信号的下降沿，如果WE为1，则将输入数据写入到内存数组的指定地址
always @ (negedge clk)
    begin
        if(WE ==1)begin
            {mem[Address+3], mem[Address+2], mem[Address+1], mem[Address]} = data;
            $display("[DEBUG] write %h to memory address:%h, %h", data, Address, {mem[Address+3], mem[Address+2], mem[Address+1], mem[Address]});
        end

    end

always @ (*)
    begin
        dataout = {mem[Address+3], mem[Address+2], mem[Address+1], mem[Address]};
        //$display("[DEBUG] read %h from memory address:%h", dataout, Address);
    end
endmodule



