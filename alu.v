module alu (A,
	B,
	Opcode,
	alu_out,
	carry_out,
	Regdst_in,
	Regdst_out,
	opcode_out,
	clk,
        cmp_out,
	read_data2_in,
	read_data2_out,
	imm);
input [31:0]A,B;
input [3:0]Opcode;
input [31:0] read_data2_in;
input [3:0]Regdst_in, imm;
input clk;
output reg cmp_out;
output reg [31:0] read_data2_out;
output reg [3:0] opcode_out;
output [31:0]alu_out;
output carry_out;
output reg [3:0]Regdst_out;

reg [31:0]ALU_OUT;
wire [32:0] tmp;

assign alu_out = ALU_OUT;
assign tmp = {1'b0,A} + {1'b0,B};
assign carry_out = tmp[32];
assign immediate_bit = B;
// opcode operation
// 0000    A + B
// 0001    A+ immediate bit     
// 0010    A-B
// 0011    A - immediate bit
// 0100    Mem(A + immediate bit)
// 0101    Mem(A +immediate bit) = alu_out
// 0110    if A = B ; PC = PC+ 4+ branch target
// 0111    if A != B; PC= PC+4+ Branch target
// 1000    add bytes
// 1001    add bytes immediate
// 1010    jump
// 1011   default
// 1100    default
// 1101    default
// 1110    default
// 1111    default

always @(posedge clk) begin
Regdst_out <= Regdst_in ;
read_data2_out <= read_data2_in ;
opcode_out <= Opcode ;
end 

always @(posedge clk)
begin
  case (Opcode)
  4'b0000: 
  ALU_OUT = A+B;
  4'b0001:
  ALU_OUT = A + 32'hFFFFFFFF|imm;
  4'b0010:
  ALU_OUT = A - B;
  4'b0011:
  ALU_OUT = A - 32'hFFFFFFFF|imm;
  4'b0100:
  ALU_OUT = A +  32'hFFFFFFFF|imm;
  4'b0101:
  ALU_OUT = A +  32'hFFFFFFFF|imm;
  4'b0110: 
  ALU_OUT= A==B  ;
  4'b0111: 
  ALU_OUT = A != B ;
  4'b1000:
  ALU_OUT = A + (B << 2);
  4'b1001:
  ALU_OUT = A + (32'hFFFFFFFF|imm << 2) ;
  
  default: ALU_OUT= A+B ;
  
endcase
end
 
always @(posedge clk)
begin 
if ( A == B) begin
 cmp_out = 1;
end
else begin
cmp_out = 0;
end 
end
endmodule
