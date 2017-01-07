module SimpleMIPS(clk, rstn, im_write, im_addr, im_wdata);
    input clk, rstn, im_write;
    input [31:0] im_addr;
    input [31:0] im_wdata;
    
    wire zero;
    reg [31:0] pc;
    wire [31:0] adder_wire_2;
    wire [31:0] instmem_wire_3;
    wire [31:0] adder_wire_4;
    wire [9:0] control_wire_5;
    wire [31:0] mux_wire_6;
    wire [31:0] mux_wire_7;
    wire [31:0] register_wire_8;
    wire [31:0] register_wire_9;
    wire [31:0] mux_wire_10;
    wire [31:0] alu_wire_11;
    wire [31:0] datamem_wire_12;
    
    // PC part.
    adder adder_0(.data_1(pc), .data_2(32'd1), .result(adder_wire_2) );
    adder adder_1(.data_1(adder_wire_2), .data_2({14'b0, instmem_wire_3[15:0], 2'b00}), .result(adder_wire_4) );
    mux mux_pc_0(.muxctrl(control_wire_5[0]), .data_1(adder_wire_2), .data_2(adder_wire_4), .result(mux_wire_6) );
    
    // Instruction memory.
    instmem instmem_0(.clk(clk), .addr(pc), .im_write(im_write), .im_addr(im_addr), .im_wdata(im_wdata), .inst(instmem_wire_3) );
    control control_0(.clk(clk), .instdata(instmem_wire_3), .sigctrl(control_wire_5));
    
    // Register.
    register register_0(.clk(clk), .alusrc(control_wire_5[2]), .regwrite(control_wire_5[1]), .instdata(instmem_wire_3), .wdata(mux_wire_7), .data_s(register_wire_8), .data_t(register_wire_9));
    mux mux_register_0(.muxctrl(control_wire_5[2]), .data_1(register_wire_9), .data_2({16'b0, instmem_wire_3[15:0]}), .result(mux_wire_10));
    
    // ALU.
    alu alu_0(.rstn(rstn), .clk(clk), .aluctrl(control_wire_5[6:3]), .data_s(register_wire_8), .data_t(mux_wire_10), .zero(zero), .result(alu_wire_11));
    
    // Data memory.
    datamem datamem_0(.clk(clk), .memwrite(control_wire_5[7]), .memread(control_wire_5[8]), .wdata(register_wire_9), .addr(alu_wire_11), .rdata(datamem_wire_12));
    mux mux_datamem_0(.muxctrl(control_wire_5[9]), .data_1(datamem_wire_12), .data_2(alu_wire_11), .result(mux_wire_7));
        
    always @(rstn or posedge clk) begin
        if(rstn)
           pc <= 0;
        else
           pc <= mux_wire_6;
    end
    
endmodule
