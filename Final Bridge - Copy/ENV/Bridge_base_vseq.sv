class Bridge_base_vseq extends uvm_sequence #(uvm_sequence_item);

`uvm_object_utils (Bridge_base_vseq)
	   
function new (string name = "Bridge_base_vseq");
	super.new(name);
endfunction

APB_seqr apb_seqr_h;			// Handles to both sequencers
I2C_seqr i2c_seqr_h;

`uvm_declare_p_sequencer(Bridge_virtual_seqr)		// macro to replace line 13
//Bridge_virtual_seqr p_sequencer;							// Virtual sequencer handle

task pre_body();
	       // child    parent //
if(!$cast(p_sequencer,m_sequencer))
  `uvm_fatal(get_full_name(),"virtual sequencer cast failed")

apb_seqr_h=p_sequencer.apb_seqr_h;
i2c_seqr_h=p_sequencer.i2c_seqr_h;		// connecting sequencers handle through virtual seqr 

endtask

endclass
