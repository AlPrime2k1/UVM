// Read Sequence library

class read_sequence extends uvm_sequence#(seq_item);
  
  `uvm_object_utils(read_sequence)
   
  function new(string name = "read_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req,{req.kind==READ;})     //// create -> start -> randomize -> finish constrained to Read
  endtask
endclass