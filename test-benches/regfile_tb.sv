module regfile_tb();
	logic clk;
	logic [31:0] vectornum, errors;
	
	logic we3;
	logic [4:0]  wa3;
	logic [63:0] wd3;
	logic [69:0] write_testvector[0:4] = '{ {1'b1, 5'd4, 64'd127},
												  {1'b1, 5'd5, 64'd91241},
												  {1'b0, 5'd5, 64'd90},
												  {1'b1, 5'd31, 64'd52351},
												  {1'b0, 5'd31, 64'd52351}
												};
	
	logic [4:0] ra1, ra2;
	logic [63:0] rd1, rd2, expected_rd1, expected_rd2;
	logic [137:0] read_testvector[0:4] = '{ {5'd4, 5'd1, 64'd0, 64'd0},
												  {5'd4, 5'd1, 64'd127, 64'd0},
												  {5'd4, 5'd5, 64'd127, 64'd91241},
												  {5'd4, 5'd5, 64'd127, 64'd91241},
												  {5'd4, 5'd31, 64'd127, 64'd0}
												};
	
	regfile dut (clk, we3, ra1, ra2, wa3, wd3, rd1, rd2);
	
	always
	begin
		clk = 1; #5ns; clk = 0; #5ns;
	end
	
	initial begin
		vectornum = 0;
		errors = 0;
	
		{we3, wa3, wd3} = '{70'b0};
		{ra1, ra2, expected_rd1, expected_rd2} = '{138'b0};
	end
	
	always @(posedge clk)
	begin
		#1ns;
		{we3, wa3, wd3} = write_testvector[vectornum];
		{ra1, ra2, expected_rd1, expected_rd2} = read_testvector[vectornum];
	end
	
	always @(negedge clk)
	begin
		if (vectornum < 5)
		begin 
			if (rd1 !== expected_rd1)
				begin
					$display("ERROR. Got rd1: %d, expected %d", rd1, expected_rd1);
					errors = errors + 1;
			end
			else
				$display("Fine rd1: %d", rd1);
			
			
			if (rd2 !== expected_rd2)
				begin
					$display("ERROR. Got rd2: %d, expected %d", rd2, expected_rd2);
					errors = errors + 1;
			end
			else
				$display("Fine rd2: %d", rd2);
			
			$display("%d tests and %d errors", vectornum, errors);
			vectornum = vectornum + 1;
		end
	end
	
endmodule 