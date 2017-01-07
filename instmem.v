
module instmem(clk, addr, im_write, im_addr, im_wdata, inst);
  input clk;
  input [31:0] addr;
  input im_write;
  input [31:0] im_addr;
  input [31:0] im_wdata;
  output [31:0] inst;
  
  reg [31:0] mem[1023:0];      // 4KB memory.
 
  assign inst = (im_write)? 32'b0 : mem[addr];

  always @(posedge clk) begin
      if(im_write)
         mem[im_addr] <= im_wdata;
      else
         mem[im_addr] <= mem[im_addr];
  end

   
   
   
endmodule
