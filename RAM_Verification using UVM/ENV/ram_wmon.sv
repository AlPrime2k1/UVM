//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: ram_wmon
// Project Name: RAM Verification in UVM
// Description: Write monitor to sample data from DUT and send to Scoreboard for comparison. 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef RAM_WMON_SV
`define RAM_WMON_SV

class ram_wmon extends uvm_monitor;

  `uvm_component_utils(ram_wmon)
  
   ram_wtrans trans_h; 

   virtual ram_if.WMON_MP vif;
   
   uvm_analysis_port #(ram_wtrans) an_port; 

   function new (string name = "ram_wmon", uvm_component parent=null);
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
   @(vif.wmon_cb);
    //wait(!vif.wmon_cb.rst)
     trans_h=new("w_trans");

   trans_h.wr_enb=vif.wmon_cb.wr_enb;
   trans_h.wr_addr = vif.wmon_cb.wr_addr;
   trans_h.wr_data=vif.wmon_cb.wr_data;
   
   `uvm_info("WR MON","WR MON DATA",UVM_LOW);
    trans_h.print();
   
   endtask
   
endclass

`endif
