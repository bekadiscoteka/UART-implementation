`ifndef FALL_EDGE
	`define FALL_EDGE
	module fall_edge_detector(
		output tick, input in, clk, reset
	);
		localparam [1:0]
		UNKNOWN=0,
		LOW=1,
		TICK=2,
		HIGH=3;
		reg [1:0] state;

		assign tick = state == TICK;

		always @(posedge clk, posedge reset) begin
			if (reset) state <= 0;
			else begin
				case (state) 
					UNKNOWN: state <= in ? HIGH : LOW;
					HIGH: if (!in) state <= TICK;
					TICK: state <= in ? HIGH : LOW;
					LOW: if (in) state <= HIGH; 
				endcase
			end
		end
	endmodule
`endif
