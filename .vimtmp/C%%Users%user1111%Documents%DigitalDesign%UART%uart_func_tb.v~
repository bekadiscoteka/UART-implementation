`include "uart_top.v"

module stimulus;
	reg clk=0, reset=0, write=0, read=0;
	reg [7:0] sw;
	wire rx, tx;
	wire [7:0] read_value;
	wire tx_empty, rx_empty;

	initial forever #5 clk = ~clk;	

	uart ut(
		.clk(clk),
		.reset(reset),
		.wr_data(write),
		.rd_data(read),
		.rx(rx),
		.tx(tx),
		.data_in(sw),
		.data_out(read_value),
		.rx_empty(rx_empty),
		.tx_empty(tx_empty)
	);

	assign rx = tx;

	initial begin
		reset=1;
		@(posedge clk);
		reset=0;
		sw=0;
		write=1;
		for (sw=48; sw<6; sw=sw+1) begin
			@(posedge clk);
			$display("write: %d", sw);				
		end
		write=0;
		wait(tx_empty); //the last write may be omitted
		read=1;
		while(!rx_empty) begin
			$display("read: %d", read_value);
			@(posedge clk);	
		end
		$display("last: %d", read_value);
		$finish;



	end	
endmodule
