module Bridge_top();

import uvm_pkg::*;
`include "uvm_macros.svh"
import Bridge_pkg::*;

bit pclk,scl;

Bridge_inf inf(pclk,scl);

dsgn DUT (.scl(inf.scl),
  		  .sda(inf.sda),
		  .psel(inf.psel),
		  .penable(inf.penable),
		  .paddr(inf.paddr),
		  .pwrite(inf.pwrite),
		  .preset(inf.preset),
		  .pclk(inf.pclk),
		  .pwdata_in(inf.pwdata_in),
		  .prdata_out(inf.prdata_out),
		  .pready(inf.pready)
		 );
		 
bind dsgn Bridge_assertion AST(.scl(inf.scl)
                  ,.sda(inf.sda)
                  ,.psel(inf.psel)
                  ,.penable(inf.penable)
                  ,.paddr(inf.paddr)
                  ,.pwrite(inf.pwrite)
                  ,.preset(inf.preset)
                  ,.pclk(inf.pclk)
                  ,.pwdata_in(inf.pwdata_in)
                  ,.prdata_out(inf.prdata_out)
                  ,.pready(inf.pready)
									);


initial 
begin
  pclk=0;
  scl=0;

  forever fork
	#10 pclk=~pclk;
	#8 scl=~scl;
  join
end

initial 
  fork
	uvm_config_db #(virtual Bridge_inf)::set(null,"*","vif",inf);
	inf.initial_reset();
	//inf.intermediate_reset();
	run_test();
  join

endmodule
