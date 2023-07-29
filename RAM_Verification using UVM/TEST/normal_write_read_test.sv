//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: normal_test
// Project Name: RAM Verification in UVM
// Description: Testcase with first write and then read operations using normal_write_read_vseqs.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class normal_write_read_test extends ram_base_test;


  // factory registration
  `uvm_component_utils(normal_write_read_test)

  ram_base_vseqs vseqs_h;

  // function new 
  function new (string name = "normla_write_read_test", uvm_component parent=null);
	  super.new(name,parent);
	  vseqs_h=normal_write_read_vseqs::type_id::create("vseqs_h");
   endfunction
   
  
   // run phase 
  task run_phase (uvm_phase phase);
     phase.raise_objection(this);
	  	  vseqs_h.start(env_h.vseqr_h);
     phase.phase_done.set_drain_time(this , 50ns) ;
     phase.drop_objection(this);
  endtask
  
endclass
