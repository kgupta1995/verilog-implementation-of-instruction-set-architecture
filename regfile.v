module regfile(read_addr0,   //RS1
	read_addr1, //RS2 
	read_data0, 
	read_data1, 
	write_addr,
	write_data,
	write_en,
    	opcode_reg_in,
    	Regdst,
    	opcode_reg_out,
    	Regdst_out,
	clk);

input [3:0] read_addr0;
input [3:0] read_addr1;
input [3:0] write_addr;
input [31:0] write_data;
input write_en;
input [3:0] opcode_reg_in;
input [3:0]  Regdst;
output reg [3:0] opcode_reg_out;
output reg [3:0] Regdst_out;
output [31:0] read_data0;
output [31:0] read_data1;
input clk;

reg [31:0] read_data0, read_data1;
reg [31:0] reg_write_data[0:15];
reg [31:0] regload;

wire [31:0] regdata[0:15];

genvar i ;
generate 
for (i=0;i<16;i=i+1)
begin 

register u_r_1 (.data_in(reg_write_data[i]),
	            .data_out(regdata[i]),
	            .load_en(regload[i]),
                .clk(clk));
end 

always@(*) begin
 opcode_reg_out <= opcode_reg_in;
 Regdst_out <=  Regdst;
end

always@(*) begin
  case(read_addr0)
    6'd0 : read_data0 = regdata[0];
    6'd1 : read_data0 = regdata[1];
    6'd2 : read_data0 = regdata[2];
    6'd3 : read_data0 = regdata[3];
    6'd4 : read_data0 = regdata[4];
    6'd5 : read_data0 = regdata[5];
    6'd6 : read_data0 = regdata[6];
    6'd7 : read_data0 = regdata[7];
    6'd8 : read_data0 = regdata[8];
    6'd9 : read_data0 = regdata[9];
    6'd10: read_data0 = regdata[10];
    6'd11: read_data0 = regdata[11];
    6'd12: read_data0 = regdata[12];
    6'd13: read_data0 = regdata[13];
    6'd14: read_data0 = regdata[14];
    6'd15: read_data0 = regdata[15];
    
    
    default: read_data0 = regdata[0];
  endcase
end

always@(*) begin
  case(read_addr1)
    6'd0 : read_data1 = regdata[0];
    6'd1 : read_data1 = regdata[1];
    6'd2 : read_data1 = regdata[2];
    6'd3 : read_data1 = regdata[3];
    6'd4 : read_data1 = regdata[4];
    6'd5 : read_data1 = regdata[5];
    6'd6 : read_data1 = regdata[6];
    6'd7 : read_data1 = regdata[7];
    6'd8 : read_data1 = regdata[8];
    6'd9 : read_data1 = regdata[9];
    6'd10: read_data1 = regdata[10];
    6'd11: read_data1 = regdata[11];
    6'd12: read_data1 = regdata[12];
    6'd13: read_data1 = regdata[13];
    6'd14: read_data1 = regdata[14];
    6'd15: read_data1 = regdata[15];

    default: read_data1 = regdata[0];
  endcase
end

always@(*) begin
  if(write_en ==  1'b1) begin
    case(write_addr)
      6'd0 : reg_write_data[0] = write_data; 
      6'd1 : reg_write_data[1] = write_data; 
      6'd2 : reg_write_data[2] = write_data; 
      6'd3 : reg_write_data[3] = write_data; 
      6'd4 : reg_write_data[4] = write_data; 
      6'd5 : reg_write_data[5] = write_data; 
      6'd6 : reg_write_data[6] = write_data; 
      6'd7 : reg_write_data[7] = write_data;
      6'd8 : reg_write_data[8] = write_data; 
      6'd9 : reg_write_data[9] = write_data; 
      6'd10: reg_write_data[10] = write_data; 
      6'd11: reg_write_data[11] = write_data; 
      6'd12: reg_write_data[12] = write_data; 
      6'd13: reg_write_data[13] = write_data; 
      6'd14: reg_write_data[14] = write_data; 
      6'd15: reg_write_data[15] = write_data;
      default:; 
    endcase
  end
end

always@(*) begin
  case(write_addr)
    6'd0 : regload = 16'b0000_0000_0000_0001;
    6'd1 : regload = 16'b0000_0000_0000_0010;
    6'd2 : regload = 16'b0000_0000_0000_0100;
    6'd3 : regload = 16'b0000_0000_0000_1000;
    6'd4 : regload = 16'b0000_0000_0001_0000;
    6'd5 : regload = 16'b0000_0000_0010_0000;
    6'd6 : regload = 16'b0000_0000_0100_0000;
    6'd7 : regload = 16'b0000_0000_1000_0000;
    6'd8 : regload = 16'b0000_0001_0000_0000;
    6'd9 : regload = 16'b0000_0010_0000_0000;
    6'd10: regload = 16'b0000_0100_0000_0000;
    6'd11: regload = 16'b0000_1000_0000_0000;
    6'd12: regload = 16'b0001_0000_0000_0000;
    6'd13: regload = 16'b0010_0000_0000_0000;
    6'd14: regload = 16'b0100_0000_0000_0000;
    6'd15: regload = 16'b1000_0000_0000_0000;
    default: regload = 16'b0000_0000_0000_0000;

  endcase
end
endgenerate

endmodule
