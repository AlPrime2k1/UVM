//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: ram_wseqr
// Project Name: RAM Verification in UVM
// Description: Write sequencer to pass write sequence values. 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class ram_wseqr extends uvm_sequencer #(ram_wtrans);

  `uvm_component_utils(ram_wseqr)
   
   function new (string name = "ram_wseqr", uvm_component parent=null);
	  super.new(name,parent);
   endfunction
   
endclass
