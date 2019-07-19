module tb();

reg rst, clk, cnt_en, writeEN;
reg [31:0]writeData;
wire [15:0]instruction;
wire [3:0] opcode_dec, opcode_reg, opcode_alu;
wire [3:0] decoder_register1, decoder_register2;
wire [3:0] decoder_desreg, regfile_desreg, alu_desreg;
wire [3:0] imm;
wire [31:0] regfile_read_data0, regfile_read_data1, alu_read_data1;
wire [31:0]alu_output;
wire write_back_enable;
wire [31:0] write_back_data, curr_pc, pc_load_val;
wire [3:0]write_back_address;

reg tb_write_back_enable;
reg [31:0]tb_write_back_data;
reg [3:0]tb_write_back_address;
reg des_write_back_enable;
reg [31:0]des_write_back_data;
reg [3:0]des_write_back_address;
reg load_register;
reg [31:0] inst_mem_write_addr;
reg mem_load;


assign  write_back_enable = load_register?tb_write_back_enable:des_write_back_enable;
assign write_back_data = load_register ?tb_write_back_data:des_write_back_data;
assign write_back_address =  load_register?tb_write_back_address:des_write_back_address;


inst_fetch u_inst_fetch(.rst(rst), // coming from tb (all rst & clk)
	.instruction(instruction),
	.clk(clk), 
	.cnt_en(cnt_en), // coming from tb write_back_data
	.writeEN(writeEN), // coming from tb
	.writeData(writeData),
	.inst_mem_addr(inst_mem_write_addr),
	.mem_load(mem_load),
	.pc_load_en(),
	.pc_load_val(pc_load_val),
	.curr_pc(curr_pc)); // coming from tb

decoder u_decoder(.instruction(instruction), // coming from inst_fetch
	.opcode(opcode_dec),
	.Rs1(decoder_register1),
	.Rs2(decoder_register2),
	.Regdst(decoder_desreg),
	.clk(clk),
	.rst(rst),
	.imm(imm));

regfile u_regfile(.read_addr0(decoder_register1),   //RS1
	.read_addr1(decoder_register2), //RS2 

	.read_data0(regfile_read_data0), 
	.read_data1(regfile_read_data1), 
	.write_addr(write_back_address), // address write back to register from write back stage 
	.write_data(write_back_data), // data comin back from write back stage
	.write_en(write_back_enable), // write en signal coming from write back
    .opcode_reg_in(opcode_dec), // same opcode as we get from decoder 
    .Regdst(decoder_desreg), // coming from decoder (destination register)
    .opcode_reg_out(opcode_reg),
    .Regdst_out(regfile_desreg), // write add of register which we simply transfering to every module
	.clk(clk));

alu u_alu(.A(regfile_read_data0),
	.B(regfile_read_data1),
	.Opcode(opcode_reg),
	.alu_out(alu_output),
	.carry_out(),
	.Regdst_in(decoder_desreg),
	.Regdst_out(alu_desreg),
	.opcode_out(opcode_alu),
	.clk(clk),
	.cmp_out(cmp_out),
	.read_data2_in(regfile_read_data1),
	.read_data2_out(alu_read_data1),
	.imm(imm));

write_back u_write_back(.clk(clk),
	.opcode_out(opcode_alu),
	.alu_out(alu_output),
	.carry_out(),
	.Regdst_out(alu_desreg),
	.read_data2_out(alu_read_data1),
	.write_back_en(des_write_back_enable),
	.write_back_data(des_write_back_data),
	.write_back_addr(des_write_back_address)
	);

branch u_branch( 
	.clk(clk), 
	.cmp_out(cmp_out), 
	.rst(rst),
	.curr_pc(curr_pc), 
	.pc_load_en(pc_load_en), 
	.pc_load_val(pc_load_val), 
	.branch_offset(decoder_desreg),
	.opcode(opcode_dec));



initial begin
clk = 0;
rst = 0;
cnt_en = 1'b0;
@(posedge clk);
rst = 1;
@(posedge clk);
rst = 0;
cnt_en = 1'b0;
writeEN = 1;
mem_load = 1;
@(posedge clk);
writeData = 32'h1020;
inst_mem_write_addr = 0;
@(posedge clk);
writeData = 32'h1030;
inst_mem_write_addr = 1;
@(posedge clk);
writeData = 32'h6130;
inst_mem_write_addr = 1;
@(posedge clk);
writeData = 32'h9031;
inst_mem_write_addr = 1;
@(posedge clk);
writeData = 32'h4102;
inst_mem_write_addr = 1;
@(posedge clk);
writeData = 32'h7420;
inst_mem_write_addr = 1;
@(posedge clk);
writeData = 32'h1330;
inst_mem_write_addr = 1;
mem_load = 0;
@(posedge clk);
load_register = 1;
tb_write_back_enable = 1;
tb_write_back_address = 0;
tb_write_back_data = 2;
@(posedge clk);
@(posedge clk);
tb_write_back_enable = 1;
tb_write_back_address = 1;nnn        
tb_write_back_data = 2;
@(posedge clk);
tb_write_back_enable = 1;
tb_write_back_address = 1;
tb_write_back_data = 2;
@(posedge clk);
tb_write_back_enable = 1;
tb_write_back_address = 3;
tb_write_back_data = 2;
load_register = 0;
@(posedge clk);
tb_write_back_enable = 0;
@(posedge clk);
@(posedge clk);
@(posedge clk);
writeEN = 0;


cnt_en = 1'b1;
#100;
$finish;
end

always #5 clk = !clk;
endmodule
