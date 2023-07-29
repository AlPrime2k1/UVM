//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: ram_vseqr
// Project Name: RAM Verification in UVM
// Description: Virual sequencer which contains handle of both sequencers to connect it to m_sequencer via vseqs.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ram_virtual_seqr extends uvm_sequencer #(uvm_sequence_item);

  `uvm_component_utils(ram_virtual_seqr)
   
   function new (string name = "ram_virtual_seqr", uvm_component parent=null);
	  super.new(name,parent);
   endfunction

   ram_wseqr wseqr_h;			// Handles of all sequencers
   ram_rseqr rseqr_h;
   
endclass
