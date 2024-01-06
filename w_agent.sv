`ifndef W_AGENT_SV
`define W_AGENT_SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transactions.sv"
`include "w_monitor.sv"
`include "driver.sv"

class w_agent extends  uvm_agent;
	`uvm_component_utils(w_agent)
	uvm_sequencer #(transactions) m_sequencer;
	driver		 m_driver;
	w_monitor    m_monitor;

	function new( string name = "w_agent",uvm_component parent = null);
		super.new(name,parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		m_driver    = driver::type_id::create("m_driver",this);
		m_monitor   = w_monitor::type_id::create("m_monitor",this);
		m_sequencer = uvm_sequencer#(transactions) ::type_id::create("m_sequencer",this);
	endfunction 

	virtual function void connect_phase( uvm_phase phase);
		super.connect_phase(phase);
		m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
	endfunction
	
endclass : w_agent


`endif
