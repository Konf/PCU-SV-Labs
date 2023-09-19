module d_flipflop_behav(
  input  logic clk,
  input  logic rst,
  input  logic d,
  input  logic en,
  output logic q
);

always_ff @(posedge clk or posedge rst) begin
  if (rst)
    q <= 0;
  else if (en)
    q <= d;
end

endmodule
