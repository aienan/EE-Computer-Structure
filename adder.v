
module adder(data_1, data_2, result);
    input [31:0] data_1;
    input [31:0] data_2;
    output [31:0] result;
    
    assign result = data_1 + data_2;
    
endmodule
