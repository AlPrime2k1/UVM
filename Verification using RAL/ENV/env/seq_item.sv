// Transaction item class

typedef enum bit {READ, WRITE} trans_kind_e;      // Enum to choose operation
class seq_item extends uvm_sequence_item;

  rand bit [31:0] addr;
  rand trans_kind_e kind;
  rand bit [31:0] wdata;
       bit [31:0] rdata;
              
  `uvm_object_utils_begin(seq_item)    
    `uvm_field_enum(trans_kind_e,kind,UVM_ALL_ON)
    `uvm_field_int(addr,UVM_ALL_ON)
    `uvm_field_int(wdata,UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name = "seq_item");
    super.new(name);
  endfunction
  
endclass