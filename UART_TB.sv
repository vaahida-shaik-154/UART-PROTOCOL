`timescale 1ns/1ps
`include "design_top.sv"

module UART_TB;

reg clk, reset;
reg wr_en, rdy_clr;
reg [7:0] din;

wire busy, rdy;
wire [7:0] dout;

UART dut(.clk(clk), .reset(reset), .wr_en(wr_en), .din(din), .rdy_clr(rdy_clr), .rdy(rdy), .busy(busy), .dout(dout));

initial begin
{clk, reset, din, rdy_clr} = 0;
forever #5 clk = ~clk;
end

task rst;
@(negedge clk);
reset = 1'b1;
@(negedge clk);
reset = 1'b0;
endtask

task send(input [7:0] data);
@(negedge clk);
din = data;
wr_en = 1'b1;
@(negedge clk);
wr_en = 1'b0;
endtask

task clear_rdy;
@(negedge clk);
rdy_clr = 1'b1;
@(negedge clk);
rdy_clr = 1'b0;
endtask

initial begin
  rst();
  send(8'h25);
  @(posedge rdy);
  $display("RECEIVED DATA =  %0h \n ", dout);
  clear_rdy();

  send(8'h50);
  wait(rdy == 1);
  $display("RECEIVED DATA =  %h \n", dout);
  clear_rdy();

  send(8'h75);
  @(posedge rdy);
  $display("RECEIVED DATA =  %2h \n", dout);
  clear_rdy();

  send(8'h99);
  wait(rdy == 1);
  $display("RECEIVED DATA =  %2h \n", dout);
  clear_rdy();

  #100000 $finish;
end

initial $monitor("t=%10t | busy=%b | rdy=%b | din=%h | dout=%h | tx=%b | rx = %b", $time, busy, rdy, din, dout, dut.TX.tx, dut.RX.rx);

initial begin
$shm_open("waves.shm");
$shm_probe("ACMTF");
end

endmodule




