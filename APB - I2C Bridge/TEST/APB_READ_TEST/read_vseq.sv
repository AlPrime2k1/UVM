class read_vseq extends Bridge_base_vseq;

`uvm_object_utils (read_vseq)

APB_base_write_seq		apb_seq_w_h;
APB_base_read_seq		apb_seq_r_h;
I2C_base_read_seq   	i2c_seq_h;			// all the sequences required for testcase

task body();

 fork
 	repeat(10) `uvm_do_on(apb_seq_r_h,apb_seqr_h);	// APB Read 10 times
 
 	repeat(10) `uvm_do_on(i2c_seq_h,i2c_seqr_h);		// I2C Read 10 times
 join
 
 repeat(2) `uvm_do_on(apb_seq_w_h,apb_seqr_h)			// APB write 4 times

 repeat(6) `uvm_do_on(i2c_seq_h,i2c_seqr_h);		// I2C read 6 times
													
endtask

endclass
