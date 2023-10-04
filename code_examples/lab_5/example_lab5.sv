module example_lab5 (
  input  logic       clk,
  input  logic       rst,
  input  logic [7:0] data,
  input  logic       we,
  output logic       full,
  output logic       transmit_lane
);

  localparam IDLE     = 2'b00;
  localparam LOAD     = 2'b01;
  localparam TRANSMIT = 2'b10;
  localparam WAIT     = 2'b11;

  logic [1:0] state;
  logic [7:0] data_from_fifo_for_transmitter;
  logic       fifo_is_empty;
  logic       fifo_re;
  logic       transmitter_is_busy;
  logic       start_transaction;

  always_ff @(posedge clk or posedge rst) begin
    if (rst)
      state <= IDLE;
    else begin
      case (state)
        IDLE:
          if (fifo_is_empty | transmitter_is_busy)
            state <= IDLE;
          else
            state <= LOAD;
        LOAD:
          state <= TRANSMIT;
        TRANSMIT:
          state <= IDLE;
      endcase
    end
  end

  assign fifo_re = (state == LOAD);
  assign start_transaction = (state == TRANSMIT);

  fifo fifo_input_buffer(
    .clk      (clk),
    .rst      (rst)
    .we       (we),
    .re       (fifo_re),
    .data_in  (data),
    .data_out (data_from_fifo_for_transmitter),
    .empty    (fifo_is_empty),
    .full     (full)
  );

  tansmitter my_transmitter(
    .clk   (clk),
    .rst   (rst),
    .start (start),
    .busy  (busy),
    .data  (data_from_fifo_for_transmitter),
    .tx    (transmit_lane)
  );

endmodule
