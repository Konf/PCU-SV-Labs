always @(*) begin
  case (mux_result)
      4'h0: HEX0 = 7'b1000000;
      4'h1: HEX0 = 7'b1111001;
      4'h2: HEX0 = 7'b0100100;
      4'h3: HEX0 = 7'b0110000;
      4'h4: HEX0 = 7'b0011001;
      4'h5: HEX0 = 7'b0010010;
      4'h6: HEX0 = 7'b0000010;
      4'h7: HEX0 = 7'b1111000;
      4'h8: HEX0 = 7'b0000000;
      4'h9: HEX0 = 7'b0010000;

      /* TODO:
      4'hA:
      4'hB:
      4'hC:
      4'hD:
      4'hE:
      4'hF:     
      /*
  endcase
end