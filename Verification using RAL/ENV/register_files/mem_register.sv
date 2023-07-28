// One of the registers in the design
// Details of arguments of configure method is provided in status_register file.

class mem_register extends uvm_reg;
  
  rand uvm_reg_field addr;
  
  `uvm_object_utils(mem_register);
  
  function new (string name = "mem_register");
    super.new(name, 32, UVM_NO_COVERAGE);        // 32 => Register Width
  endfunction
  
  function void build();    
   
    addr=uvm_reg_field::type_id::create("addr");
    addr.configure(this,32,0,"RW",0,0,1,1,0);
    
  endfunction
endclass