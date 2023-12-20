class APB_no_preset_seq extends APB_base_seq;

  `uvm_object_utils(APB_no_preset_seq)

  function new(string name = "APB_no_preset_seq");
	super.new(name);
  endfunction

  task body();
/*repeat(2)*/ `uvm_do_with(trans_h,{preset==0;})// dist{0:=50,1:=50};})// {b dist{0:=50,1:=50};}
//repeat(2) `uvm_do_with(trans_h,{pwrite==0;})
//repeat(2) `uvm_do(trans_h)  
  endtask

endclass

