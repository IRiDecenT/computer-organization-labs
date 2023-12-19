`include "/Users/yr/code/computer-organization/computer-organization-labs/control/user/src/aluCtr.v"
`include "/Users/yr/code/computer-organization/computer-organization-labs/control/user/src/insDecoder.v"
`include "/Users/yr/code/computer-organization/computer-organization-labs/control/user/src/mainCtr.v"


module cpuCtr(
    input [5:0] op,
    input [5:0] func,
    output RegWr,
    output ALUSrc,
    output RegDst,
    output MemtoReg,
    output MemWr,
    output branch,
    output Jump,
    output ExtOp,
    output [2:0] ALUctr,
    output rtype
);

    // outports wire
    wire       	Rtype;
    wire       	ori;
    wire       	addiu;
    wire       	lw;
    wire       	sw;
    wire       	beq;
    wire       	jump;

    insDecoder u_insDecoder(
        .op    	( op     ),
        .Rtype 	( Rtype  ),
        .ori   	( ori    ),
        .addiu 	( addiu  ),
        .lw    	( lw     ),
        .sw    	( sw     ),
        .beq   	( beq    ),
        .jump  	( jump   )
    );

    wire[2:0] ALUOp0;

    mainCtr u_mainCtr(
        .Rtype      ( Rtype      ),
        .ori        ( ori        ),
        .addiu      ( addiu      ),
        .lw         ( lw         ),
        .sw         ( sw         ),
        .beq        ( beq        ),
        .jump       ( jump       ),
        .RegWr      ( RegWr      ),
        .ALUSrc     ( ALUSrc     ),
        .RegDst     ( RegDst     ),
        .MemtoReg   ( MemtoReg   ),
        .MemWr      ( MemWr      ),
        .branch     ( branch     ),
        .Jump       ( Jump       ),
        .ExtOp      ( ExtOp      ),
        .ALUOp      ( ALUOp0     ),
        .rtype      ( rtype      )
    );

    wire[2:0] ALUOp1;
    aluCtr u_aluCtr(
        .func       ( func       ),
        .ALUctr     ( ALUOp1     )
    );

    assign ALUctr = Rtype ? ALUOp1 : ALUOp0;

endmodule