// One of the registers in the design
// Here has_reset(0) is present while with all other registers it's 1.

class status_register extends uvm_reg;
  
  rand uvm_reg_field status;
  rand uvm_reg_field mask;
  
  `uvm_object_utils(status_register);
  
  function new (string name = "status_register");
    super.new(name, 32, UVM_NO_COVERAGE);        // 32 => Register Width
  endfunction
  
  function void build();
    status = uvm_reg_field::type_id::create("status");
    status.configure(.parent(this),     // Parent component
                     .size(16),         // Size of field in bits
                     .lsb_pos(0),       // LSB position
                     .access("RW"),     // Access controls
                     .volatile(0),      // Volatility
                     .reset(0),         
                     .has_reset(0),     // Check if it has a reset value. Here only this register doesn't have reset.
                     .is_rand(1),       // Checks if randomize is supported
                     .individually_accessible(0));    // Checks if field bits are individually accessibble
                     
    mask=uvm_reg_field::type_id::create("mask");
    mask.configure(this,16,16,"RW",0,0,0,1,0);
  endfunction
endclass