`include "Bridge_inf.sv"

package Bridge_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	`include "APB_trans.sv"
	`include "I2C_trans.sv"

	`include "APB_base_seq.sv"
	`include "I2C_base_seq.sv"

	`include "APB_seqr.sv"
	`include"I2C_seqr.sv"

	`include "APB_driver.sv"
	`include "I2C_driver.sv"

	`include "I2C_monitor_callback.sv"
	`include "wrong_data_cb.sv"

	`include "APB_monitor.sv"
	`include "I2C_monitor.sv"

	`include "APB_agent.sv"
	`include "I2C_agent.sv"

	`include "Bridge_sb.sv"

	`include "Bridge_virtual_seqr.sv"
	`include "Bridge_base_vseq.sv"

	`include "Bridge_env.sv"

// BASE TEST
	`include "Bridge_base_test.sv"

	
// BASE SEQUENCES
	`include "APB_base_write_seq.sv"
	`include "APB_base_read_seq.sv"
	`include "I2C_base_read_seq.sv"
	`include "APB_no_psel_seq.sv"
	`include "APB_no_preset_seq.sv"
	`include "I2C_callback_seq.sv"

// TEST SEQUENCES
//	`include "APB_sanity_seq.sv"
//	`include "I2C_sanity_seq.sv"

	`include "sanity_vseq.sv"
	`include "back_to_back_vseq.sv"
	`include "simultaneous_vseq.sv"
	`include "no_psel_vseq.sv"
	`include "read_vseq.sv"
	`include "no_preset_vseq.sv"
	`include "write_read_vseq.sv"
	`include "callback_vseq.sv"
	


// TESTCASES
//	`include "Bridge_sanity_test.sv"
	`include "sanity_test.sv"			// write then read
	`include "back_to_back_test.sv"		// back to back write-read
	`include "simultaneous_test.sv"		// simultaneous apb write and i2c read
	`include "no_psel_test.sv"
	`include "read_test.sv"
	`include "no_preset_test.sv"
	`include "write_read_test.sv"
	`include "callback_test.sv"



endpackage
