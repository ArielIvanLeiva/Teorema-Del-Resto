module signext_tb();
	logic [31:0] a;
	logic [63:0] y, yexpected;
	logic clk;
	logic [31:0] vectornum, errors;
	logic [95:0] testvectors [0:7] = '{ { {11'b111_1100_0010, 9'b010, 12'b0}, 64'b010 },
													{ {11'b111_1100_0010, 9'b1_1000_0000, 12'b0}, {55{1'b1}}, 9'b1_1000_0000  },
													{ {11'b111_1100_0000, 9'b1111, 12'b0}, 64'b1111 },
													{ {11'b111_1100_0000, 9'b1_0000_0000, 12'b0}, {55{1'b1}}, 9'b1_0000_0000 },
													{ {8'b101_1010_0, 19'b000_0000_0000_0001_0010, 5'b1}, 43'b0, 19'b000_0000_0000_0001_0010 , 2'b00},
													{ {8'b101_1010_0, 19'b100_0000_0000_0001_0010, 5'b10010}, {43{1'b1}}, 19'b100_0000_0000_0001_0010, 2'b00 },
													{ {11'b101_0101_0000, 9'b010, 12'b0}, 64'b0 },
													{ {9'b1_1010_0101, 2'b0, 16'b010, 5'b0}, 64'b0 }
												};
	
	signext dut (a, y);
	
	always
	begin
			clk = 1; #5ns; clk = 0; #5ns;
	end
	
	initial
	begin
			a = 0;
			yexpected = 0;
			vectornum = 0;
			errors = 0;
	end
	
	always @(posedge clk)
	begin
		#1ns;
		{a, yexpected}  = testvectors[vectornum];
	end

	always @(negedge clk)
	begin
		if (vectornum < 8)
		begin 
			if (y !== yexpected)
				begin
					$display("ERROR. Got: %b, expected %b", y, yexpected);
					$display("testvector: %b", testvectors[vectornum]);
					errors = errors + 1;
			end
			$display("%d tests and %d errors", vectornum, errors);
			vectornum = vectornum + 1;
		end
	end
endmodule 