// One of the registers in the design
// Details of arguments of configure method is provided in status_register file.

class control_register extends uvm_reg;
  
  rand uvm_reg_field start_adapter;
  rand uvm_reg_field count;
  rand uvm_reg_field mem;
  rand uvm_reg_field reserved;
 
  
  `uvm_object_utils(control_register);
  
  function new (string name = "control_register");
    super.new(name, 32, UVM_NO_COVERAGE);        // 32 => Register Width
  endfunction
  
  function void build();    
   
    start_adapter=uvm_reg_field::type_id::create("start_adapter");
    start_adapter.configure(this,1,0,"RW",0,0,1,1,0);
    
    count=uvm_reg_field::type_id::create("count");
    count.configure(this,8,1,"RW",0,0,1,1,0);    

    mem=uvm_reg_field::type_id::create("mem");
    mem.configure(this,1,9,"RW",0,0,1,1,0);

    reserved=uvm_reg_field::type_id::create("reserved");
    reserved.configure(this,22,10,"RW",0,0,1,1,0);

  endfunction
endclass