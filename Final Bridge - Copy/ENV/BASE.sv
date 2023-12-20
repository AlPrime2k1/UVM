`define SCL_PERIOD 20000000
`define PCLK_PERIOD 250000


module apb_i2c_assertion(
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
/*
//assertion for apb clock frequency
  property apb_clk_freq_prt;
    realtime apb_t_on;
    (1 , apb_t_on= $realtime) |=> ($realtime-apb_t_on == `PCLK_PERIOD) ;
  endproperty

//assertion for i2c clock frequency
  property i2c_clk_prt ;
    realtime i2c_t_on ;
    (1, i2c_t_on = $realtime) |=>  ($realtime - i2c_t_on == `SCL_PERIOD);
  endproperty
*/


	//assertion for penable deassertion after ready is asserted
  property apb_penable;
    $rose(penable) |-> ##[0:$]pready ##1 !penable;
  endproperty
 
//assertion for data valid during penable high and retains its value 
  property apb_pwdata_in;
  ( $rose (pwrite) && psel |=>  penable ##0 
      ($stable (pwdata_in)) s_until pready ##1 !penable); 
 endproperty
  
  property apb_pwdata_in_stable;
   ($rose (pwrite) && psel |=> ($stable (pwdata_in)) s_until pready);
  endproperty 

//assertion for address valid during penable high and retains its value 
  property apb_paddr_in;
  ( $rose (pwrite) && psel |=>  penable ##0 
      ($stable(paddr)) s_until pready ##1 !penable); 
 endproperty
/*
 property WriteAck2;
   @(posedge clk) disable iff (rst)
   (wr && (!wr_ack)) |-> ##1 wr;
 endproperty
*/
 
/* property apb_pwdata_in_stable;
       ($rose (penable) |-> 
       $stable ((paddr) && $stable (pwdata_in)) until_with pready ##0
       !pwrite && !psel && !penable); 
 endproperty
/
 property apb_pwdata_in_stable;
  penable |-> $past((psel == 1) && (pwrite ==1) && $stable(pwrite) && $stable(paddr),1);
 endproperty
*/
/*
 property data_addr_stable_befor_ready;
  $rose(pready) |-> $past($stable(pwdata_in)&& $stable(paddr),1);
 endproperty

//assertion for psel high when pwrite is high
 property apb_write_sel_check;
   pwrite |=> (psel== pwrite);
endproperty



//property to check psel is not X/Z
property psel_not_unknown;
      disable iff(!preset)
     ##1 !$isunknown(psel) ;
endproperty
      
//property to check penable is not X/Z
property penable_not_unknown;
      disable iff(!preset)
      ##2 !$isunknown(penable) ;
endproperty

//property to check paddr is not X/Z
property paddr_not_unknown;
      disable iff(!preset)
      ##1 !$isunknown(paddr) ;
endproperty

//property to check pwdatain is not X/Z
property pwdatain_not_unknown;
      disable iff(!preset)
      ##1 !$isunknown(pwdata_in) ;
endproperty

//property to check pwrite is not X/Z
property pwrite_not_unknown;
      disable iff(!preset)
      ##1 !$isunknown(pwrite) ;
endproperty

//property to check psel is stable during transfer
property psel_stable_in_transfer ;
 disable iff(!preset)
 !psel && $past(psel) |-> $past(penable) && $past(pready) ; 
endproperty

property psel_low_then_pwrite_low;
 disable iff(!preset)
 @(posedge pclk)!psel |-> !pwrite;
endproperty
 
property pwrite_highthen_pwrite_high;
 disable iff(!preset)
 @(posedge pclk)pwrite |-> psel;
endproperty

/*
property i2c_start_cond;
 @(negedge sda) scl == 1;
endproperty
 
sequence i2c_start;
 @(negedge sda) scl == 1;
endsequence

 property i2c_start_cond_address_stable;
  disable iff(!preset)
   //i2c_start |=> (sda == 1) ##1 (sda == 1) ##1 (sda == 0) ##1 (sda == 0) ##1 (sda == 1) ##1 (sda == 0) ##1 (sda == 1);
  first_match( $fell(sda) && scl==1) |=> (sda == 1) ##1 (sda == 1) ##1 (sda == 0) ##1 (sda == 0) ##1 (sda == 1) ##1 (sda == 0) ##1 (sda == 1);
endproperty 
      
  i2c_clk_freq_prt_ast:assert property (@(posedge scl) i2c_clk_prt )
                        else `uvm_error("i2c_clk_freq_prt_ast" , "FAILL -i2c_clk_freq_prt_ast ")

  apb_clk_freq_prt_ast:assert property (@(posedge pclk) apb_clk_freq_prt )
                        else `uvm_error("apb_clk_freq_prt_ast" , "FAILL -apb_clk_freq_prt_ast ")
*/
  penable_pready_ast:assert property (@(posedge pclk) apb_penable)   
                        else `uvm_error("penable_pready_ast" , "FAILL -penable_pready_ast ")

  pwrite_psel_check_ast:assert property (@(posedge pclk)apb_write_sel_check) 
                        else `uvm_error("pwrite_psel_check_ast" , "FAILL -pwrite_psel_check_ast ")

 /* apb_pwdata_in_ast:assert property (@(posedge pclk) apb_pwdata_in)  
                        else `uvm_error("apb_pwdata_in_ast" , "FAILL -apb_pwdata_in_ast ")
*/
  apb_pwdata_in_stable_ast:assert property (@(posedge pclk) apb_pwdata_in_stable)  
                        else `uvm_error("apb_pwdata_in_ast" , "FAILL -apb_pwdata_in_ast ")

  apb_paddr_in_ast:assert property (@(posedge pclk) apb_paddr_in) 
                        else `uvm_error("apb_paddr_in_ast" , "FAILL -apb_paddr_in_ast ")
/*
  data_addr_stable_befor_ready_ast:assert property (@(posedge pclk) data_addr_stable_befor_ready) 
                        else `uvm_error("data_addr_stable_befor_ready_ast" , "FAILL -data_addr_stable_befor_ready_ast ")

 // apb_pwdata_in_stable_ast:assert property (@(negedge pclk) apb_pwdata_in_stable);  
  i2c_start_cond_address_stable_ast: assert property (@(negedge scl) i2c_start_cond_address_stable) 
                        else `uvm_error("i2c_start_cond_address_stable_ast" , "FAILL -i2c_start_cond_address_stable_ast ")

 // i2c_start_ast : assert property(i2c_start_cond);
  psel_not_unknown_ast:assert property (@(posedge pclk) psel_not_unknown)
                        else `uvm_error("psel_not_unknown_ast" , "FAILL -psel_not_unknown_ast ")

  penable_not_unknown_ast:assert property (@(posedge pclk) penable_not_unknown)
                        else `uvm_error("penable_not_unknown_ast" , "FAILL -penable_not_unknown_ast ")

  pwrite_not_unknown_ast:assert property (@(posedge pclk) pwrite_not_unknown)
                        else `uvm_error("pwrite_not_unknown_ast" , "FAILL -pwrite_not_unknown_ast ")

  pwdatain_not_unknown_ast:assert property (@(posedge pclk) pwdatain_not_unknown)
                        else `uvm_error("pwdatain_not_unknown_ast" , "FAILL -pwdatain_not_unknown_ast ")

  paddr_not_unknown_ast:assert property (@(posedge pclk) paddr_not_unknown)
                        else `uvm_error("paddr_not_unknown_ast" , "FAILL -paddr_not_unknown_ast ")

  psel_stable_in_transfer_ast:assert property (@(posedge pclk) psel_stable_in_transfer)
                        else `uvm_error("psel_stable_in_transfer_ast" , "FAILL -psel_stable_in_transfer_ast ")

  psel_low_then_pwrite_also_low_ast:assert property (@(posedge pclk) psel_low_then_pwrite_low)
                        else `uvm_error("psel_low_then_pwrite_also_low_ast" , "FAILL -psel_low_then_pwrite_also_low_ast ")

  psel_low_then_pwrite_low_covp:cover property(psel_low_then_pwrite_low);
                      //  else `uvm_error("psel_low_then_pwrite_low_covp" , "FAILL -psel_low_then_pwrite_low_covp ")

  pwrite_highthen_pwrite_high_covp:cover property(pwrite_highthen_pwrite_high);
                        //else `uvm_error("pwrite_highthen_pwrite_high_covp" , "FAILL -pwrite_highthen_pwrite_high_covp ")

 initial begin
  $assertoff(0,apb_i2c_assertion.i2c_start_cond_address_stable_ast); //making assertion disable for i2c_start_cond_address_stable_ast
  $assertoff(0,apb_i2c_assertion.data_addr_stable_befor_ready_ast);
 end
*/
endmodule 
