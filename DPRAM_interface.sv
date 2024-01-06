`ifndef DPRAM_INTERFACE_SV
`define DPRAM_INTERFACE_SV

`timescale 1ns/1ns

interface DPRAM_interface  #(parameter ADDR_WIDTH = 8, DATA_WIDTH = 8);
    bit                    clk;
    bit                    rst_n;
    bit                    read_en;
    bit                    write_en;
    logic [ADDR_WIDTH-1:0] WAdddr;
    logic [ADDR_WIDTH-1:0] RAdddr;
    logic [DATA_WIDTH-1:0] dataIn;
    logic [DATA_WIDTH-1:0] dataOut;
    
    
    default clocking cb @(posedge clk);
        default input #0ns output #10ns;
        output  rst_n;
        output  dataIn,read_en,write_en,WAdddr,RAdddr;
        input   dataOut;
    endclocking
    
endinterface : DPRAM_interface 


`endif
