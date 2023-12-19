`include "/Users/yr/code/computer-organization/computer-organization-labs/datapath/user/src/datapath.v"
`include "/Users/yr/code/computer-organization/computer-organization-labs/control/user/src/cpuCtr.v"

module singleCycleCpu(
    input clk
);

    wire[5:0] op;
    wire[5:0] func;
    wire RegWr;
    wire RegDst;
    wire MemtoReg;
    wire MemWr;
    wire branch;
    wire jump;
    wire ExtOp;
    wire[2:0] ALUctr;
    wire ALUsrc;
    wire rtype;


    cpuCtr ctr( .op(op),
                .func(func),
                .RegWr(RegWr),
                .RegDst(RegDst),
                .MemtoReg(MemtoReg),
                .MemWr(MemWr),
                .branch(branch),
                .Jump(jump),
                .ExtOp(ExtOp),
                .ALUctr(ALUctr),
                .ALUSrc(ALUsrc),
                .rtype(rtype)
    );

    datapath dp(.clk(clk),
                .RegWr(RegWr),
                .ExtOp(ExtOp),
                .ALUctr(ALUctr),
                .ALUsrc(ALUsrc),
                .MemWr(MemWr),
                .RegDst(RegDst),
                .MemtoReg(MemtoReg),
                .branch(branch),
                .jump(jump),
                .op(op),
                .func(func)
                );
endmodule