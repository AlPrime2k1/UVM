//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: disable_rseqs
// Project Name: RAM Verification in UVM
// Description: Disable read sequence to make read enable zero when needed.  
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class disable_rseqs extends ram_base_rseqs;

`uvm_object_utils(disable_rseqs)

function new (string name = "normal_write_read_rseqs");
		super.new(name);
endfunction

task body();
  repeat(no_of_trans) begin
		  `uvm_create(trans_h)
		  start_item(trans_h);
		  assert (trans_h.randomize() with {rd_enb==0;});
		  
		  finish_item(trans_h);
  end
  endtask

endclass
