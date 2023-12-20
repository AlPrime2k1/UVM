class Bridge_env extends uvm_env; 
	`uvm_component_utils(Bridge_env) 

		APB_agent apb_agnt_h;
		I2C_agent i2c_agnt_h;
		Bridge_sb scbd_h;
		Bridge_virtual_seqr vseqr_h;

	function new(string name="Bridge_env",uvm_component parent); 
    	super.new(name,parent); 
  endfunction

	function void build_phase(uvm_phase phase);
  	super.build_phase(phase);
  	apb_agnt_h=APB_agent::type_id::create("apb_agnt_h",this);
		i2c_agnt_h=I2C_agent::type_id::create("i2c_agnt_h",this);
		scbd_h=Bridge_sb::type_id::create("scbd_h",this);
		vseqr_h=Bridge_virtual_seqr::type_id::create("vseqr_h",this);
  endfunction

	function void connect_phase(uvm_phase phase);
  	super.connect_phase(phase);
  	apb_agnt_h.mon_h.an_port.connect(scbd_h.apb_imp);
		i2c_agnt_h.mon_h.an_port.connect(scbd_h.i2c_imp);

		vseqr_h.apb_seqr_h=apb_agnt_h.seqr_h;									// connecting virtual seqr to actual seqrs
		vseqr_h.i2c_seqr_h=i2c_agnt_h.seqr_h;
  endfunction
endclass
