module Extend16to30(
    input[15:0] in,
    output[29:0] out
);
    // 进行符号扩展
    assign out = {{14{in[15]}}, in};
endmodule