class APB_base_seq extends uvm_sequence #(APB_trans); 

	`uvm_object_utils(APB_base_seq) 

	APB_trans trans_h;

	function new(string name="APB_base_seq"); 
    	super.new(name); 
  endfunction
endclass
