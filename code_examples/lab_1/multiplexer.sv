module multiplexer(
  input  logic [2:0] a,
  input  logic [2:0] b,
  input  logic [2:0] c,
  input  logic [2:0] d,
  input  logic [1:0] s,
  output logic [2:0] y
);

  always_comb begin
    case (s)
      2'b00:   y = a;
      2'b01:   y = b;
      2'b10:   y = c;
      2'b11:   y = d;
      default: y = a;
    endcase
  end

endmodule
