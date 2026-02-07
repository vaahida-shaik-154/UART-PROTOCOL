`include "design_Baud_rate.sv"
`include "design_Sender.sv"
`include "design_receiver.sv"

module UART (input clk, reset, wr_en, input [7:0]din, input rdy_clr, output [7:0]dout, output busy, output rdy);

wire tx_clk_en;
wire rx_clk_en;

wire temp;

baud_rate BR(.clk(clk), .reset(reset), .tx_en(tx_clk_en), .rx_en(rx_clk_en));
transmitter TX(.clk(clk), .wr_en(wr_en),.clk_en(tx_clk_en), .reset(reset), .din(din), .tx(temp), .busy(busy));
receiver RX(.clk(clk), .rdy_clr(rdy_clr), .reset(reset), .rx(temp), .clk_en(rx_clk_en), .rdy(rdy), .dout(dout));

endmodule
