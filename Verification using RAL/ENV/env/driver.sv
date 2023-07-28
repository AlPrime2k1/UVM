// Driver class

`define DRV_VIF vif.DRIVER.driver_cb

class driver extends uvm_driver #(seq_item);

  virtual ral_if vif;                   // Instance of interface
  `uvm_component_utils(driver)
    
  function new (string name, uvm_component parent);       // Factory registration
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     if(!uvm_config_db#(virtual ral_if)::get(this, "", "vif", vif))                         // getting virtual interface set in top
       `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction: build_phase

  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);      
      drive();
      seq_item_port.item_done();
    end
  endtask : run_phase
  
virtual task drive();
    `DRV_VIF.wr_en <= 0;
    @(posedge vif.DRIVER.clk);
    
    `DRV_VIF.addr <= req.addr;
    
    `DRV_VIF.wr_en <= (req.kind == WRITE ) ? 1'b1 : 1'b0;
    if(req.kind == WRITE) 
    begin                             // write operation
      `DRV_VIF.wdata <= req.wdata;
      @(posedge vif.DRIVER.clk);
    end
    
    else 
    begin                             //read operation
      @(posedge vif.DRIVER.clk);
      @(posedge vif.DRIVER.clk);
      req.rdata = `DRV_VIF.rdata;
    end
    
  endtask : drive
endclass : driver
