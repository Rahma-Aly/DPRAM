`ifndef COVERAGE_SV
`define COVERAGE_SV 

import uvm_pkg::*;
import definitions::*;

`include "uvm_macros.svh"
`include "transactions.sv"

// `uvm_analysis_imp_decl(_r)
// `uvm_analysis_imp_decl(_w)

class coverage extends uvm_component;
	`uvm_component_utils(coverage)
	uvm_analysis_imp_r #(transactions,coverage) r_exp;
	uvm_analysis_imp_w #(transactions,coverage) w_exp;
	transactions m_trans;

	covergroup addr_range();
		Raddr : coverpoint m_trans.RAdddr {
			bins zero = {0};
			bins mid_range = {[1:2**ADDR_WIDTH-2]};
			bins High_range = {2**ADDR_WIDTH-1};
		}

		Waddr : coverpoint m_trans.WAdddr {
			bins zero = {0};
			bins mid_range = {[1:2**ADDR_WIDTH-2]};
			bins High_range = {2**ADDR_WIDTH-1};
		}
		RW_addr : cross Raddr,Waddr;
	endgroup : addr_range

	covergroup Data_range();
		datain : coverpoint m_trans.dataIn { 
			bins all_1   = {{DATA_WIDTH{1'b1}}};
			bins all_0   = {'b0};
			bins other   = {['b1:{DATA_WIDTH{1'b1}}-1]}; 
		}
	endgroup : Data_range

	function new (string name = "coverage",uvm_component parent = null);
		super.new(name,parent);
		addr_range = new();
		Data_range = new();
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		m_trans = transactions::type_id::create("m_trans");
		r_exp = new("r_exp",this);
		w_exp = new("w_exp",this);
	endfunction 

	virtual function void write_r(transactions t);
		m_trans = t;
		addr_range.sample();
		Data_range.sample();
		// `uvm_info("coverage",$sformatf("addr coverage : %0d",addr_range.get_coverage()),UVM_NONE)
		// `uvm_info("coverage",$sformatf("data coverage : %0d",Data_range.get_coverage()),UVM_NONE)
	endfunction 

	virtual function void write_w(transactions t);
		m_trans = t;
		addr_range.sample();
		Data_range.sample();
		// `uvm_info("coverage",$sformatf("addr coverage : %0d",addr_range.get_coverage()),UVM_NONE)
		// `uvm_info("coverage",$sformatf("data coverage : %0d",Data_range.get_coverage()),UVM_NONE)
	endfunction 
endclass
`endif
