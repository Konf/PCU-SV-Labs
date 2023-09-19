module latch_struct(
  input  logic nR,
  input  logic nS,
  output logic Q,
  output logic nQ
);

assign Q = ~(nS & nQ);
assign nQ = ~(nR & Q);

endmodule
