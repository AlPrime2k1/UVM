class APB_base_write_seq extends APB_base_seq;

  `uvm_object_utils(APB_base_write_seq)

  function new(string name = "APB_base_write_seq");
	super.new(name);
  endfunction

  task body();
	`uvm_do(trans_h)
  endtask

endclass

