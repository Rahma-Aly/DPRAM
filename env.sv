`ifndef ENV_SV
`define ENV_SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "r_agent.sv"
`include "w_agent.sv"
`include "scoreboard.sv"
`include "coverage.sv"

class env extends uvm_env;
	`uvm_component_utils(env)
	r_agent    mr_agent;
	w_agent    mw_agent;
	scoreboard m_scrbrd;
	coverage   m_cov;

	function new (string name = "env", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		mr_agent = r_agent::type_id::create("mr_agent",this);
		mw_agent = w_agent::type_id::create("mw_agent",this);
		m_scrbrd = scoreboard::type_id::create("m_scrbrd",this);
		m_cov    = coverage::type_id::create("m_cov",this);
	endfunction 

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		mr_agent.m_monitor.m_analysis_port.connect(m_scrbrd.r_exp);
		mr_agent.m_monitor.m_analysis_port.connect(m_cov.r_exp);

		mw_agent.m_monitor.m_analysis_port.connect(m_scrbrd.w_exp);
		mw_agent.m_monitor.m_analysis_port.connect(m_cov.w_exp);

	endfunction
endclass

`endif
