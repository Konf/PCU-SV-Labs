// регистр счётчика
logic [3:0] hundredth_counter;

// описание компаратора
logic       tenth_of_second_passed;
assign tenth_of_second_passed = (hundredths_counter == 4'd9)
                              & hundredths_of_second_passed;

// описание счётчика
always_ff @(posedge clk or posedge reset) begin
  // асинхронный сброс
  if (reset)
    hundredths_counter <= '0;
  // сигнал разрешения работы счётчика
  else if (hundredth_of_second_passed) begin
    // синхронный сброс по достижению максимума
    if (tenth_of_second_passed)
      hundredths_counter <= '0;
    else
      // увеличение счётчика на единицу
      hundredths_counter <= hundredths_counter + 1;
  end
end
