
`timescale 1ns/1ns
import definitions::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "rw_test.sv"

module tb_top  #(parameter ADDR_WIDTH = 8, DATA_WIDTH = 8);

DPRAM_interface  #( 
	.ADDR_WIDTH(ADDR_WIDTH), 
	.DATA_WIDTH(DATA_WIDTH)
	) dpram_interface();

 DPRAM #( 
	.ADDR_WIDTH(ADDR_WIDTH), 
	.DATA_WIDTH(DATA_WIDTH)
	) DUT (
	.clk(dpram_interface.clk),
	.rst_n(dpram_interface.rst_n),
	.read_en(dpram_interface.read_en),
	.write_en(dpram_interface.write_en),
	.WAdddr(dpram_interface.WAdddr),
	.RAdddr(dpram_interface.RAdddr),
	.dataIn(dpram_interface.dataIn),
	.dataOut(dpram_interface.dataOut)
);

localparam CLK_PERIOD = 100;
always #(CLK_PERIOD/2) dpram_interface.clk = ~dpram_interface.clk;

initial begin
	dpram_interface.clk   <= 0;
	dpram_interface.rst_n <= 1;
	uvm_config_db#(virtual DPRAM_interface)::set(null, "uvm_test_top", "DPRAM_interface", dpram_interface);
	run_test("rw_test");
end

endmodule : tb_top