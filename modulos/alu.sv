module alu(input logic [63:0] a, b,
			  input logic [3:0] ALUControl,
			  output logic [63:0] result,
			  output logic zero);
			  
	always_comb
	begin
		casez (ALUControl)
			4'b0000: result = a & b;
			4'b0001: result = a | b;
			4'b0010: result = a + b;
			4'b0110: result = a - b;
			4'b0111: result = b;
			default: result = 'x;
		endcase
		zero <= result === 64'b0;
	end
			  
	/*always_comb
	case (ALUControl)
		4'b0000: 
		begin
			result = a & b;
			zero = result === 0;
		end
		4'b0001: 
		begin
			result = a | b;
			zero = result === 0;
		end
		4'b0010: 
		begin
			result = a + b;
			zero = result === 0;
		end
		4'b0110: 
		begin
			result = a - b;
			zero = result === 0;
		end
		4'b0111: 
		begin
			result = b;
			zero = result === 0;
		end*/
	
endmodule 