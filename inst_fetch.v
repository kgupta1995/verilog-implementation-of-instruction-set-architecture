module inst_fetch (rst,
	instruction,
	clk, 
	cnt_en,
	writeEN, 
	writeData,
	inst_mem_addr,
	mem_load,
	pc_load_en,
	pc_load_val,
	curr_pc 
	);

input clk, rst, cnt_en, mem_load, pc_load_en;
input writeEN;
input [31:0] inst_mem_addr; 
input [31:0] writeData, pc_load_val;
output reg [15:0]instruction;
output reg [31:0] curr_pc;


wire [31:0]address_wire,  pc_address;
wire [31:0]rd_data;

assign instruction = rd_data;
assign address_wire = mem_load?inst_mem_addr:pc_address;

memory u_memory_inst_1(.Addr(address_wire),
           .writeData(writeData), //to be driven from TB
           .writeEN(writeEN),    //to be driven from TB
           .readData(rd_data),
           .clk(clk));

program_counter u_pc_1 (.clk(clk),
                       .rst(rst),
                       .counter(pc_address),
                       .cnt_en(cnt_en),
			.load_val(pc_load_val),
			.load_en(pc_load_en));

endmodule

