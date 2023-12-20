class I2C_agent extends uvm_agent; 
	`uvm_component_utils(I2C_agent) 

	I2C_driver drv_h;
	I2C_monitor mon_h;
	I2C_seqr seqr_h;

	virtual Bridge_inf vif;

	function new(string name="I2C_agent",uvm_component parent); 
   	super.new(name,parent); 
  endfunction

	function void build_phase(uvm_phase phase);
  	super.build_phase(phase);
    drv_h=I2C_driver::type_id::create("drv_h",this);
    mon_h=I2C_monitor::type_id::create("mon_h",this);
    seqr_h=I2C_seqr::type_id::create("seqr_h",this);

		if(!uvm_config_db #(virtual Bridge_inf)::get(this,"","vif",vif))
		  `uvm_fatal("I2C INTERFACE FAIL","FAILED TO GET INTERFACE")
  endfunction

	function void connect_phase(uvm_phase phase);
  	super.connect_phase(phase);
    drv_h.seq_item_port.connect(seqr_h.seq_item_export);

		drv_h.vif=vif;
		mon_h.vif=vif;
		seqr_h.vif=vif;
  endfunction
endclass
