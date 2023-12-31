function parity_calc;
  input logic [7:0] a;
  parity_calc = ~(a[0] ^ a[1] ^ a[2] ^ a[3] ^
                  a[4] ^ a[5] ^ a[6] ^ a[7]);
endfunction

always_ff @(posedge clk_50 or posedge areset) begin
  if(areset)
    valid_data <= 1'b0;
  else if (ps2_clk_negedge)
    if (ps2_dat && (parity_calc(shift_reg[7:0]) == shift_reg[8]) && (state == CHECK_PARITY_STOP_BITS))
      valid_data <= 1'b1;
    else
      valid_data <= 1'b0;
end
