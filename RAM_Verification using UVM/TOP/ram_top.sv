//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: ram_top
// Project Name: RAM Verification in UVM
// Description: Top file for ram verification consisting of interface, DUT and test.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module ram_top();

     import uvm_pkg::*;
     import ram_pkg::*;
     `include "uvm_macros.svh"

  bit clk;
  
  ram_if inf(clk);
  
  //dut instantiation
   ram DUT     (.clk(clk) ,
                .rst(inf.rst) ,
                .wr_enb(inf.wr_enb) ,
                .wr_addr(inf.wr_addr) , 
                .wr_data(inf.wr_data) ,
                .rd_enb(inf.rd_enb) , 
                .rd_addr(inf.rd_addr) ,
                .rd_data(inf.rd_data) 
               );

  
  always
   #5 clk = ~clk;
   
   initial 
   fork
     inf.init_reset();
     uvm_config_db #(virtual ram_if)::set(null,"*","vif",inf);   //uvm_root::get()
     run_test();
   join
endmodule
