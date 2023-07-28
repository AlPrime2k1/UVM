// Top module consisting of DUT, Interface and Test

module top;
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import ral_pkg::*;

  bit clk;
  bit reset;
  
  //clock generation
  always #5 clk = ~clk;
  
  initial begin
    reset = 1;
    #5 reset =0;
  end
  
  ral_if intf(clk,reset);

  //DUT instance

  ral_register DUT (
    .clk(intf.clk),
    .reset(intf.reset),
    .addr(intf.addr),
    .wr_en(intf.wr_en),
    .wdata(intf.wdata),
    .rdata(intf.rdata)
   );

  initial begin 
    uvm_config_db#(virtual ral_if)::set(uvm_root::get(),"*","vif",intf);    // uvm_root::get() used to get name of parent of top
  end                                                                       // Setting virtual interface 

  initial 
  fork 
    run_test("ral_model_base_test");
  join//end
  
endmodule