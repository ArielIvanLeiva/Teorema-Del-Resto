module execute_tb();
	logic AluSrc;
	logic [3:0] AluControl;
	logic [63:0] PC_E, signImm_E;
	logic [63:0] readData1_E, readData2_E;
	logic [63:0] PCBranch_E, aluResult_E, writeData_E;
	logic zero_E;
	
	logic [192:0] expected_out;
	
	execute dut ( AluSrc, 
				AluControl,
				PC_E, signImm_E,
				readData1_E, readData2_E,
				PCBranch_E, aluResult_E, writeData_E,
				zero_E );
		
	initial
	begin
		PC_E = 64'd8;
		signImm_E = 64'b1111;
		readData1_E = 64'd13;
		readData2_E = 64'd25;
		AluSrc = 0;
		AluControl = 4'b0010;
		expected_out = {64'd8 + 64'b111100, 64'd13 + 64'd25, 64'd25, 1'b0};
		#4ns;
		if ({PCBranch_E, aluResult_E, writeData_E, zero_E} != expected_out)
			$display("ERROR. Got: %b, expected %b", {PCBranch_E, aluResult_E, writeData_E, zero_E}, expected_out);
		
		#1ns;
		PC_E = 64'hffff0000ffff0000;
		signImm_E = 64'b1111;
		readData1_E = 64'd13;
		readData2_E = 64'd25;
		AluSrc = 1;
		AluControl = 4'b0001;
		expected_out = {64'hffff0000ffff0000 + 64'b111100, 64'd13 | 64'b1111, 64'd25, 1'b0};
		#4ns;
		if ({PCBranch_E, aluResult_E, writeData_E, zero_E} != expected_out)
			$display("ERROR. Got: %b, expected %b", {PCBranch_E, aluResult_E, writeData_E, zero_E}, expected_out);
		
		
	end
endmodule 