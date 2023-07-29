//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: ram_pkg
// Project Name: RAM Verification in UVM
// Description: Package consisting of interface, UVM macros, UVM package and all test files.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`include "ram_if.sv"

package ram_pkg;
   import uvm_pkg::*;

  `include "uvm_macros.svh"

  `include "ram_wtrans.sv"
  `include "ram_rtrans.sv"
  
  `include "ram_base_wseqs.sv"
  `include "ram_base_rseqs.sv"
  `include "ram_wseqr.sv"
  `include "ram_rseqr.sv"
  `include "ram_wdr.sv"
  `include "ram_rdr.sv"
  `include "ram_wmon.sv"
  `include "ram_rmon.sv"
  `include "ram_wagent.sv"
  `include "ram_ragent.sv"
  `include "ram_sb.sv"

  `include "ram_virtual_seqr.sv"
  `include "ram_base_vseqs.sv"
  `include "ram_env.sv"
  `include "ram_base_test.sv"

  `include "ram_simple_wseqs.sv"
  `include "disable_wseqs.sv"
  `include "disable_rseqs.sv"
  `include "ram_simple_rseqs.sv"


 // TESTCASES 


  `include "sim_write_read_vseqs.sv"
  `include "sim_write_read_test.sv"

  `include "normal_write_read_vseqs.sv"
  `include "normal_write_read_test.sv"
  
  `include "back_to_back_vseqs.sv"
  `include "back_to_back_test.sv"

  
endpackage
