class I2C_base_seq extends uvm_sequence #(I2C_trans); 

	`uvm_object_utils(I2C_base_seq) 

	I2C_trans trans_h;

	function new(string name="I2C_base_seq"); 
    	super.new(name); 
  endfunction

endclass
