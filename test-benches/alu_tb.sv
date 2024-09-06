module alu_tb();
	logic [63:0] a, b;
	logic [63:0] result, expected_result;
	logic [3:0] ALUControl;
	logic zero, expected_zero;
	logic clk;
	
	logic [31:0] vectornum, errors;
	logic [196:0] testvectors [0:20] = '{ { 64'd401, 64'd1321, 4'b0000, 64'(64'd401 & 64'd1321), 1'b0 },
													 { 64'd401, -64'd21, 4'b0000, 64'(64'd401 & -64'd21), 1'b0 },
													 { -64'd21, -64'd312412, 4'b0000, -64'd21 & -64'd312412, 1'b0 },
													 
													 { 64'd401, 64'd1321, 4'b0001, 64'd401 | 64'd1321, 1'b0 },
													 { 64'd401, -64'd21, 4'b0001, 64'd401 | -64'd21, 1'b0 },
													 { -64'd21, -64'd312412, 4'b0001, -64'd21 | -64'd312412, 1'b0 },
													 
													 { 64'd401, 64'd1321, 4'b0010, 64'd401 + 64'd1321, 1'b0 },
													 { 64'd401, -64'd21, 4'b0010, 64'd401 + -64'd21, 1'b0 },
													 { -64'd21, -64'd312412, 4'b0010, -64'd21 + -64'd312412, 1'b0 },
													 
													 { 64'd401, 64'd1321, 4'b0110, 64'd401 - 64'd1321, 1'b0 },
													 { 64'd401, -64'd21, 4'b0110, 64'd401 - -64'd21, 1'b0 },
													 { -64'd21, -64'd312412, 4'b0110, -64'd21 - -64'd312412, 1'b0 },
													 
													 { 64'd401, 64'd1321, 4'b0111, 64'd1321, 1'b0},
													 { 64'd401, -64'd21, 4'b0111, -64'd21, 1'b0},
													 { -64'd21, -64'd312412, 4'b0111, -64'd312412, 1'b0},
													 
													 { 64'd101, 64'b010, 4'b0000, -64'd0, 1'b1},
													 { 64'd0, 64'd0, 4'b0001, 64'd0, 1'b1},
													 { 64'd401, -64'd401, 4'b0010, 64'd0, 1'b1},
													 { 64'd401, 64'd401, 4'b0110, 64'd0, 1'b1},
													 { 64'd401, 64'd0, 4'b0111, 64'd0, 1'b1},
													 
													 // (2**63 - 1) + (2**63 - 1)
													 { 64'd9223372036854775807, 64'd9223372036854775807, 4'b0110, 64'd18446744073709551614, 1'b0}
												  };	
	
	alu dut (a, b, ALUControl, result, zero);
	
	always
	begin
			clk = 1; #5ns; clk = 0; #5ns;
	end
	
	initial
	begin
			a = 0;
			b = 0;
			zero = 0;
			ALUControl = 0;
			expected_zero = 0;
			expected_result = 0;
			vectornum = 0;
			errors = 0;
	end
	
	always @(posedge clk)
	begin
		#1ns;
		{a, b, ALUControl, expected_result, expected_zero}  = testvectors[vectornum];
	end

	always @(negedge clk)
	begin
		if (vectornum < 21)
		begin 
			if (expected_result !== result | expected_zero !== zero)
				begin
					$display("ERROR. Got result value: %b, expected %b", result, expected_result);
					$display("ERROR. Got zero value: %b, expected %b", zero, expected_zero);
					$display("testvector: %b", testvectors[vectornum]);
					errors = errors + 1;
			end
			$display("%d tests and %d errors", vectornum, errors);
			vectornum = vectornum + 1;
		end
	end
endmodule 