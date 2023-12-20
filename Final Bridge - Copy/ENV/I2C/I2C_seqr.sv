class I2C_seqr extends uvm_sequencer #(I2C_trans); 

	`uvm_component_utils(I2C_seqr) 
	
	virtual Bridge_inf vif;

	function new(string name="I2C_seqr",uvm_component parent); 
    	super.new(name,parent); 
  endfunction

endclass
