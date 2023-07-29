//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: ram_ragent
// Project Name: RAM Verification in UVM
// Description: Ram read agent consisting of sequencer, driver and monitor for read operations.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ram_ragent extends uvm_agent;

    `uvm_component_utils(ram_ragent)
	
    virtual ram_if vif;
	
	ram_rmon  rmon_h;
	ram_rdr   rdr_h;
	ram_rseqr rseqr_h;
   
   function new (string name = "ram_ragent", uvm_component parent=null);
	  super.new(name,parent);
   endfunction
   
   function void build_phase (uvm_phase phase);
     super.build_phase(phase);
	 rmon_h = ram_rmon::type_id::create("rmon_h",this);
	 rdr_h = ram_rdr::type_id::create("rdr_h",this);
	 rseqr_h = ram_rseqr::type_id::create("rseqr_h",this);
	 if (!uvm_config_db#(virtual ram_if)::get(this,"","vif", vif)) 
        `uvm_fatal("RAM_READ_AGENT", "The virtual interface get failed");
   endfunction
   
   function void connect_phase (uvm_phase phase);
      rdr_h.seq_item_port.connect(rseqr_h.seq_item_export);
	  rdr_h.vif = vif;
	  rmon_h.vif = vif;
   endfunction
   
endclass
