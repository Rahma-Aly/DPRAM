`ifndef DRIVER_SV
`define DRIVER_SV 

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transactions.sv"

class driver extends uvm_driver #(transactions);
	`uvm_component_utils(driver)
	transactions m_trans;
	virtual DPRAM_interface vif;

	function new(string name = "driver", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db#(virtual DPRAM_interface)::get(this, "", "DPRAM_interface", vif)) begin
			`uvm_fatal("driver","Couldn't find virtual interface")
		end
	endfunction

	virtual task run_phase( uvm_phase phase);
		super.run_phase(phase);
		forever begin
			seq_item_port.get_next_item(m_trans);
			@(vif.cb)
			vif.cb.read_en  <= m_trans.read_en;
			vif.cb.write_en <= m_trans.write_en;
			if (vif.write_en  && (this.get_full_name() == "uvm_test_top.m_env.mw_agent.m_driver")) begin //?
				// `uvm_info("driver",$sformatf("inside write condition , driver name: %0s",this.get_full_name()),UVM_NONE)
				vif.cb.WAdddr   <= m_trans.WAdddr;
				vif.cb.dataIn   <= m_trans.dataIn;
			end
			if (vif.read_en&& (this.get_full_name() == "uvm_test_top.m_env.mr_agent.m_driver")) begin
				vif.cb.RAdddr   <= m_trans.RAdddr;
			end
			seq_item_port.item_done();

		end
	endtask : run_phase

endclass


`endif
