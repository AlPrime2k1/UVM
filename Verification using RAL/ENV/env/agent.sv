// Agent class

class agent extends uvm_agent;

  driver    drvh;
  sequencer seqrh;
  monitor   monh;

  `uvm_component_utils(agent)
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    monh = monitor::type_id::create("monh", this);
    if(get_is_active() == UVM_ACTIVE)                       // If active agent -> create sequencer and driver
    begin
      drvh    = driver::type_id::create("drvh", this);
      seqrh = sequencer::type_id::create("seqrh", this);
    end
  endfunction : build_phase
  
  function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE) begin
      drvh.seq_item_port.connect(seqrh.seq_item_export);    // Connecting driver and sequencer if active agent
    end
  endfunction : connect_phase

endclass : agent