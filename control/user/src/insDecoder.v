module insDecoder(
    input[5:0] op,
    output Rtype,
    output ori,
    output addiu,
    output lw,
    output sw,
    output beq,
    output jump
);

    assign Rtype = (op == 6'b000000);
    assign ori = (op == 6'b001101);
    assign addiu = (op == 6'b001001);
    assign lw = (op == 6'b100011);
    assign sw = (op == 6'b101011);
    assign beq = (op == 6'b000100);
    assign jump = (op == 6'b000010);


endmodule