module transmitter(input clk, wr_en, clk_en, reset, input [7:0]din, output reg tx, output busy);

parameter idle_tx = 2'b00, start_tx = 2'b01, data_tx = 2'b10, stop_tx = 2'b11;

reg [1:0] state;
reg [7:0] temp_tx;
reg [2:0] index;

always @(posedge clk) begin
if(reset) begin
    tx     <= 1'b1;
    state  <= idle_tx;
    index  <= 0;
    temp_tx <= 0;
end

else begin

case(state)
  idle_tx: begin

if(wr_en) begin
state <= start_tx;
index <= 3'b0;
temp_tx <= din;
end

else
state <= idle_tx;
end

start_tx: begin
if(clk_en) begin
state <= data_tx;
tx <= 1'b0;
end
else
state <= start_tx;
end

data_tx: begin
if(clk_en) begin
tx <= temp_tx[index];
if(index == 3'h7) 
state <= stop_tx;
else
index <= index+1;
end
end

stop_tx: begin
if(clk_en) begin
state <= idle_tx;
tx <= 1'b1;
end
end

default: begin
tx <= 1'b1;
state <= idle_tx;
end

endcase
end
end

assign busy = ((state == start_tx)|(state == data_tx)| (state == stop_tx))?1'b1:1'b0;
//assign busy = (state != idle_tx)?1'b1:1'b0;

endmodule
