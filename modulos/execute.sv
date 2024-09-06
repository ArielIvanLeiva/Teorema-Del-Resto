module execute #(parameter N=64) (input logic AluSrc,
					input logic [3:0] AluControl,
					input logic [N-1:0] PC_E, signImm_E,
					input logic [N-1:0] readData1_E, readData2_E,
					output logic [N-1:0] PCBranch_E, aluResult_E, writeData_E,
					output logic zero_E);
	
		logic [N-1:0] out_mux, out_sl2, out_adder;
		logic out_zero;
		
		mux2 #(.N(N)) my_mux (readData2_E, signImm_E, AluSrc, out_mux);
		sl2 #(.N(N)) my_sl2 (signImm_E, out_sl2);
		adder #(.N(N)) my_adder (PC_E, out_sl2, PCBranch_E);
		alu my_alu (readData1_E, out_mux, AluControl, aluResult_E, out_zero);
		
		assign writeData_E = readData2_E;
		assign zero_E = out_zero;
	
endmodule 