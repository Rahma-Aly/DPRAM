`ifndef V_SEQ_SV
`define V_SEQ_SV 

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transactions.sv"
`include "r_sequence.sv"
`include "w_sequence.sv"

class v_seq extends uvm_sequence #(transactions);
	`uvm_object_utils(v_seq)

	// handles for target sequencers (2 sequencers , 1 for each agent) (these handles are assigned values in test)
	uvm_sequencer #(transactions) r_seqr;
	uvm_sequencer #(transactions) w_seqr;

	function  new(string name = "v_seq");
		super.new(name);
	endfunction

	virtual task body();
		//create sequences 
		r_sequence r_seq = r_sequence::type_id::create("r_seq");
		w_sequence w_seq = w_sequence::type_id::create("w_seq");

		//start sequence on sequencer
		fork
			r_seq.start(r_seqr);
			w_seq.start(w_seqr);
		join

    endtask : body
endclass


`endif
