module fetch(input logic PCSrc_F, clk, reset,
				 input logic [63:0] PCBranch_F,
				 output logic [63:0] imem_addr_F);
	
	logic [63:0] out_pc;
	logic [63:0] out_adder;
	logic [63:0] out_mux;
	
	flopr #(.N(64)) pc (clk, reset, out_mux, out_pc);
	
	adder #(.N(64)) add (out_pc, 64'd4, out_adder);
	
	mux2 #(.N(64)) my_mux (out_adder, PCBranch_F, PCSrc_F, out_mux);
	
	assign imem_addr_F = out_pc;
	
endmodule 