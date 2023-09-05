module bitwise_ops(
  input  logic [7:0] x,
  output logic [4:0] a,
  output logic       b,
  output logic [2:0] c
);

  assign a = x[5:1];
  assign b = x[5]   | x[7];
  assign c = x[7:5] ^ x[2:0];

endmodule
