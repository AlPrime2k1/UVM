// Write Sequence library

class write_sequence extends uvm_sequence#(seq_item);
  
  `uvm_object_utils(write_sequence)
   
  function new(string name = "write_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req,{req.kind==WRITE;})   // create -> start -> randomize -> finish constrained to Write
  endtask
endclass