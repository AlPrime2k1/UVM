class I2C_trans extends uvm_sequence_item; 

	bit sda,sda_out,addr_ack;
	bit [7:0] rec_data,header;			// Header to send 8 bits-> addr+ctrl	rec_data to receive data bitwise and store as reg to compare
	rand bit [6:0] addr;
	
	constraint for_addr{soft addr==7'd101;}			// Softly selected correct addr
	
	`uvm_object_utils_begin(I2C_trans) 
		`uvm_field_int(sda,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(sda_out,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(rec_data,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(header,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(addr,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(addr_ack,UVM_ALL_ON)
	`uvm_object_utils_end

	function new(string name="I2C_trans"); 
    	super.new(name); 
  endfunction

	function void concat();
	  header={addr,1'b1};		// Function to concantenate addr with the control bit 1 making it read op
	endfunction


endclass
