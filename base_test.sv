`ifndef BASE_TEST_SV
`define BASE_TEST_SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "env.sv"
`include "v_seq.sv"

class base_test extends  uvm_test;
	`uvm_component_utils(base_test)
	env m_env;
	virtual DPRAM_interface vif;

	function new(string name = "base_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction 

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db#(virtual DPRAM_interface)::get(this, "", "DPRAM_interface",vif )) begin
			`uvm_fatal("base_test","Couldn't find virtual interface")
		end
		uvm_config_db#(virtual DPRAM_interface)::set(this, "m_env.*", "DPRAM_interface",vif);

		m_env = env::type_id::create("m_env",this);
	endfunction

	function void init_v_seq(v_seq vseq);
		vseq.r_seqr = m_env.mr_agent.m_sequencer;
		vseq.w_seqr = m_env.mw_agent.m_sequencer;
	endfunction 

endclass : base_test
`endif
