module ps2_keyboard(
  input  logic areset,
  input  logic clk_50,

  input  logic ps2_clk,
  input  logic ps2_dat,

  output logic valid_data,
  output logic [7:0] data
);
