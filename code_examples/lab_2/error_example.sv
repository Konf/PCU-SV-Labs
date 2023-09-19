logic a;
logic b;

always_ff @(posedge clk) begin
  if (in < 5)
    a <= in;
end

always_ff @(posedge clk) begin
  if (n > 5) begin
    b <= in;
    a <= in - 5; // Error!
  end
  else
    b <= a;
end
