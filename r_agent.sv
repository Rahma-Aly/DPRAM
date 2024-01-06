`ifndef R_AGENT_SV
`define R_AGENT_SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transactions.sv"
`include "r_monitor.sv"
`include "driver.sv"

class r_agent extends  uvm_agent;
	`uvm_component_utils(r_agent)
	uvm_sequencer #(transactions) m_sequencer;
	driver		 m_driver;
	r_monitor    m_monitor;

	function new( string name = "r_agent",uvm_component parent = null);
		super.new(name,parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		m_driver    = driver::type_id::create("m_driver",this);
		m_monitor   = r_monitor::type_id::create("m_monitor",this);
		m_sequencer = uvm_sequencer#(transactions) ::type_id::create("m_sequencer",this);
	endfunction 

	virtual function void connect_phase( uvm_phase phase);
		super.connect_phase(phase);
		m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
	endfunction
	
endclass : r_agent


`endif
