module my_module_name(
  input  logic a,
  input  logic b,
  input  logic c,
  output logic y
);

  logic my_signal;
  assign my_signal = a & b;

endmodule
