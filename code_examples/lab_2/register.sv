module register_behav(
  input  logic       clk,
  input  logic       rst,
  input  logic [7:0] d,
  input  logic       en,
  output logic [7:0] q
);

always_ff @(posedge clk or posedge rst) begin
  if (rst)
    q <= 0;
  else if (en)
    q <= d;
end

endmodule
