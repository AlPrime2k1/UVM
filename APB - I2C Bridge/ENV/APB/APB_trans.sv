class APB_trans extends uvm_sequence_item; 

  rand bit psel,penable,pwrite,preset;
	rand bit [7:0] paddr,pwdata_in;
	bit [7:0] prdata_out,pwdata_out;
	bit pready;

	constraint for_psel{soft psel==1;}
	constraint for_penable{soft penable==1;}
	constraint for_preset{soft preset==1;}		// Softly set to low
	constraint for_paddr{soft paddr==255;}
	constraint for_pwrite{soft pwrite==1;}		// Softly set to write

	`uvm_object_utils_begin(APB_trans) 
		`uvm_field_int(psel,UVM_ALL_ON)
		`uvm_field_int(penable,UVM_ALL_ON)
		`uvm_field_int(pwrite,UVM_ALL_ON)
		`uvm_field_int(preset,UVM_ALL_ON)
		`uvm_field_int(paddr,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(pwdata_in,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(prdata_out,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(pwdata_out,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(pready,UVM_ALL_ON)
	`uvm_object_utils_end

	function new(string name="APB_trans"); 
    	super.new(name); 
  endfunction

endclass
