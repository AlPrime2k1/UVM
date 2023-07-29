//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: ram_base_test
// Project Name: RAM Verification in UVM
// Description: Base test class to build environment and extended in respective testcases.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ram_base_test extends uvm_test;
 
  `uvm_component_utils(ram_base_test)

   ram_env env_h;
  //virtual ram_if vif;
  //ram_base_wseqs wseqs_h;
  //ram_base_rseqs rseqs_h;
  
  function new (string name = "ram_base_test", uvm_component parent=null);
	  super.new(name,parent);
	//  env_h=ram_env::type_id::create("env_h",this);
   endfunction
   
  function void build_phase (uvm_phase phase);
     super.build_phase(phase);
	  env_h = ram_env::type_id::create("env_h",this);

     //wseqs_h=new("wseqs_h");
     //rseqs_h=new("rseqs_h");
	 	 //creates sequences
   endfunction
  /*
  task run_phase (uvm_phase phase);
     phase.raise_objection(this);
     fork
       wseqs_h.start(env_h.wagent_h.wseqr_h);
       rseqs_h.start(env_h.ragent_h.rseqr_h);
     join
       phase.phase_done.set_drain_time(this,50ns);	 
	 phase.drop_objection(this);
  endtask
  */
endclass
