class Bridge_sanity_test extends Bridge_base_test;

	`uvm_component_utils(Bridge_sanity_test) 

	APB_sanity_seq apb_seq_h;
	I2C_sanity_seq i2c_seq_h;

	function new(string name="Bridge_sanity_test",uvm_component parent); 
    	super.new(name,parent); 
    endfunction


	task run_phase(uvm_phase phase);
    		super.run_phase(phase);	
    		apb_seq_h=APB_sanity_seq::type_id::create("apb_seq");
			i2c_seq_h=I2C_sanity_seq::type_id::create("i2c_seq");

			phase.raise_objection(this);
		  begin
			apb_seq_h.start(env_h.apb_agnt_h.seqr_h);
			i2c_seq_h.start(env_h.i2c_agnt_h.seqr_h);
			  end
			#50;
			phase.drop_objection(this);
	endtask

endclass
