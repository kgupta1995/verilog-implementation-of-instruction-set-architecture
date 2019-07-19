module write_back(clk,
	opcode_out,
	alu_out,
	carry_out,
	Regdst_out,
	read_data2_out,
	write_back_en,
	write_back_data,
	write_back_addr
	);


input clk;
input [3:0]opcode_out;
input [31:0]alu_out;
input carry_out;
input [3:0] Regdst_out;
input [31:0] read_data2_out;

output reg write_back_en;
output reg [31:0]write_back_data;
output reg [3:0]write_back_addr;

reg mem_write_en;
wire [31:0]rd_data;
wire carryout;

/*connector_alu u_c_1 (.Rd_alu_out(rd_mem_out),
                 .alu_out(addr),   
                 .OPCODE(opcode_out),
                 .read_data2(rd_data2),
                 .Rd_mem_out(rd_mem_out),
                 .carry_out(carryout),
                 .carry_out(carryout),
                 .instruction(),
                 .clk_in(),
                 .write_en(),
                 .write_data(),
                 .write_addr()
                    );
*/

// output reg [31:0] read_data2_rread_data2_outead_data2_outout;
memory u_memory_1 (.Addr(alu_out),
            .writeData(read_data2_out),
            .readData(rd_data),
            .writeEN(mem_write_en),
            .clk(clk));

always @(posedge clk)
begin
	write_back_addr <= Regdst_out;
end

always @(posedge clk)
begin
 if (opcode_out == 0100)
  begin
    mem_write_en <= 1;
  end
 else if (opcode_out == 0101)
  begin 
    mem_write_en <= 0;
  end
 else 
  mem_write_en <= 0;
end
always @(posedge clk)
begin
 if (opcode_out < 5)
   begin 
      write_back_en <= 1;
   end
 else begin
    write_back_en <= 0;        
  end
end

always @(posedge clk)
begin
 if (opcode_out == 1) 
begin
write_back_data <= rd_data ;
end
 else 
begin
//write_back_data  <= read_data2_out; // since alu _out is connected to memmory address by wire addr so same wire is used to connect.
write_back_data  <= alu_out; // since alu _out is connected to memmory address by wire addr so same wire is used to connect.
end
end




endmodule 
    
         
