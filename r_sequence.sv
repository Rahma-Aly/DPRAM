`ifndef R_SEQUENCE_SV
`define R_SEQUENCE_SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transactions.sv"
class r_sequence extends uvm_sequence;
	`uvm_object_utils(r_sequence)
	transactions m_trans;
	int n = 300;

	function  new( string name = "r_sequence");
		super.new(name);
	endfunction

	virtual task body();
		repeat(n) begin
			m_trans = transactions::type_id::create("m_trans");
			start_item(m_trans);
			m_trans.read_en = 1;
			// assert(m_trans.randomize() with{ m_trans.read_en == 1;});
			finish_item(m_trans);
		end
	endtask : body
endclass : r_sequence

`endif

