module square_code (
  input  logic clk,
  input  logic rst,

  input  logic        enable,
  input  logic [20:0] half_period,
  input  logic [15:0] volume,

  output logic [15:0] square_wave,
  output logic        wr
);

logic [20:0] counter;

always_ff @(posedge clk or posedge rst) begin
  if(rst)
    counter <= 21'd0;
  else
    if ((counter >= half_period) || ~enable)
      counter <= 21'd0;
    else
      counter <= counter + 1;
end


always_ff @(posedge clk or posedge rst) begin
  if(rst)
    wr <= 1'b0;
  else
    if ((counter >= half_period) && enable)
      wr <= 1'b1;
    else
      wr <= 1'b0;
end


logic square;

always_ff @(posedge clk or posedge rst) begin
  if(rst) begin
    square  <= 1'b0;
  end else if (enable) begin
    if (counter >= half_period)
      square <= ~square;
  end
end

assign square_wave = (square && enable) ? volume
                                        : 16'd0;

endmodule
