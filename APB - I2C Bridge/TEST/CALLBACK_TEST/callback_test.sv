
class callback_test extends Bridge_base_test;

  wrong_data_cb wrng_data_cb;		// handle of wrong data extended from i2c monitor callback class

  // factory registration
  `uvm_component_utils(callback_test)

  callback_vseq vseq_h;

  // function new 
  function new (string name = "callback_test", uvm_component parent=null);
	  super.new(name,parent);
	  vseq_h=callback_vseq::type_id::create("vseq_h");
  endfunction

   // run phase 
  task run_phase (uvm_phase phase);

    wrng_data_cb=wrong_data_cb::type_id::create("err_callback",this);							// create callback
		uvm_callbacks #(I2C_monitor,I2C_monitor_callback)::add(env_h.i2c_agnt_h.mon_h,wrng_data_cb);	// Doing callback

     phase.raise_objection(this);
	  	  vseq_h.start(env_h.vseqr_h);
     phase.phase_done.set_drain_time(this , 50ns) ;
     phase.drop_objection(this);
  endtask
  
endclass
