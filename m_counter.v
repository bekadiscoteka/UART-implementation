`ifndef M_COUNT
	`define M_COUNT
	module m_counter(
		output reg [log(M):0] counter,
		output reg tick,
		input clk, reset
	);
		parameter M=132;
		always @(posedge clk, posedge reset) begin
			if (reset) begin
				counter <= 0;
				tick <= 0;
			end
			else begin
				if (counter == M) begin
					counter <= 0;
					tick <= 1;
				end
				else begin
					counter <= counter + 1;
					tick <= 0;
				end
			end
		end
		function integer log;
			input [31:0] N;
			integer i;
			begin
				for (i=31; !N[31]; i = i-1) 
					N = N << 1;	
				log = i;	
			end	
		endfunction
	endmodule
`endif
