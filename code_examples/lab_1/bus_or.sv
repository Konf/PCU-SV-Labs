module bus_or(
  input  logic [7:0] x,
  input  logic [7:0] y,
  output logic [7:0] result
);

  assign result = x | y;

endmodule
