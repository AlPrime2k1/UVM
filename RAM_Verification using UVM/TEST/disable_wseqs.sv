//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: disable_wseqs
// Project Name: RAM Verification in UVM
// Description: Disable write sequence to make write enable zero when needed.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class disable_wseqs extends ram_base_wseqs;

`uvm_object_utils(disable_wseqs)

function new (string name = "normal_write_read_wseqs");
		super.new(name);
endfunction

task body();
  repeat(no_of_trans) begin
		  `uvm_create(trans_h)
		  start_item(trans_h);
		  assert (trans_h.randomize() with {wr_enb==0;});
		  
		  finish_item(trans_h);
  end
  endtask

endclass
