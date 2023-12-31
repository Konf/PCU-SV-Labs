module ps2_testbench ();


  logic clock;
  logic reset;

  logic ps2_clock;
  logic ps2_data;

  logic valid_data;
  logic [7:0] data;

  ps2_keyboard UUT(
          .areset     (reset),
          .clk_50     (clock),

          .ps2_clk    (ps2_clock),
          .ps2_dat    (ps2_data),

          .valid_data (valid_data),
          .data       (data));



  initial begin
    $dumpfile("out.vcd");
    $dumpvars;
  end

  initial begin
    clock = 0;
    reset = 0;

    ps2_clock = 1;
    ps2_data = 1;

    #20
    reset = 1;
    #20
    reset = 0;

    #5000
    ps2_send(8'hF1);
    ps2_send(8'hAB);

    #100
    $finish;

  end

  always
    #20 clock = ~clock;

  // Tasks


  localparam PS2_HALFPERIOD = 1000;
  logic [7:0] ps2_shiftreg;

  integer i;

  task ps2_send;
    input [7:0] data;

    begin
      ps2_shiftreg = data;

      // Start bit
      ps2_clock = 0;
      ps2_data  = 0;
      #PS2_HALFPERIOD;

      ps2_clock = 1;
      #PS2_HALFPERIOD;


      // Data
      for (i = 0; i < 8; i = i + 1) begin
        ps2_clock = 0;
        ps2_data  = ps2_shiftreg[0];
        ps2_shiftreg = ps2_shiftreg >> 1;
        #PS2_HALFPERIOD;

        ps2_clock    = 1;
        #PS2_HALFPERIOD;
      end


      // Parity
      ps2_clock = 0;
      ps2_data  = ~(^data);
      #PS2_HALFPERIOD;

      ps2_clock = 1;
      #PS2_HALFPERIOD;


      // Stop bit
      ps2_clock = 0;
      ps2_data  = 1;
      #PS2_HALFPERIOD;

      ps2_clock = 1;
      #PS2_HALFPERIOD;


      // One period delay
      #(PS2_HALFPERIOD * 2);
    end

  endtask


endmodule
