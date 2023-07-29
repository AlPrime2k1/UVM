//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: ram_wagent
// Project Name: RAM Verification in UVM
// Description: Write agent consisting of sequencer, driver and monitor for write operations.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef RAM_WAGENT_SV


class ram_wagent extends uvm_agent;

    `uvm_component_utils(ram_wagent)
	
	virtual ram_if vif;
	
	ram_wmon wmon_h;
	ram_wdr  wdr_h;
	ram_wseqr wseqr_h;
   
   function new (string name = "ram_wagent", uvm_component parent=null);
	  super.new(name,parent);
   endfunction
   
   function void build_phase (uvm_phase phase);
     super.build_phase(phase);
	 wmon_h = ram_wmon::type_id::create("wmon_h",this);
	 
	 wdr_h = ram_wdr::type_id::create("wdr_h",this);
	 wseqr_h = ram_wseqr::type_id::create("wseqr_h",this);
	 if (!uvm_config_db #(virtual ram_if)::get(this,"","vif", vif)) 
        `uvm_fatal("RAM_WRITE_AGENT", "The virtual interface get failed");
   endfunction
   
   function void connect_phase (uvm_phase phase);
      wdr_h.seq_item_port.connect(wseqr_h.seq_item_export);
	  wdr_h.vif = vif;
	  wmon_h.vif = vif;
   endfunction
   
endclass
`endif
