
module control(clk, instdata, sigctrl);
    input clk;
    input [31:0] instdata;
    output [9:0] sigctrl;
    
    wire [5:0] opcode;
    
    assign opcode = instdata[31:26];
    
    assign sigctrl = (opcode == 1)? 10'b0_1_0_0001_1_1_0 :       // When it directs load word,
                     (opcode == 2)? 10'b0_0_1_0001_1_0_0 :      // When it directs store word,
                     (opcode == 3)? 10'b1_0_0_0001_0_1_0 :      // When it directs add,
                     (opcode == 4)? 10'b1_0_0_0001_1_1_0 :      // When it directs addi,
                     (opcode == 5)? 10'b1_0_0_0010_0_1_0 :      // When it directs sub,
                     (opcode == 6)? 10'b1_0_0_0011_0_1_0 :      // When it directs division,
                     10'b0;      // otherwise.
  
endmodule
