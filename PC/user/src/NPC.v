`timescale 1ns/1ps;
module NPC(
    input[31:2] curAddr,
    input jump,
    input branch,
    input zero,
    input[31:0] instruction,
    input[31:2] extend_imme,
    output reg[31:2] nextAddr
);
    initial begin
        nextAddr = 0;
    end
    always @(curAddr) begin
        if(jump)begin
            #10 nextAddr = {curAddr[31:28], instruction[25:0]};
            $display("[DEBUG] jump curAddr: %h, nextAddr: %d", curAddr, nextAddr);
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
    // always @(curAddr) begin
    //     nextAddr = jump ? {curAddr[31:28], instruction[25:0]} :
    //              (branch && zero) ? curAddr + 1 + extend_imme :
    //              curAddr + 1;
    // end


    // if (jump) begin
    //     assign nextAddr = {curAddr[31:28], instruction[25:0]};
    // end
    // else if (branch && zero) begin
    //     assign nextAddr = curAddr + 1 + extend_imme;
    // end
    // else begin
    //     assign nextAddr = curAddr + 1;
    // end

endmodule