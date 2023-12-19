module muxReg(
    input[4:0] Rd,
    input[4:0] Rt,
    input RegDst,
    output[4:0] Rw
);
    assign Rw = RegDst ? Rd : Rt;
endmodule