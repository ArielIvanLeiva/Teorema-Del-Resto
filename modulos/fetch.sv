module fetch #(parameter N=64) (input logic PCSrc_F, clk, reset,
				 input logic [N-1:0] PCBranch_F,
				 output logic [N-1:0] imem_addr_F);
	
	logic [N-1:0] out_pc;
	logic [N-1:0] out_adder;
	logic [N-1:0] out_mux;
	
	flopr #(.N(N)) pc (clk, reset, out_mux, out_pc);
	
	adder #(.N(N)) add (out_pc, N'('d4), out_adder);
	
	mux2 #(.N(N)) my_mux (out_adder, PCBranch_F, PCSrc_F, out_mux);
	
	assign imem_addr_F = out_pc;
	
endmodule 