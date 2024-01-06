`ifndef DEFINITIONS_SV
`define DEFINITIONS_SV

package definitions;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	`uvm_analysis_imp_decl(_r)
	`uvm_analysis_imp_decl(_w)

	parameter ADDR_WIDTH = 8;
	parameter DATA_WIDTH = 8;

endpackage : definitions
`endif

