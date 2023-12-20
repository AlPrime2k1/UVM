class APB_seqr extends uvm_sequencer #(APB_trans); 
	`uvm_component_utils(APB_seqr) 

	virtual Bridge_inf vif;

	function new(string name="APB_seqr",uvm_component parent); 
    	super.new(name,parent); 
  endfunction

endclass
