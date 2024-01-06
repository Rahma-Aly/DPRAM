`ifndef W_SEQUENCE_SV
`define W_SEQUENCE_SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transactions.sv"
class w_sequence extends uvm_sequence;
	`uvm_object_utils(w_sequence)
	transactions m_trans;
	int n = 300;

	function  new( string name = "w_sequence");
		super.new(name);
	endfunction

	virtual task body();
		repeat(n) begin
			m_trans = transactions::type_id::create("m_trans");
			start_item(m_trans);
			assert(m_trans.randomize() with{ m_trans.write_en == 1 ; });
			finish_item(m_trans);
		end
	endtask : body
endclass : w_sequence

`endif
