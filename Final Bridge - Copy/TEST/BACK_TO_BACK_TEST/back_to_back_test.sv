
class back_to_back_test extends Bridge_base_test;


  // factory registration
  `uvm_component_utils(back_to_back_test)

  back_to_back_vseq vseq_h;

  // function new 
  function new (string name = "back_to_back_test", uvm_component parent=null);
	  super.new(name,parent);
	  vseq_h=back_to_back_vseq::type_id::create("vseq_h");
   endfunction
   
  
   // run phase 
  task run_phase (uvm_phase phase);
     phase.raise_objection(this);
	  	  vseq_h.start(env_h.vseqr_h);
     phase.phase_done.set_drain_time(this , 50ns) ;
     phase.drop_objection(this);
  endtask
  
endclass
