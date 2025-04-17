`include "uart_top.v"
`timescale 1ns / 1ns
module clk_generate(output reg clk);
	initial begin
		clk=0;
	   	forever #10 clk = ~clk;
	end
endmodule
`timescale 1ms / 1ns
module stimulus;
	reg reset=0, write=1, read=1;
	reg [7:0] sw;
	wire rx, tx;
	wire [7:0] leds;
	wire clk;	

	clk_generate clk_gen(clk);
		
	uart_top ut(
		.clk(clk),
		.reset(reset),
		.write(write),
		.read(read),
		.rx(rx),
		.tx(tx),
		.sw(sw),
		.read_value(read_value)
	);

	assign rx = tx;

	initial begin
		reset=1;
		$display("reset start");
		#5;
		reset=0;
		#5;
		$display("reset over");
		for (sw=1; sw<3; sw = sw+1) begin
			write=0;
			#5;
			write=1;
			#5;
			$display("sent value: %d", sw);
		end
		$display("end sending");	
		$display("right now leds: %d", leds);
		repeat(3) begin
			read=0;
			#5;
			read=1;
			#5;
			$display(leds);
		end	
		$finish;	
	end
endmodule
