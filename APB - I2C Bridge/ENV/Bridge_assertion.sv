`define SCL_PERIOD 20000000
`define PCLK_PERIOD 250000


module Bridge_assertion(
       input scl ,
       input pclk,
       input sda , 
       input psel,
       input penable ,
       input paddr ,
       input pwrite,
       input preset,
       input pwdata_in,
       input prdata_out ,
       input pready
       );

 import uvm_pkg::*;
`include "uvm_macros.svh"

//////////////////////////////////////////////////////////////////////////////////

	property valid_penable;
		@(posedge pclk)
		$rose(psel) ##1 $rose(penable) |-> ##[0:$]pready ##1 !penable;			// Penable check
	endproperty

	property preset_assertion;
		@(posedge pclk)
		$fell(preset) || !preset |-> (prdata_out==0);				// Reset active
	endproperty
	
	property valid_sda;
		@(posedge scl)																			// Checking if sda is always known
	  !$isunknown(sda);
	endproperty

	property valid_psel;
		@(posedge pclk)
		disable iff(!preset)																// After first cycle,checking if PSEL is always valid
		##1 !$isunknown(psel);
	endproperty

	property valid_pready;
		@(posedge pclk)
		disable iff(!preset)														// Checking pready is valid after preset
	  !$isunknown(pready);
	endproperty

	property valid_paddr;
		@(posedge pclk)
		disable iff(!preset)
		##1 !$isunknown(paddr);
	endproperty

///////////////////////////////////////////////////////////////////////////////////////////
	penable_chk : assert property (valid_penable)
									`uvm_info("ASR ENB PASS","PENABLE DEASSERTION CHECK PASSED",UVM_LOW)
								else `uvm_error("ASR ENB FAIL","PENABLE DEASSERTION CHECK FAILED")
									
	preset_chk : assert property (preset_assertion)
									`uvm_info("ASR RST PASS","PRESET ASSERTION CHECK PASSED",UVM_LOW)
								else `uvm_error("ASR RST FAIL","PRESET ASSERTION CHECK FAILED")

	valid_psel_chk : assert property (valid_psel)
									`uvm_info("ASR VAL_PSEL PASS","VALID PSEL CHECK PASSED",UVM_LOW)
								else `uvm_error("ASR VAL_PSEL FAIL","VALID PSEL CHECK FAILED")

	valid_sda_chk : assert property (valid_sda)
									`uvm_info("ASR VAL_SDA PASS","VALID SDA CHECK PASSED",UVM_LOW)
								else `uvm_error("ASR VAL_SDA FAIL","VALID SDA CHECK FAILED")

	valid_paddr_chk : assert property (valid_paddr)
									`uvm_info("ASR VAL_ADDR PASS","VALID PADDR CHECK PASSED",UVM_LOW)
								else `uvm_error("ASR VAL_ADDR FAIL","VALID PADDR CHECK FAILED")

	valid_pready_chk : assert property (valid_pready)
									`uvm_info("ASR VAL_RDY PASS","VALID PREADY CHECK PASSED",UVM_LOW)
								else `uvm_error("ASR VAL_RDY FAIL","VALID PREADY CHECK FAILED")
///////////////////////////////////////////////////////////////////////////////////////////
endmodule 
