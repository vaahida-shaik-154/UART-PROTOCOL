module baud_rate(input clk,reset, output tx_en, rx_en);
reg[12:0] tx_counter;
reg[9:0] rx_counter;

always_ff @(posedge clk or posedge reset) begin
  if (reset) begin
    tx_counter <= 0;
    rx_counter <= 0;
  end else begin
    tx_counter <= (tx_counter == 5208) ? 0 : tx_counter + 1;
    rx_counter <= (rx_counter == 325) ? 0 : rx_counter + 1;
  end


  
end

assign tx_en = (tx_counter == 0)?1'b1:1'b0;
assign rx_en = (rx_counter == 0)?1'b1:1'b0;
endmodule

