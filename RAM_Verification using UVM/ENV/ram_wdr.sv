//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: ram_wdr
// Project Name: RAM Verification in UVM
// Description: Write driver responsible for driving transactions to DUT.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class ram_wdr extends uvm_driver #(ram_wtrans);

   `uvm_component_utils(ram_wdr)
  
   virtual ram_if vif;
    
   function new (string name = "ram_wdr", uvm_component parent=null);
       super.new(name,parent);
   endfunction
   

   task run_phase(uvm_phase phase);
    @(vif.wdr_cb) wait(vif.wdr_cb.rst);
    @(vif.wdr_cb) wait(!vif.wdr_cb.rst);
	forever begin
    fork
      forever begin
      seq_item_port.get_next_item(req);
	//  req.wr_enb=0;
      send_to_dut(req);
      seq_item_port.item_done();
      end
 
      begin
      @(vif.wdr_cb) wait(vif.wdr_cb.rst);
      end
    join_any
     
    disable fork;
    @(vif.wdr_cb) wait(!vif.wdr_cb.rst);
	end
   endtask
   
   task send_to_dut(ram_wtrans req);
   //reset wait
   //signal drive  

   @(vif.wdr_cb)    
  
  //wait(!vif.wdr_cb.rst)

   vif.wdr_cb.wr_addr <= req.wr_addr;
   vif.wdr_cb.wr_enb<= req.wr_enb;
   vif.wdr_cb.wr_data<=req.wr_data;
   `uvm_info("WR DRV","WR DRV DATA",UVM_LOW);
   req.print();
   
   endtask
   
endclass
