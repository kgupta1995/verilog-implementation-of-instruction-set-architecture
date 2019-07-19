module branch( clk, 
	cmp_out, 
	rst,
	curr_pc, 
	pc_load_en, 
	pc_load_val, 
	branch_offset,
	opcode);

input clk, cmp_out, rst;
input [3:0] branch_offset,opcode;
input [31:0] curr_pc;
output reg pc_load_en;
output reg [31:0] pc_load_val;

always@(*)begin
  if(rst == 1) begin
    pc_load_en = 0;
    pc_load_val = 0;
  end
  else if(cmp_out == 1 && opcode == 6)begin
    pc_load_en = 1;
    pc_load_val = curr_pc+1+branch_offset;
  end
 else if(cmp_out == 0 && opcode == 7)begin
    pc_load_en = 1;
    pc_load_val = curr_pc+1+branch_offset;
  end
  else begin
    pc_load_en = 0;
    pc_load_val = 0;
  end

end


endmodule
