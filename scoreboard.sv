`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV 

import uvm_pkg::*;
import definitions::*;

`include "uvm_macros.svh"
`include "transactions.sv"

// `uvm_analysis_imp_decl(_r)
// `uvm_analysis_imp_decl(_w)

class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)
	uvm_analysis_imp_r #(transactions,scoreboard) r_exp;
	uvm_analysis_imp_w #(transactions,scoreboard) w_exp;
	bit [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH-1:0];

	function  new( string name = "scoreboard", uvm_component parent = null);
		super.new(name,parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		r_exp = new("r_exp",this);
		w_exp = new("w_exp",this);
	endfunction

	virtual function void write_r (transactions t);

		if (t.dataOut == mem[t.RAdddr]) begin
			`uvm_info("scoreboard",$sformatf("test passed(Addr %0h): Read data (%0h) == expected data (%0h)",t.RAdddr,t.dataOut, mem[t.RAdddr]),UVM_NONE)
		end
		else begin
			`uvm_error("scoreboard",$sformatf("test failed(Addr %0h): Read data (%0h) != expected data (%0h)",t.RAdddr,t.dataOut, mem[t.RAdddr]))
		end
	endfunction

	virtual function void write_w (transactions t);
		mem[t.WAdddr] = t.dataIn;
	endfunction
endclass : scoreboard

`endif


/*/*------------------------------------------------------------------------------
--  since the scoreboard is connected to 2 monitors and we only have 1 write function:
-- 1. use macro "`uvm_analysis_imp_decl()" -> create 2 write functions
-- 2. use uvm_tlm_analysis_fifo -> connect each fifo to its uvm_analysis_export (need to read more about this)
------------------------------------------------------------------------------*/