
module register(clk, alusrc, regwrite, instdata, wdata, data_s, data_t);
   input clk;
   input regwrite;
   input alusrc;
   input [31:0] instdata;
   input [31:0] wdata;
   output [31:0] data_s;
   output [31:0] data_t;
   
   reg [31:0] dvalue[31:0];
  
   wire [4:0] rs_n;
   wire [4:0] rt_n;
   wire [4:0] rd_n;
      
   assign rs_n = instdata[25:21];
   assign rt_n = instdata[20:16];
   assign rd_n = instdata[15:11];
         
   assign data_s = dvalue[rs_n];      // output of source register.
   assign data_t = dvalue[rt_n];      // output of target register.
      
   always @(posedge clk) begin
      dvalue[0] <= 0;
      if(regwrite && !alusrc)      // When regwrite asserts and alu operation,
         dvalue[rd_n] <= wdata;      // Write data in rd.
      else if(regwrite && alusrc)      // When regwrite asserts and it used immi,
         dvalue[rt_n] <= wdata;      // Write data in rt.
      else
         dvalue[rs_n] <= dvalue[rs_n];
   end
   
endmodule
