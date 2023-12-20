class sanity_vseq extends Bridge_base_vseq;

`uvm_object_utils (sanity_vseq)

APB_base_write_seq  	apb_seq_h;
I2C_base_read_seq   	i2c_seq_h;			// all the sequences required for testcase

task body();

 repeat(16) `uvm_do_on(apb_seq_h,apb_seqr_h);		// APB write
 repeat(16) `uvm_do_on(i2c_seq_h,i2c_seqr_h);		// I2C read
													// First writing 5 times through apb then reading through i2c
endtask

endclass
