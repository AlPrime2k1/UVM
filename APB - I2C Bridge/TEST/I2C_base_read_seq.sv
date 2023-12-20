class I2C_base_read_seq extends I2C_base_seq;

  `uvm_object_utils(I2C_base_read_seq)

  function new(string name = "I2C_base_read_seq");
	super.new(name);
  endfunction

  task body();
	`uvm_do(trans_h)
  endtask

endclass