
module alu(rstn, clk, aluctrl, data_s, data_t, zero, result);
    input rstn, clk;
    input [3:0] aluctrl;
    input [31:0] data_s;
    input [31:0] data_t;
    output zero;
    output [31:0] result;
    
    wire [31:0] result;
    reg [31:0] divresult;
    reg [31:0] remainder;
    wire zero;
    
    assign zero = ( data_s - data_t == 0 )? 0 : 1;      // when data_s = data_t, zero = 0, otherwise zero = 1.
    assign result = (aluctrl == 1)? data_s + data_t :      // when addition is asserted,
                    (aluctrl == 2)? data_s - data_t :      // when subtraction is asserted,
                    (aluctrl == 3)?             // when division is asserted,
                    (remainder != -1)? remainder : 32'b0      // when remainder != -1, it needs more calculation.
                    : 32'b0;      // Do nothing.
    
    always @(rstn) begin
        remainder <= 0;
        divresult <= 0;
    end
    
    always @(data_s or data_t) begin      // Doing division.
       if(aluctrl != 3) begin      // if alu is not division,
           remainder <= 0;
           divresult <= 0;
       end
       else begin         // if alu is division,
           if(data_s < data_t) begin      
              if(divresult == 0) begin
                 remainder <= -1;
                 divresult <= 0;
              end
              else begin
                 remainder <= -1;
                 divresult <= divresult;
              end
           end
           else if(data_s == data_t) begin
               if(divresult == 0) begin
                  remainder <= -1;
                  divresult <= 1;
               end
               else begin
                  remainder <= -1;
                  divresult <= divresult +1;
               end
           end
           else if(data_s < (data_t << 1) ) begin
               remainder <= data_s - data_t;
               divresult <= divresult + 1;
           end
           else if(data_s < (data_t << 2) ) begin
               remainder <= data_s - (data_t << 1);
               divresult <= divresult + 2;
           end
           else if(data_s < (data_t << 3) ) begin
               remainder <= data_s - (data_t << 2);
               divresult <= divresult + 4;
           end
           else if(data_s < (data_t << 4) ) begin
               remainder <= data_s - (data_t << 3);
               divresult <= divresult + 8;
           end
           else if(data_s < (data_t << 5) ) begin
               remainder <= data_s - (data_t << 4);
               divresult <= divresult + 16;
           end
           else if(data_s < (data_t << 6) ) begin
               remainder <= data_s - (data_t << 5);
               divresult <= divresult + 32;
           end
           else if(data_s < (data_t << 7) ) begin
               remainder <= data_s - (data_t << 6);
               divresult <= divresult + 64;
           end
           else if(data_s < (data_t << 8) ) begin
               remainder <= data_s - (data_t << 7);
               divresult <= divresult + 128;
           end
           else if(data_s < (data_t << 9) ) begin
               remainder <= data_s - (data_t << 8);
               divresult <= divresult + 256;
           end
           else if(data_s < (data_t << 10) ) begin
               remainder <= data_s - (data_t << 9);
               divresult <= divresult + 512;
           end
           else if(data_s < (data_t << 11) ) begin
               remainder <= data_s - (data_t << 10);
               divresult <= divresult + 1024;
           end
           else if(data_s < (data_t << 12) ) begin
               remainder <= data_s - (data_t << 11);
               divresult <= divresult + 2048;
           end
           else if(data_s < (data_t << 13) ) begin
               remainder <= data_s - (data_t << 12);
               divresult <= divresult + 4096;
           end
           else if(data_s < (data_t << 14) ) begin
               remainder <= data_s - (data_t << 13);
               divresult <= divresult + 8192;
           end
           else if(data_s < (data_t << 15) ) begin
               remainder <= data_s - (data_t << 14);
               divresult <= divresult + 16384;
           end
           else if(data_s < (data_t << 16) ) begin
               remainder <= data_s - (data_t << 15);
               divresult <= divresult + 32768;
           end
           else if(data_s < (data_t << 17) ) begin
               remainder <= data_s - (data_t << 16);
               divresult <= divresult + 65536;
           end
           else if(data_s < (data_t << 18) ) begin
               remainder <= data_s - (data_t << 17);
               divresult <= divresult + 131072;
           end
           else if(data_s < (data_t << 19) ) begin
               remainder <= data_s - (data_t << 18);
               divresult <= divresult + 262144;
           end
           else if(data_s < (data_t << 20) ) begin
               remainder <= data_s - (data_t << 19);
               divresult <= divresult + 524288;
           end
           else if(data_s < (data_t << 21) ) begin
               remainder <= data_s - (data_t << 20);
               divresult <= divresult + 1048576;
           end
           else if(data_s < (data_t << 22) ) begin
               remainder <= data_s - (data_t << 21);
               divresult <= divresult + 2097152;
           end
           else if(data_s < (data_t << 23) ) begin
               remainder <= data_s - (data_t << 22);
               divresult <= divresult + 4194304;
           end
           else if(data_s < (data_t << 24) ) begin
               remainder <= data_s - (data_t << 23);
               divresult <= divresult + 8388608;
           end
           else if(data_s < (data_t << 25) ) begin
               remainder <= data_s - (data_t << 24);
               divresult <= divresult + 16777216;
           end
           else if(data_s < (data_t << 26) ) begin
               remainder <= data_s - (data_t << 25);
               divresult <= divresult + 33554432;
           end
           else if(data_s < (data_t << 27) ) begin
               remainder <= data_s - (data_t << 26);
               divresult <= divresult + 67108864;
           end
           else if(data_s < (data_t << 28) ) begin
               remainder <= data_s - (data_t << 27);
               divresult <= divresult + 134217728;
           end
           else if(data_s < (data_t << 29) ) begin
               remainder <= data_s - (data_t << 28);
               divresult <= divresult + 268435356;
           end
           else if(data_s < (data_t << 30) ) begin
               remainder <= data_s - (data_t << 29);
               divresult <= divresult + 536870912;
           end
           else if(data_s < (data_t << 31) ) begin
               remainder <= data_s - (data_t << 30);
               divresult <= divresult + 1073741824;
           end
           else
               remainder <= remainder;
        end
    end   
               
endmodule
