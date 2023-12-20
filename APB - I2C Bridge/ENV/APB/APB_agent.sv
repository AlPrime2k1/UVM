class APB_agent extends uvm_agent; 
	`uvm_component_utils(APB_agent) 

	APB_driver drv_h;
	APB_monitor mon_h;
	APB_seqr seqr_h;

	virtual Bridge_inf vif;

	function new(string name="APB_agent",uvm_component parent); 
    	super.new(name,parent); 
  endfunction

	function void build_phase(uvm_phase phase);
 		super.build_phase(phase);
    drv_h=APB_driver::type_id::create("drv_h",this);
    mon_h=APB_monitor::type_id::create("mon_h",this);
    seqr_h=APB_seqr::type_id::create("seqr_h",this);

		if(!uvm_config_db #(virtual Bridge_inf)::get(this,"","vif",vif))
		  `uvm_fatal("APB INTERFACE FAIL","FAILED TO GET INTERFACE")
  endfunction

	function void connect_phase(uvm_phase phase);
   	super.connect_phase(phase);
   	drv_h.seq_item_port.connect(seqr_h.seq_item_export);
		drv_h.vif=vif;
		mon_h.vif=vif;
		seqr_h.vif=vif;
  endfunction
endclass
