`ifndef UART_TOP
`define UART_TOP
`include "uart.v"
`include "fall_edge_detector.v"
`include "bin2bcd.v"
`include "bcd2sseg_active_low.v"
module uart_top 
	#(
		parameter WIDTH=8,
				SB_TICK=16,
					
				SAMP=16,
				BAUND_RATE=9600,

				FIFO_DEPTH=8
	)
	(
		output tx, input rx,
		output [WIDTH-1:0] read_value, 
		output [7:0] sseg,
		input [WIDTH-1:0] sw,
		input clk, reset, write, read //write, get active-low buttons
);
	wire do_write, do_read;
	fall_edge_detector writer(
		.tick(do_write),
		.clk(clk),
		.reset(reset),
		.in(write)
	);
	fall_edge_detector reader(
		.tick(do_read),
		.clk(clk),
		.reset(reset),
		.in(read)
	);
	
	wire rx_full, rx_empty;	
	uart #(
		.SB_TICK(SB_TICK),
		.FIFO_DEPTH(FIFO_DEPTH),
		.BAUND_RATE(BAUND_RATE),
		.SAMP(SAMP),
		.WIDTH(WIDTH)
	)
	uart_inst(
		.clk(clk),
		.reset(reset),
		.data_out(read_value),
		.rx_full(rx_full),
		.rx_empty(rx_empty),
		.tx(tx),
		.data_in(sw),
		.rx(rx),
		.wr_data(do_write),
		.rd_data(do_read)
	);	
	
	// this convertion part handles only numbers
	// if number is captured it will show it through sseg	
	wire conv_tick = (read_value >= 48) && (read_value < 58);
	reg [3:0] bcd;
	wire [3:0] bcd_in;

	always @(posedge clk, posedge reset) begin
		if (reset) bcd <= 0;
		else if (bcd_done) bcd <= bcd_in; 
	end

	bin2bcd #(.WIDTH(8)) get_bcd(
		.clk(clk),
		.reset(reset),
		.bin((read_value-8'd48)),
		.bcd0(bcd_in),
		.start(conv_tick),
		.done_tick(bcd_done)	
	);
	
	assign sseg[7] = 1'b1;	
	bcd2sseg_active_low get_sseg(
		.bcd0(bcd),
		.sseg0(sseg[6:0])
	);		

		
endmodule

`endif
