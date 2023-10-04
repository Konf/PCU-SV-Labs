logic [9:0] ps2_clk_detect;

always_ff @(posedge clk_50 or posedge areset)
begin
  if(areset)
    ps2_clk_detect <= 10'd0;
  else
    ps2_clk_detect <= {ps2_clk, ps2_clk_detect[9:1]};
end

logic ps2_clk_negedge;
assign ps2_clk_negedge = (&ps2_clk_detect[4:0]) && (&(~ps2_clk_detect[9:5]));
