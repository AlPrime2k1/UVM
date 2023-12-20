class simultaneous_vseq extends Bridge_base_vseq;

`uvm_object_utils (simultaneous_vseq)

APB_base_write_seq  	apb_seq_h;
I2C_base_read_seq   	i2c_seq_h;			// all the sequences required for testcase

task body();

repeat(19)
fork
  `uvm_do_on(apb_seq_h,apb_seqr_h);		// APB write
  `uvm_do_on(i2c_seq_h,i2c_seqr_h);		// I2C read
  										// Doing simultaneous apb write and i2c read operations
join

endtask

endclass
