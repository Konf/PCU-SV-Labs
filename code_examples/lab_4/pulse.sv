logic green_light;
logic yellow_light;
logic blink_en;
logic blink;

assign green_light  = (state == GREEN) | (state == GREEN_BLINKING);
assign yellow_light = (state == YELLOW) | (state == YELLOW_BLINKING);
assign blinking_en  = (state == GREEN_BLINKING) | (state == YELLOW_BLINKING);

//код, описывающий поведение схемы пульсации
//выход схемы – сигнал blink
always @(posedge clk) begin
  if (blinking_en = 1) then
  ... // опустим описание
end


assign green  = green_light & blink;
assign yellow = yellow_light & blink;
