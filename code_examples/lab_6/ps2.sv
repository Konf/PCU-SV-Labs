module ps2_keyboard( 
  input  logic areset, 
  input  logic clk_50,

  input  logic ps2_clk, 
  input  logic ps2_dat, 
          
  output logic valid_data, 
  output logic [7:0] data
); 

logic [8:0] shift_reg;
logic [3:0] count_bit;

assign data = shift_reg[7:0];

function parity_calc;
  input logic [7:0] a;
  parity_calc = ~(a[0] ^ a[1] ^ a[2] ^ a[3] ^ a[4] ^ a[5] ^ a[6] ^ a[7]);
endfunction

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


logic [1:0] state;

localparam IDLE = 2'd0;
localparam RECEIVE_DATA = 2'd1;
localparam CHECK_PARITY_STOP_BITS = 2'd2;

always_ff @(posedge clk_50 or posedge areset) begin
  if(areset)
    state <= IDLE;
  else if (ps2_clk_negedge)
    begin
      case (state)
        IDLE:
        begin
          if(!ps2_dat)
            state <= RECEIVE_DATA;
        end

        RECEIVE_DATA:
        begin
          if (count_bit == 8)
            state <= CHECK_PARITY_STOP_BITS;
        end

        CHECK_PARITY_STOP_BITS:
        begin
          state <= IDLE;
        end

        default:
        begin
          state <= IDLE;
        end
      endcase
    end
end

always_ff @(posedge clk_50 or posedge areset) begin
  if(areset)
    valid_data <= 1'b0;
  else if (ps2_clk_negedge)
    if (ps2_dat && (parity_calc(shift_reg[7:0]) == shift_reg[8]) && (state == CHECK_PARITY_STOP_BITS))
      valid_data <= 1'b1;
    else
      valid_data <= 1'b0;
end

always_ff @(posedge clk_50 or posedge areset) begin
  if(areset)
    shift_reg <= 9'b0;
  else if (ps2_clk_negedge)
    if(state == RECEIVE_DATA)
      shift_reg <= {ps2_dat, shift_reg[8:1]};
end

always_ff @(posedge clk_50 or posedge areset) begin
  if(areset)
    count_bit <= 4'b0;
  else if (ps2_clk_negedge) begin
    if(state == RECEIVE_DATA)
      count_bit <= count_bit + 4'b1;
    else
      count_bit <= 4'b0;
  end
end

endmodule
