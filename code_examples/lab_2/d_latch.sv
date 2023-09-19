module d_latch_behav(
  input  logic d,
  input  logic en,
  output logic q
);

always_latch begin
  if (en)
    q <= d;
end

endmodule
