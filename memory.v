module memory (Addr,writeData,writeEN,readData,clk);
input [31:0]Addr; //address width
input [31:0]writeData; //bits
input writeEN;
output reg [31:0]readData; //bits
input clk;

reg [ 31:0] mem [ 31 :0]; // element count 

assign readData = mem[Addr]; //read address data is assigned to readData

always @(posedge clk)
 if (writeEN)
   mem[Addr] <= writeData ; // on every clock the data on write address in writting on write data 

endmodule
