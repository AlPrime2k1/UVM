// Environment class

class reg_model_env extends uvm_env;
  
  agent      agnt;
  reg_model  regmodel;   
  adapter    m_adapter;
  uvm_reg_predictor #(seq_item) prdt_h;   // Predictor
  
  `uvm_component_utils(reg_model_env)
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agnt = agent::type_id::create("agnt", this);
    prdt_h = uvm_reg_predictor #(seq_item):: type_id::create("prdt_h", this);       // create

    regmodel = reg_model::type_id::create("regmodel", this);
    regmodel.build();

    m_adapter = adapter::type_id::create("m_adapter",, get_full_name());
  endfunction : build_phase
  
  function void connect_phase(uvm_phase phase);
     
    regmodel.default_map.set_sequencer( .sequencer(agnt.seqrh), .adapter(m_adapter) );
    regmodel.default_map.set_base_addr('h400);      // Base address of 400 is set, Address of registers is Base address + Offset

    prdt_h.map = regmodel.default_map; //Assigning map handle                       // configure
    prdt_h.adapter = m_adapter;        //Assigning adapter handle
    agnt.monh.item_collected_port.connect(prdt_h.bus_in);                           // connect monitor to predictor

  endfunction : connect_phase

endclass : reg_model_env