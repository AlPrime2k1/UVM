//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: ram_rmon
// Project Name: RAM Verification in UVM
// Description: Ram read monitor responsible for sampling transction from DUT.
// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ram_rmon extends uvm_monitor;

  `uvm_component_utils(ram_rmon)
  
  ram_rtrans trans_h;

   virtual ram_if.RMON_MP vif;
   
   uvm_analysis_port #(ram_rtrans) an_port;

   function new (string name = "ram_rmon", uvm_component parent=null);
	  super.new(name,parent);
    
    an_port=new("an_port",this);
   endfunction
   
   task run_phase(uvm_phase phase);
     forever begin
       monitor();
       an_port.write(trans_h);
     end
	   
   endtask
   
   task monitor();
      
      //handle creation
      
      //wait for reset
	  // collect data //
     @(vif.rmon_cb) ;
     //wait(!vif.rmon_cb.rst)
     trans_h=new("r_trans");

    trans_h.rd_addr = vif.rmon_cb.rd_addr;
    trans_h.rd_enb=vif.rmon_cb.rd_enb;
    trans_h.rd_data=vif.rmon_cb.rd_data;
    
    `uvm_info("RD MON","RD MON DATA",UVM_LOW);
        trans_h.print();
    
   endtask
   
endclass
