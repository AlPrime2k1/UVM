//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: sim_write_read_test
// Project Name: RAM Verification in UVM
// Description: Testcase for simultaneos write-read operations using sim_write_read_vseqs 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class sim_write_read_test extends ram_base_test;


  // factory registration
  `uvm_component_utils(sim_write_read_test)

  ram_base_vseqs vseqs_h;

  // function new 
  function new (string name = "sim_write_read_test", uvm_component parent=null);
	  super.new(name,parent);
	  vseqs_h=sim_write_read_vseqs::type_id::create("vseqs_h");
   endfunction
   
  
   // run phase 
  task run_phase (uvm_phase phase);
     phase.raise_objection(this);
	  	  vseqs_h.start(env_h.vseqr_h);
     phase.phase_done.set_drain_time(this , 50ns) ;
     phase.drop_objection(this);
  endtask
  
endclass
