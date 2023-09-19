module counter_8bit(
  input  logic       clk,
  input  logic       rst,
  input  logic       en,
  output logic [7:0] counter
);

always_ff @(posedge clk or posedge rst) begin
  if (rst)
    counter <= 0;
  else if (en)
    counter <= counter + 1;
end

endmodule
