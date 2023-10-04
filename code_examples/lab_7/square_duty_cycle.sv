module square_duty_cycle (
  input  logic clk,
  input  logic rst,

  input  logic        enable,
  input  logic [20:0] full_period,
  input  logic [20:0] active_period,
  input  logic [15:0] volume,

  output logic [15:0] square_wave
);

logic [20:0] counter;

always_ff @(posedge clk or posedge rst) begin
  if(rst)
    counter <= 21'd0;
  else
    if ((counter >= full_period) || ~enable)
      counter <= 21'd0;
    else
      counter <= counter + 1;
end

logic square;

always_ff @(posedge clk or posedge rst) begin
  if(rst) begin
    square  <= 1'b0;
  end else if (enable) begin
    if (counter >= full_period)
      square <= 1'b1;
    else if (counter >= active_period)
      square <= 1'b0;
  end
end

assign square_wave = (square && enable) ? volume
                                        : 16'd0;

endmodule
