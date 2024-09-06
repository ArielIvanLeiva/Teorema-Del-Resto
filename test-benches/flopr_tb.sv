module flopr_tb();
	logic clk;
	logic reset;                                      
	logic [63:0] data_in, data_out, expected_out;
	logic [31:0] vectornum, errors;
	logic [127:0] testvectors [0:9] = '{ {64'd10, 64'd0}, 
													 {64'd21, 64'd0},
													 {64'd41, 64'd0},
													 {64'd44, 64'd0},
													 {64'd151375, 64'd0},
													 {64'd999999, 64'd999999},
													 {64'd31, 64'd31},
													 {64'd0, 64'd0},
													 {64'd124124124, 64'd124124124},
													 {64'd12121212, 64'd12121212}
													};


	// Instantiate flopr under test
	flopr #(.N(64)) flopr_ut (
		.clk(clk),
		.reset(reset),
		.d(data_in),
		.q(data_out)
	);
	
	// Generate clock signal
	always
		begin
			clk = 1; #5ns; clk = 0; #5ns;
		end
	
	// Start test
	initial
		begin
			vectornum = 32'b0; errors = 32'b0; reset = 1; #51ns;
			reset = 0;
		end
		
	always @(posedge clk)
		begin
			#1ns; data_in = testvectors[vectornum][127:64];
			if (reset)
				expected_out = 64'b0;
			else
				expected_out = testvectors[vectornum-1][63:0];
		end
	
	always @(negedge clk)
		begin
			if (vectornum <= 10)
				begin
				if (data_out !== expected_out)
					begin
						$display("ERROR. Got: %b, expected %b", data_out, expected_out);
						$display("testvector: %b", testvectors[vectornum]);
						errors = errors + 1;
				end
				$display("%d tests and %d errors", vectornum, errors);
				vectornum = vectornum + 1;
			end
		end		
endmodule 