`ifndef TRANSACTIONS_SV
`define TRANSACTIONS_SV

import uvm_pkg::*;
import definitions::*;
`include "uvm_macros.svh"

class transactions extends uvm_sequence_item;
	`uvm_object_utils(transactions)
    rand bit                    read_en;
    rand bit                    write_en;
    rand logic [ADDR_WIDTH-1:0] WAdddr;
    rand logic [ADDR_WIDTH-1:0] RAdddr;
    rand logic [DATA_WIDTH-1:0] dataIn;
    logic      [DATA_WIDTH-1:0] dataOut;

    function new (string name = "transactions");
    	super.new(name);
    endfunction 
    

    virtual function string convert2string();
		return $sformatf("read en: %0b, write en: %0b, WAdddr: 0x%0h, RAdddr: 0x%0h, dataIn: 0x%0h, dataOut: 0x%0h", read_en,write_en,WAdddr,RAdddr,dataIn,dataOut);
	endfunction

endclass : transactions

`endif
