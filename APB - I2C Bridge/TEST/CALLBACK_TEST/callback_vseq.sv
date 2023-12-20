class callback_vseq extends Bridge_base_vseq;

`uvm_object_utils (callback_vseq)

APB_base_write_seq  	apb_seq_h;
I2C_callback_seq   		i2c_seq_h;			// all the sequences required for testcase

task body();

 repeat(10) `uvm_do_on(apb_seq_h,apb_seqr_h);		// APB write
 repeat(10) `uvm_do_on(i2c_seq_h,i2c_seqr_h);		// I2C read

 repeat(5) fork
 			`uvm_do_on(apb_seq_h,apb_seqr_h);
			`uvm_do_on(i2c_seq_h,i2c_seqr_h);
		  join
   
													// First writing 5 times through apb then reading through i2c
endtask

endclass
