class Bridge_virtual_seqr extends uvm_sequencer #(uvm_sequence_item);

  `uvm_component_utils(Bridge_virtual_seqr)
   
   function new (string name = "Bridge_virtual_seqr", uvm_component parent=null);
	   super.new(name,parent);
   endfunction

   APB_seqr apb_seqr_h;			// Handles of all sequencers
   I2C_seqr i2c_seqr_h;
   
endclass
