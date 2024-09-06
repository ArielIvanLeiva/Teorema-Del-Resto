module fetch_tb();

	logic PCSrc_F, clk, reset;
	logic [63:0] PCBranch_F;
	logic [63:0] imem_addr_F;

	fetch dut (PCSrc_F, clk, reset, PCBranch_F, imem_addr_F);
	
	always
	begin
		clk = 1; #5ns; clk = 0; #5ns;
	end
	
	initial 
	begin
		reset = 1;
		PCSrc_F = 0;
		PCBranch_F = 64'd127;
		#49ns;
		reset = 0;
		if (imem_addr_F != 64'b0)
			$display("ERROR. Got: %b, expected %b", imem_addr_F, 64'b0);
		else
			$display("Fine. Got: %b", imem_addr_F);
		
		#2ns;
		if (imem_addr_F != 64'd4)
			$display("ERROR. Got: %b, expected %b", imem_addr_F, 64'd4);
		else
			$display("Fine. Got: %b", imem_addr_F);
		
		#10ns;
		if (imem_addr_F != 64'd8)
			$display("ERROR. Got: %b, expected %b", imem_addr_F, 64'd8);
		else
			$display("Fine. Got: %b", imem_addr_F);
			
		#10ns;
		if (imem_addr_F != 64'd12)
			$display("ERROR. Got: %b, expected %b", imem_addr_F, 64'd12);
		else
			$display("Fine. Got: %b", imem_addr_F);
		
		PCSrc_F = 1;
		#10ns;
		if (imem_addr_F != 64'd127)
			$display("ERROR. Got: %b, expected %b", imem_addr_F, 64'd127);
		else
			$display("Fine. Got: %b", imem_addr_F);
		
	end
endmodule 