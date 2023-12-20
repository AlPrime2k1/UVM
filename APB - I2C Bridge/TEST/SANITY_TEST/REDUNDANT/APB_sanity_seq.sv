class APB_sanity_seq extends APB_base_seq;

`uvm_object_utils(APB_sanity_seq)

APB_base_write_seq wr_seq_h;

function new(string name = "APB_sanity_sequence");
	super.new(name);
endfunction

task body();
	repeat(2) `uvm_do(wr_seq_h)
endtask

endclass
