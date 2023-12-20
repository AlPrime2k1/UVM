
class no_preset_test extends Bridge_base_test;


  // factory registration
  `uvm_component_utils(no_preset_test)

  no_preset_vseq vseq_h;

  // function new 
  function new (string name = "no_preset_test", uvm_component parent=null);
	  super.new(name,parent);
	  vseq_h=no_preset_vseq::type_id::create("vseq_h");
  endfunction
   
  
   // run phase 
  task run_phase (uvm_phase phase);
     phase.raise_objection(this);
	 	 	vseq_h.start(env_h.vseqr_h);
     phase.drop_objection(this);
  endtask
  
endclass
