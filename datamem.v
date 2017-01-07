
module datamem(clk, memwrite, memread, wdata, addr, rdata);
  input clk;
  input memwrite, memread;
  input [31:0] addr;
  input [31:0] wdata;
  output [31:0] rdata;
  
  reg [31:0] mem[1023:0];      
  reg [31:0] rdata;
  
  always @(posedge clk) begin
    if(memwrite)      // when memwrite == 1,
       mem[addr] <= wdata;      // write data.
    else      // when memwrite == 0
       mem[addr] <= mem[addr];      // do nothing.
  end
  
  always @(posedge clk) begin
      if(memread)      // when memread == 1,
         rdata <= mem[addr];      // read data.
      else      // when memread == 0,
         mem[addr] <= mem[addr];      // do nothing.
  end
  
endmodule
