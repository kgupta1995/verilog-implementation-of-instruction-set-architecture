module decoder (instruction, 
	opcode,
	Rs1,
	Rs2,
	Regdst,
	clk,
	rst,
	imm);
input  [15:0]instruction;
//input reg write_en_dec_in;
//output reg write_en_dec_out;
//input reg [3:0]write_addr_dec_in;
//output reg [3:0] write_addr_dec_out;
//input reg [31:0] write_data_dec_in;
//output reg [31:0] write_data_dec_out;
output reg [3:0] opcode, Rs1, Rs2, Regdst, imm;
input clk, rst;
//reg [15:0]instruction ;

/*always @ (*) begin
write_en_dec_out<= write_en_dec_in;
write_addr_dec_out <= write_addr_dec_in;
write_data_dec_out <= write_data_dec_in;
end
*/

always @ (*) begin
opcode = instruction[15:12];
Rs1 = instruction[11:8];
Rs2 = instruction[7:4];
Regdst = instruction[3:0];
imm = instruction[7:4];
end
endmodule

                                                                                                               
