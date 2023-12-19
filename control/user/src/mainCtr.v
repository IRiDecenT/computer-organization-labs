module mainCtr(
    input Rtype,
    input ori,
    input addiu,
    input lw,
    input sw,
    input beq,
    input jump,
    output RegWr,
    output ALUSrc,
    output RegDst,
    output MemtoReg,
    output MemWr,
    output branch,
    output Jump,
    output ExtOp,
    output [2:0] ALUOp,
    output rtype
);
    assign rtype = Rtype;
    assign RegWr = Rtype | ori | addiu | lw;
    assign ALUSrc = ori | addiu | lw | sw;
    assign RegDst = Rtype;
    assign MemtoReg = lw;
    assign MemWr = sw;
    assign branch = beq;
    assign Jump = jump;
    assign ExtOp = addiu | lw | sw;
    assign ALUOp[2] = beq;
    assign ALUOp[1] = ori;
    assign ALUOp[0] = Rtype;

endmodule
