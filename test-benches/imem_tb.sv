`define N 32
module imem_tb();
	logic [5:0] addr;
	logic [`N-1:0] q;
	logic clk;
	logic [5:0] testnum, errors;
	logic [`N-1:0] expected_values [0:63] = '{32'hf8000001,
										32'hf8008002,
										32'hf8000203,
										32'h8b050083,
										32'hf8018003,
										32'hcb050083,
										32'hf8020003,
										32'hcb0a03e4,
										32'hf8028004,
										32'h8b040064,
										32'hf8030004,
										32'hcb030025,
										32'hf8038005,
										32'h8a1f0145,
										32'hf8040005,
										32'h8a030145,
										32'hf8048005,
										32'h8a140294,
										32'hf8050014,
										32'haa1f0166,
										32'hf8058006,
										32'haa030166,
										32'hf8060006,
										32'hf840000c,
										32'h8b1f0187,
										32'hf8068007,
										32'hf807000c,
										32'h8b0e01bf,
										32'hf807801f,
										32'hb4000040,
										32'hf8080015,
										32'hf8088015,
										32'h8b0103e2,
										32'hcb010042,
										32'h8b0103f8,
										32'hf8090018,
										32'h8b080000,
										32'hb4ffff82,
										32'hf809001e,
										32'h8b1e03de,
										32'hcb1503f5,
										32'h8b1403de,
										32'hf85f83d9,
										32'h8b1e03de,
										32'h8b1003de,
										32'hf81f83d9,
										32'hb400001f,
										32'h00000000, 
										32'h00000000, 
										32'h00000000, 
										32'h00000000, 
										32'h00000000, 
										32'h00000000, 
										32'h00000000, 
										32'h00000000, 
										32'h00000000, 
										32'h00000000, 
										32'h00000000, 
										32'h00000000, 
										32'h00000000, 
										32'h00000000, 
										32'h00000000, 
										32'h00000000, 
										32'h00000000};
										
	imem #(.N(32)) dut (.addr(addr), .q(q));
	
	always 
	begin
		clk = 1; #5ns; clk = 0; #5ns;
	end
	
	initial
	begin
		addr = 0;
		testnum = 0;
		errors = 0;
	end
	
	always @(posedge clk)
	begin
		addr = testnum;
	end	
	
	always @(negedge clk)
	begin
		if (testnum < 64) begin
			if (q !== expected_values[testnum]) begin
				$display("addr: %b", addr);
				$display("ERROR. Got: %b, expected %b", q, expected_values[testnum]);
				errors = errors + 1;
			end
			
			$display("%d tests and %d errors", testnum, errors);
			testnum = testnum + 1;
		end
	end	
	
endmodule 