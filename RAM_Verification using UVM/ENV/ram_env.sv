//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: ram_env
// Project Name: RAM Verification in UVM
// Description: Environment class of ram conisting of both agents, scoreboard and virtual seqr and connects agent to scoreboard
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class ram_env extends uvm_env;

  `uvm_component_utils(ram_env)
	
	ram_wagent wagent_h;
	ram_ragent ragent_h;
	ram_sb		 sb_h;
	ram_virtual_seqr vseqr_h;
   
   function new (string name = "ram_env", uvm_component parent=null);
	  super.new(name,parent);
   endfunction
   
   function void build_phase (uvm_phase phase);
     super.build_phase(phase);
	   wagent_h = ram_wagent::type_id::create("wagent_h",this);
	   ragent_h = ram_ragent::type_id::create("ragent_h",this);
	   sb_h = ram_sb::type_id::create("sb_h",this);
	   vseqr_h=ram_virtual_seqr::type_id::create("vseqr_h",this);
   endfunction

   function void connect_phase(uvm_phase phase);
   	wagent_h.wmon_h.an_port.connect(sb_h.wr_imp);
   	ragent_h.rmon_h.an_port.connect(sb_h.rd_imp);
	vseqr_h.wseqr_h = wagent_h.wseqr_h;
	vseqr_h.rseqr_h = ragent_h.rseqr_h;
   endfunction 
     
endclass
