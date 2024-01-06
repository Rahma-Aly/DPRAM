`ifndef RW_TEST_SV
`define RW_TEST_SV 

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "base_test.sv"
`include "v_seq.sv"

class rw_test extends  base_test;
	`uvm_component_utils(rw_test)

	function new(string name = "rw_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		v_seq m_vseq = v_seq::type_id::create("m_vseq");

		phase.raise_objection(this);
		init_v_seq(m_vseq);
		apply_rst();
		m_vseq.start(null);
		// #10 
		phase.drop_objection(this);

	endtask : run_phase

	virtual task  apply_rst();
		vif.rst_n 	 <= 1'b1;
		vif.RAdddr   <= 0;
		vif.WAdddr   <= 0;
		vif.read_en  <= 0;
		vif.write_en <= 0;
		vif.dataIn   <= 0;
		@(negedge vif.clk)
		vif.rst_n <= 1'b0;
		@(negedge vif.clk)
		vif.rst_n <= 1'b1;
	endtask 
endclass : rw_test

`endif
