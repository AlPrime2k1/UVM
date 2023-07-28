// Package file

`include "interface.sv"
package ral_pkg;

  import uvm_pkg::*;            // Importing everything from UVM Package
  `include "uvm_macros.svh"     // Including UVM macros
  
  `include "seq_item.sv"
  `include "write_seq_lib.sv"
  `include "read_seq_lib.sv"
  
  `include "sequencer.sv"
  `include "driver.sv"
  `include "monitor.sv"
  `include "agent.sv"
  
  `include "ctrl_register.sv"
  `include "io_register.sv"
  `include "mem_register.sv"
  `include "status_register.sv"
  
  `include "reg_model.sv"
  `include "adapter.sv"
  `include "env.sv"
  `include "reg_base_seq_lib.sv"
  `include "test.sv"

endpackage