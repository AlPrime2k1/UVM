//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: ram_simple_rseqs
// Project Name: RAM Verification in UVM
// Description: Simple read sequence extended from base sequence which creates, starts, randomizes and finishes item.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ram_simple_rseqs extends ram_base_rseqs;

`uvm_object_utils(ram_simple_rseqs)

function new (string name = "ram_simple_rseqs");
		super.new(name);
endfunction

task body();
  repeat(no_of_trans) begin
		  /*
		  `uvm_create(trans_h)
		  start_item(trans_h);
		  assert(trans_h.randomize());
		  finish_item(trans_h); */
		 `uvm_do(trans_h);
  end
  endtask

endclass
