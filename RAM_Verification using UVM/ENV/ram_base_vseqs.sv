//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: ram_base_vseqs
// Project Name: RAM Verification in UVM
// Description: Base virtual seqs responsible for casting so m_sequencer can be used in place of accessing seqr through virtual seqr
// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class ram_base_vseqs extends uvm_sequence #(uvm_sequence_item);

`uvm_object_utils (ram_base_vseqs)
	   
function new (string name = "ram_base_vseqs");
	super.new(name);
endfunction

ram_wseqr wseqr_h;			// Handles to both sequencers
ram_rseqr rseqr_h;

`uvm_declare_p_sequencer(ram_virtual_seqr)		// macro to replace line 23
//ram_virtual_seqr p_sequencer;					// Virtual sequencer handle

task pre_body();
	       // child    parent //
if(!$cast(p_sequencer,m_sequencer))
  `uvm_fatal(get_full_name(),"virtual sequencer cast failed")

wseqr_h=p_sequencer.wseqr_h;
rseqr_h=p_sequencer.rseqr_h;		// connecting seqr handle through virtual seqr

endtask

endclass
