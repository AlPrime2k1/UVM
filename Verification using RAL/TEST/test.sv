// Test class consisting of Environment and Reg base sequence library

class ral_model_base_test extends uvm_test;

  `uvm_component_utils(ral_model_base_test)
  
  reg_model_env env;
  reg_base_sequence reg_seq;

  function new(string name = "ral_model_base_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = reg_model_env::type_id::create("env", this);
    reg_seq = reg_base_sequence::type_id::create("reg_seq");
  endfunction : build_phase
  
  virtual function void connect_phase(uvm_phase phase);
    reg_seq.regmodel = env.regmodel;
  endfunction : connect_phase

 
  virtual function void end_of_elaboration();
    print();
  endfunction

  task run_phase(uvm_phase phase);
    reg_seq.starting_phase = phase;
    phase.raise_objection(this);
      reg_seq.start(env.agnt.seqrh); 
    phase.drop_objection(this);

    phase.phase_done.set_drain_time(this, 50);
  endtask : run_phase
endclass : ral_model_base_test
