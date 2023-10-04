// регистр счётчика
logic [16:0] pulse_counter;

// описание компаратора
logic  hundredth_of_second_passed;
assign hundredth_of_second_passed = (pulse_counter == 17'd259999);

// описание счётчика
always_ff @(posedge clk or posedge reset) begin
  // асинхронный сброс
  if (reset)
    pulse_counter <= '0;
  // сигнал разрешения работы счётчика
  else if (device_running | hundredth_of_second_passed) begin
    // синхронный сброс по достижению максимума
    if (hundredth_of_second_passed)
      pulse_counter <= '0;
    else
      // увеличение счётчика на единицу
      pulse_counter <= pulse_counter + 1;
  end
end

русский текст
