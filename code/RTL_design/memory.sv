`define WIDTH 8     //no of bits in memory location
`define DEPTH 32    //no of memory location 
`define ADDR_WIDTH $clog2(`DEPTH)  //size=width*depth in bits
module memory(clk,rst,addr,wr_rd,wdata,rdata,valid,ready);
input clk,rst,valid,wr_rd;
input [`ADDR_WIDTH-1:0]addr;
input [`WIDTH-1:0]wdata;
output reg[`WIDTH-1:0]rdata;
output reg ready;
reg [`WIDTH-1:0] mem [`DEPTH-1:0];
int i;
always@(posedge clk) begin
if(rst==1) begin  //reg signals=0
rdata=0;
//wdata=0;
ready=0;
for(i=0;i<`DEPTH;i++) 
mem[i]=0;
end
else begin 
if(valid==1) begin  //check for handshaking signals
ready=1;
if(wr_rd==1)       //sent by processor to memory
mem[addr]=wdata;  
else 
rdata=mem[addr];   //memory to processor
end
else ready=0;
end
end
endmodule
