class APB_base_read_seq extends APB_base_seq;

  `uvm_object_utils(APB_base_read_seq)

  function new(string name = "APB_base_read_seq");
	super.new(name);
  endfunction

  task body();
	`uvm_do_with(trans_h,{pwrite==0;})
  endtask

endclass

