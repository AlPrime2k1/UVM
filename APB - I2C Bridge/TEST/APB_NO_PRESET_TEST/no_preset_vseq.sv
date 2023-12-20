class no_preset_vseq extends Bridge_base_vseq;

`uvm_object_utils (no_preset_vseq)

APB_no_preset_seq  		apb_no_rst_seq_h;
APB_base_write_seq		apb_seq_h;
I2C_base_read_seq   	i2c_seq_h;			// all the sequences required for testcase

task body();

 repeat(10) `uvm_do_on(apb_seq_h,apb_seqr_h);			// APB write 10 times
 
 fork
    `uvm_do_on(apb_no_rst_seq_h,apb_seqr_h);			// APB preset active
		repeat(5) `uvm_do_on(i2c_seq_h,i2c_seqr_h);		// I2C read 5 times
 join
 
 repeat(10) `uvm_do_on(apb_seq_h,apb_seqr_h)			// APB write 10 times

 repeat(8) `uvm_do_on(i2c_seq_h,i2c_seqr_h);			// I2C read 8 times
													
endtask

endclass
