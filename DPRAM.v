module DPRAM #(parameter ADDR_WIDTH = 8, DATA_WIDTH = 8)(
	input                       clk,
	input                       rst_n,
	input                       read_en,
	input                       write_en,
	input      [ADDR_WIDTH-1:0] WAdddr,
	input      [ADDR_WIDTH-1:0] RAdddr,
	input      [DATA_WIDTH-1:0] dataIn,
	output reg [DATA_WIDTH-1:0] dataOut
	
);


reg [DATA_WIDTH-1:0] RAM [2**ADDR_WIDTH-1:0];
integer i;

always @(posedge clk or negedge rst_n) begin : WRITE_OP
    if (~rst_n) begin
        for (i = 0; i<2**ADDR_WIDTH ; i = i + 1) begin
            RAM[i] <= 'b0;
        end
    end
    else if (write_en) begin
            RAM[WAdddr] <= dataIn;
    end      
end

always @(posedge clk or negedge rst_n) begin : READ_OP
    if (~rst_n) begin
        dataOut <= 'b0;
    end
    else if (read_en) begin
            dataOut <= RAM[RAdddr];
    end      
end
	
endmodule : DPRAM
