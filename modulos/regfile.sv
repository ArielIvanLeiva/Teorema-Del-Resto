module regfile(input logic clk, we3,
					input logic [4:0] ra1, ra2, wa3,
					input logic [63:0] wd3,
					output logic [63:0] rd1, rd2);
	
	logic [63:0] file [30:0] = '{64'b0, 64'b0, 64'b0, 64'b0,
										  64'b0, 64'b0, 64'b0, 64'b0,
										  64'b0, 64'b0, 64'b0, 64'b0,
										  64'b0, 64'b0, 64'b0, 64'b0,
										  64'b0, 64'b0, 64'b0, 64'b0,
										  64'b0, 64'b0, 64'b0, 64'b0,
										  64'b0, 64'b0, 64'b0, 64'b0,
										  64'b0, 64'b0, 64'b0};
	
	always_comb
	begin
		rd1 = ra1 != 5'd31 ? file[ra1]: 64'b0;
		rd2 = ra2 != 5'd31 ? file[ra2]: 64'b0;
	end
	
	always_ff @(posedge clk)
	begin
		if(we3)
		begin
			if(wa3 != 31)
				file[wa3] = wd3;
		end
	end
	
	
endmodule 