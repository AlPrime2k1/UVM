class no_psel_vseq extends Bridge_base_vseq;

`uvm_object_utils (no_psel_vseq)

APB_no_psel_seq  		apb_no_psel_seq_h;
APB_base_write_seq		apb_seq_h;
I2C_base_read_seq   	i2c_seq_h;			// all the sequences required for testcase

task body();

 repeat(10) `uvm_do_on(apb_seq_h,apb_seqr_h);						// APB write 10 times
 
 fork
    repeat(4) `uvm_do_on(apb_no_psel_seq_h,apb_seqr_h);	// APB psel inactive write 4 times
	  repeat(1) `uvm_do_on(i2c_seq_h,i2c_seqr_h);					// I2C read 1 time
 join_any

 repeat(15) `uvm_do_on(i2c_seq_h,i2c_seqr_h);						// I2C read 15 times

endtask

endclass
