//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: ram_simple_wseqs
// Project Name: RAM Verification in UVM
// Description: Simple write sequence extended from base sequence which creates, starts, randomizes and finishes item.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class ram_simple_wseqs extends ram_base_wseqs;

`uvm_object_utils(ram_simple_wseqs)

function new (string name = "ram_simple_wseqs");
		super.new(name);
endfunction

task body();
  repeat(no_of_trans) begin
		  `uvm_create(trans_h)
		  start_item(trans_h);
		  assert (trans_h.randomize());
		  
		  finish_item(trans_h);
  end
  endtask

endclass
