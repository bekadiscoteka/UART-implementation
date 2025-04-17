`include "uart_rx.v"
`include "uart_tx.v"
`include "m_counter.v"
`include "fifo.v"
`ifndef UART
	`define UART
	module uart_reg	
		#(
			parameter WIDTH=8,
					SB_TICK=16,
					
					SAMP=16,
					BAUND_RATE=9600,

					FIFO_DEPTH=8
		)
		(
			output reg [WIDTH-1:0] data_out,
			output tx_full, tx_empty, tx, 
						rx_full, rx_empty,
			input [WIDTH-1:0] data_in,
			input wr_data, rd_data, rx, clk, reset
	);
		wire rx_done_tick,
			 tx_done_tick,
			 s_tick;
		reg [WIDTH-1:0] tx_data; 
		wire [WIDTH-1:0] rx_data;	
		
		m_counter #(.M((50_000_000 / (BAUND_RATE * SAMP)))) m(
			.tick(s_tick),
			.clk(clk),
			.reset(reset)
		);	

		always @(posedge clk, posedge reset) begin
			if (reset) begin
			   	data_out <= 0;
				tx_data <= 0;
			end
			else begin
				tx_data <= data_in; 
			   	if(rx_done_tick) data_out <= rx_data;
			end
			
		end

		uart_rx #(.DBIT(WIDTH), .SB_TICK(SB_TICK), .S(SAMP)) rx_inst(
			.clk(clk),
			.reset(reset),
			.d_out(rx_data),
			.rx(rx),
			.s_tick(s_tick),	
			.done_tick(rx_done_tick)
		);

		uart_tx #(.DBIT(WIDTH), .SB_TICK(SB_TICK), .S(SAMP)) tx_inst(
			.clk(clk),
			.reset(reset),
			.d_in(tx_data), 
			.tx(tx),
			.start(wr_data),
			.s_tick(s_tick),
			.done_tick(tx_done_tick)
		);

	endmodule
`endif
