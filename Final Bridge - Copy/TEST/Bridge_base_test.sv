class Bridge_base_test extends uvm_test;

	`uvm_component_utils(Bridge_base_test) 

	Bridge_env env_h;
	//APB_base_seq apb_seq_h;
	//I2C_base_seq i2c_seq_h;

	function new(string name="Bridge_base_test",uvm_component parent); 
    	super.new(name,parent); 
    endfunction

	function void build_phase(uvm_phase phase);
    		super.build_phase(phase);
    		env_h=Bridge_env::type_id::create("env_h",this);
    endfunction
/*
	task run_phase(uvm_phase phase);
    	//	super.run_phase(phase);
    		apb_seq_h=APB_base_seq::type_id::create("apb_seq");
			i2c_seq_h=I2C_base_seq::type_id::create("i2c_seq");

			phase.raise_objection(this);
		    fork
				apb_seq_h.start(env_h.apb_agnt_h.seqr_h);
				i2c_seq_h.start(env_h.i2c_agnt_h.seqr_h);
			  join
			#50;
			phase.drop_objection(this);
	endtask
*/
endclass
