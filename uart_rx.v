`ifndef UART_RX
	`define UART_RX
	module uart_rx #(
		parameter DBIT=8,
				  S=16,
				  SB_TICK=S
	)
	(
		output reg [7:0] d_out,
		output reg done_tick,
		input rx, s_tick,
		input clk, reset
	);
		localparam IDLE=0,
				   START=1,
				   DATA=2,
				   STOP=3;

		reg [log(S+1)-1:0] s_reg;
		reg [log(DBIT+1)-1:0] n;
		reg [1:0] state;
		always @(posedge clk, posedge reset) begin
			if (reset) begin
				s_reg <= 0;				
				d_out <= 0;
				state <= 0;
				n <= 0;
				done_tick <= 0;
			end
			else begin
				case (state) 
					IDLE: begin
						s_reg <= 0;
						d_out <= 0;
						n <= 0;
						done_tick <= 0;
						if (!rx) state <= START;
					end
					START: begin
						if (s_tick) begin
							if (s_reg >= (S/2)-1) begin
							   	state <= DATA;
								s_reg <= 0;
							end
							else s_reg <= s_reg +1;
						end

					end
					DATA: begin
						if (s_tick) begin
							if (s_reg == S-1) begin
								s_reg <= 0;
								d_out <= {rx, d_out[DBIT-1:1]};
								if (n == DBIT-1) state <= STOP;
								else n <= n + 1;
							end	
							else s_reg <= s_reg + 1;	
						end	
					end
					STOP: begin
						if (s_tick) begin
							if (s_reg == SB_TICK-1) begin
								done_tick <= 1;
								state <= IDLE;
							end							
							s_reg <= s_reg + 1;
						end
					end
				endcase
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
