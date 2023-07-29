//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: back_to_back_test
// Project Name: RAM Verification in UVM
// Description: Testcase with back to back write and read operations using back_to_back_vseqs.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class back_to_back_test extends ram_base_test;


  // factory registration
  `uvm_component_utils(back_to_back_test)

  back_to_back_vseqs vseqs_h;

  // function new 
  function new (string name = "back_to_back_test", uvm_component parent=null);
	  super.new(name,parent);
	  vseqs_h=back_to_back_vseqs::type_id::create("vseqs_h");
   endfunction
   
  
   // run phase 
  task run_phase (uvm_phase phase);
     phase.raise_objection(this);
	  	  vseqs_h.start(env_h.vseqr_h);
     phase.phase_done.set_drain_time(this , 50ns) ;
     phase.drop_objection(this);
  endtask
  
endclass
