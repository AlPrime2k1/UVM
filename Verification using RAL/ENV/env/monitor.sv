// Monitor class

class monitor extends uvm_monitor;

  virtual ral_if vif;

  uvm_analysis_port #(seq_item) item_collected_port;        // Analysis port to send trans to predictor

  seq_item trans_collected;                                 // Handle of transaction class

  `uvm_component_utils(monitor)

  function new (string name="monitor", uvm_component parent);
    super.new(name, parent);
    trans_collected = new();
    item_collected_port = new("item_collected_port", this);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual ral_if)::get(this, "", "vif", vif))                          // Getting virtual interface set in top
       `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction: build_phase
  
  virtual task run_phase(uvm_phase phase);
   forever 
   begin
      @(posedge vif.MONITOR.clk);
        trans_collected.addr = vif.monitor_cb.addr;
        trans_collected.kind = trans_kind_e'(vif.monitor_cb.wr_en);
        
      if(vif.monitor_cb.wr_en) 
      begin
        trans_collected.wdata = vif.monitor_cb.wdata;
        @(posedge vif.MONITOR.clk);
      end
      else begin
        @(posedge vif.MONITOR.clk);
        @(posedge vif.MONITOR.clk);
        trans_collected.rdata = vif.monitor_cb.rdata;
      end

	  item_collected_port.write(trans_collected);
    end 
  endtask : run_phase
endclass : monitor
