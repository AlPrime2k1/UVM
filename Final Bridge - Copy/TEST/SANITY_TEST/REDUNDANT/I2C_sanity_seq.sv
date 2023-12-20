class I2C_sanity_seq extends I2C_base_seq;

`uvm_object_utils(I2C_sanity_seq)

I2C_base_read_seq rd_seq_h;

function new(string name = "I2C_sanity_sequence");
	super.new(name);
endfunction

task body();

	repeat(2) `uvm_do(rd_seq_h)
endtask

endclass
