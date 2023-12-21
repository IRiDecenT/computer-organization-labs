`include "/Users/yr/code/computer-organization/computer-organization-labs/PC/user/src/PC.v"
`include "/Users/yr/code/computer-organization/computer-organization-labs/InsMEM/user/src/InsMEM.v"
`include "/Users/yr/code/computer-organization/computer-organization-labs/PC/user/src/Extend16to30.v"
`timescale 1ns/1ps;
module IFU(
    input clk,
    input jump,
    input branch,
    input zero,
    output[31:0] instruction
);
    reg[31:2] nextAddr;
    wire[31:2] curAddr;
    wire[31:2] extend_imme;

    initial begin
        nextAddr = 0;
    end

    PC pc(
        .clk(clk),
        .nextAddr(nextAddr),
        .curAddr(curAddr)
    );

    InsMEM insMem(
        .InsAddr({curAddr, 2'b00}),
        .InsData(instruction)
    );

    Extend16to30 extend16to30(
        .in(instruction[15:0]),
        .out(extend_imme)
    );

    always @(curAddr) begin
        #10
        if(jump)begin
            nextAddr = {curAddr[31:28], instruction[25:0]};
            $display("[DEBUG] jump curAddr: %d, nextAddr: %d", curAddr, nextAddr);
        end
        else if(branch && zero)begin
            nextAddr = curAddr + 1 + extend_imme;
            $display("[DEBUG] branch curAddr: %d, nextAddr: %d branch=%d zero=%d", curAddr, nextAddr, branch, zero);
            $display("[DEBUG] extend_imme: %d", extend_imme);
        end
        else begin
            nextAddr = curAddr + 1;
        end
    end
endmodule