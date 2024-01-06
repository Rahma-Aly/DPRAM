`ifndef W_MONITOR_SV
`define W_MONITOR_SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transactions.sv"

class w_monitor extends uvm_monitor;
	`uvm_component_utils(w_monitor)
	transactions mw_trans;
	virtual DPRAM_interface vif;
	uvm_analysis_port #(transactions) m_analysis_port;

	function  new( string name = "w_monitor", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db#(virtual DPRAM_interface)::get(this, "", "DPRAM_interface", vif)) begin
			`uvm_fatal("w_monitor","Couldn't obtain virtual interface")
		end
		m_analysis_port = new("m_analysis_port",this);
	endfunction


	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
			@(vif.cb);
			if (vif.rst_n) begin
				if (vif.write_en) begin
					mw_trans = transactions::type_id::create("m_trans");
					mw_trans.write_en = vif.write_en;
					mw_trans.WAdddr   = vif.WAdddr;
					mw_trans.dataIn   = vif.dataIn;

					m_analysis_port.write(mw_trans);
					`uvm_info("monitor", $sformatf("transaction: ",mw_trans.convert2string()),UVM_HIGH)
				end
			end
		end
	endtask : run_phase
endclass

`endif

