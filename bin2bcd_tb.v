`include "bin2bcd.v"

module stimulus;
	reg clk=0, reset=0, start=0;
	reg [3:0] bin = 15;
	wire [3:0] bcd3, bcd2, bcd1, bcd0;
	wire done;
	bin2bcd #(.WIDTH(4)) conv(
		.clk(clk),
		.reset(reset),
		.bin(bin),
		.bcd3(bcd3),
		.bcd2(bcd2),
		.bcd1(bcd1),
		.bcd0(bcd0),
		.done_tick(done),
		.start(start)
	);
	
	initial forever #1 clk = ~clk;

	initial begin
		reset=1;
		@(posedge clk);
		reset=0;
		@(posedge clk);

		start = 1;
		wait(done);
		$display("%d%d", bcd1, bcd0);
		$finish;
	end
endmodule
