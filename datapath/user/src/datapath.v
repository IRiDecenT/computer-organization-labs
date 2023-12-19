`include "/Users/yr/code/computer-organization/computer-organization-labs/REGS/user/src/Reg.v"
`include "/Users/yr/code/computer-organization/computer-organization-labs/ALU/user/src/ALU.v"
`include "/Users/yr/code/computer-organization/computer-organization-labs/MEM/user/src/MEM.v"
`include "/Users/yr/code/computer-organization/computer-organization-labs/PC/user/src/IFU.v"
`include "/Users/yr/code/computer-organization/computer-organization-labs/datapath/user/src/muxReg.v"
`include "/Users/yr/code/computer-organization/computer-organization-labs/datapath/user/src/extendByExtop.v"

module datapath(
    input clk,
    input RegWr,
    input ExtOp,
    input[2:0] ALUctr,
    input ALUsrc,
    input MemWr,
    input RegDst,
    input MemtoReg,
    input branch,
    input jump,
    output[5:0] op,
    output[5:0] func
);
    wire zero;
    wire[31:0] instruction;
    wire[4:0] Rs;
    wire[4:0] Rt;
    wire[4:0] Rd;
    wire[4:0] Rw;
    wire[15:0] imm16;
    wire[31:0] imm32;
    wire[31:0] busW;
    wire[31:0] busA;
    wire[31:0] busB;
    wire[31:0] B;
    wire overflow;
    wire[31:0] result;
    wire[31:0] memdata;

    IFU ifu(.clk(clk),
            .branch(branch),
            .jump(jump),
            .zero(zero),
            .instruction(instruction));
    assign op = instruction[31:26];
    assign func = instruction[5:0];
    assign Rs = instruction[25:21];
    assign Rt = instruction[20:16];
    assign Rd = instruction[15:11];
    assign imm16 = instruction[15:0];

    assign RegWr_real = RegWr && !overflow;

    muxReg muxReg(.Rd(Rd),
                   .Rt(Rt),
                   .RegDst(RegDst),
                   .Rw(Rw));


    Reg regs(.Ra(Rs),
             .Rb(Rt),
             .Rw(Rw),
             .RegWr(RegWr_real),
             .busW(busW),
             .Clock(clk),
             .busA(busA),
             .busB(busB));

    extendByExtop extendByExtop(.imm16(imm16),
                                .ExtOp(ExtOp),
                                .imm32(imm32));
    // 选择ALU的另一个输入
    assign B = ALUsrc ? imm32 : busB;

    ALU alu(.A(busA),
            .B(B),
            .ALUctr(ALUctr),
            .Zero(zero),
            .Overflow(overflow),
            .Result(result)
            );


    MEM mem(.Address(result),
            .WE(MemWr),
            .data(busB),
            .dataout(memdata),
            .clk(clk));

    assign busW = MemtoReg ? memdata : result;

endmodule