// Register model consisting of all registers.

class reg_model extends uvm_reg_block;
  `uvm_object_utils(reg_model)
  
  // register instances  
  rand control_register control;
  rand status_register  status;
  rand io_register      io;
  rand mem_register     mem;

  bit temp;

  function new (string name = "");
    super.new(name, build_coverage(UVM_NO_COVERAGE));
  endfunction
 
 function void build();

    //reg creation
    control = control_register::type_id::create("control");
    control.build();                                            // Creating register, Building register fields and Configuring 
    control.configure(this);
    
    status = status_register::type_id::create("status");
    status.build();
    status.configure(this);
   
    io = io_register::type_id::create("io");
    io.build();
    io.configure(this);
    
    mem = mem_register::type_id::create("mem");
    mem.build();
    mem.configure(this);
    
    default_map = create_map("my_map", 0, 4, UVM_LITTLE_ENDIAN);    // name,base_addr,bus_width,endianness

    // Adding registers to map
    default_map.add_reg(status , 'h0, "RW");                        // reg, offset, access
    default_map.add_reg(control , 'h4, "RW");                       // Address of registers is base address + offset value         
    default_map.add_reg(io, 'h8, "RW");
    default_map.add_reg(mem, 'hc, "RW");

    add_hdl_path("ral_top","RTL");
    temp=has_hdl_path();
    $display(" HAS HDL PATH : %b",temp);
    lock_model();
  endfunction
endclass
    
    
  