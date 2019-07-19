// Here the counter increases by 1 because memory is 32 bit addressable
module program_counter(clk,
	rst,
	counter,
	cnt_en,
	load_val,
	load_en);

input clk,rst, cnt_en,load_en;
input [31:0] load_val;
output reg [31:0] counter;


always @(posedge clk or posedge rst)
begin
if(rst)
 begin
 counter <= 31'd0;
 end
else if (cnt_en == 1'b1)
begin
 counter <= counter + 31'd1;
end 
else begin
  counter <= counter;
end
end
endmodule
