//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: ram_rtrans
// Project Name: RAM Verification in UVM
// Description: Read transaction class with field macros. 
// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ram_rtrans extends uvm_sequence_item;

//read_signals
   rand bit rd_enb;
   randc bit [3:0] rd_addr;
   bit [7:0] rd_data;
   

   constraint ENB {soft rd_enb==1'b1;}
   
   `uvm_object_utils_begin(ram_rtrans)
	 `uvm_field_int(rd_enb, UVM_ALL_ON | UVM_DEC)
	 `uvm_field_int(rd_addr, UVM_ALL_ON | UVM_DEC)
	 `uvm_field_int(rd_data, UVM_ALL_ON | UVM_DEC)
	`uvm_object_utils_end
	
	function new (string name = "ram_rtrans");
	  super.new(name);
	endfunction

endclass
