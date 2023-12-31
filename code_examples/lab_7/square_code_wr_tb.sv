module square_code_tb ();

  logic clk;
  logic rst;

  logic        enable;
  logic [20:0] half_period;
  logic [15:0] volume;


  logic [15:0] square_wave;
  logic wr;

  initial begin
  	clk = 0;

  	forever
  	#20 clk = ~clk;

  end


  initial begin

    rst = 0;
    enable = 0;
    half_period = 10;
    volume = 16'hff;
    #100
    rst = 1;
    #40
    rst = 0;
    #40
    enable = 1;
    #3000
    enable = 0;

  end


square_code UUT(
  .clk         (clk),
  .rst         (rst),

  .enable      (enable),
  .half_period (half_period),
  .volume      (volume),

  .square_wave (square_wave),
  .wr          (wr)
);

endmodule
