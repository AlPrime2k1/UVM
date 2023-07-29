//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: ram_rdr
// Project Name: RAM Verification in UVM
// Description: RAM read driver to drive transaction generated from seqr to DUT.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ram_rdr extends uvm_driver #(ram_rtrans);

   `uvm_component_utils(ram_rdr)
   
   virtual ram_if vif;
      
   function new (string name = "ram_rdr", uvm_component parent=null);
       super.new(name,parent);
   endfunction
   
   task run_phase(uvm_phase phase);
     @(vif.wdr_cb) wait(vif.rdr_cb.rst);
     @(vif.rdr_cb) wait(!vif.rdr_cb.rst);
	 forever begin
    fork
      forever begin
      seq_item_port.get_next_item(req);
	 // req.rd_enb=0;
      send_to_dut(req);
      seq_item_port.item_done();
      end 

      begin
         @(vif.rdr_cb) wait(vif.rdr_cb.rst);
      end
     join_any 

     disable fork;
     @(vif.rdr_cb) wait(!vif.rdr_cb.rst);
	 end
   endtask
   
   task send_to_dut(ram_rtrans req);
   //reset wait
   //signal drive   
   @(vif.rdr_cb) 

   //wait(!vif.rdr_cb.rst)
   vif.rdr_cb.rd_addr <= req.rd_addr;
   vif.rdr_cb.rd_enb<=req.rd_enb;
   `uvm_info("RD DRV","RD DRV DATA",UVM_LOW);
   req.print();
  // req.rd_enb=0;
   endtask
   
endclass
