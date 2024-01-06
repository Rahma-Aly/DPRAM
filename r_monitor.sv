`ifndef R_MONITOR_SV
`define R_MONITOR_SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transactions.sv"

class r_monitor extends uvm_monitor;
	`uvm_component_utils(r_monitor)
	transactions mr_trans;
	virtual DPRAM_interface vif;
	uvm_analysis_port #(transactions) m_analysis_port;

	function  new( string name = "r_monitor", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db#(virtual DPRAM_interface)::get(this, "", "DPRAM_interface", vif)) begin
			`uvm_fatal("r_monitor","Couldn't obtain virtual interface")
		end
		m_analysis_port = new("m_analysis_port",this);
	endfunction


	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
			@(vif.cb);
			if (vif.rst_n) begin
				if (vif.read_en) begin
					mr_trans = transactions::type_id::create("m_trans");
					mr_trans.read_en  = vif.read_en;
					mr_trans.RAdddr   = vif.RAdddr;
					mr_trans.dataOut  = vif.cb.dataOut;

					m_analysis_port.write(mr_trans);
					`uvm_info("monitor", $sformatf("transaction: ",mr_trans.convert2string()),UVM_HIGH)
				end
			end
		end
	endtask : run_phase
endclass

`endif

