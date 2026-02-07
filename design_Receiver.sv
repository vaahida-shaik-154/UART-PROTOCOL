module receiver(input  clk, reset, rdy_clr, rx, clk_en, output reg rdy, output reg [7:0]dout);

parameter idle_rx = 2'b00, start_rx = 2'b01, data_rx = 2'b10, stop_rx = 2'b11;
  reg [1:0]state;
  logic [3:0] sample;   // oversample counter (0–15)
  logic [2:0] index;  // which data bit (0–7)
  logic [7:0] temp_rx;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state   <= idle_rx;
      sample  <= 0;
      index <= 0;
      temp_rx <= 0;
      dout    <= 0;
      rdy     <= 0;
    end 
    else begin
      if (rdy_clr) 
         rdy <= 0;

      if (clk_en) begin
        case (state)

          idle_rx: begin
            if (!rx) begin // start bit detected
              state  <= start_rx;
              sample <= 0;
            end
          end

          start_rx: begin
            sample <= sample + 1;
             if (sample == 7) begin // middle of start bit
              if (!rx) begin
                state   <= data_rx;
                index <= 0;
                sample  <= 0;
              end else begin
                state <= idle_rx; // false start
              end
            end
          end

          data_rx: begin
            sample <= sample + 1;
            if (sample == 15) begin // middle of data bit
              temp_rx[index] <= rx;
              index <= index + 1;
              sample  <= 0;
              if (index == 7) state <= stop_rx;
            end
          end

          stop_rx: begin
            sample <= sample + 1;
            if (sample == 7) begin // middle of stop bit
              if (rx) begin
                dout <= temp_rx;
                rdy  <= 1;
              end
              state <= idle_rx;
              sample <= 0;
            end
          end

        endcase
      end
    end
  end
endmodule
