class APB_monitor extends uvm_monitor; 

	`uvm_component_utils(APB_monitor) 

	uvm_analysis_port #(APB_trans) an_port;

	APB_trans trans_h;
	virtual Bridge_inf vif;

	function new(string name="APB_monitor",uvm_component parent); 
    super.new(name,parent);
		an_port=new("an_port",this);
  endfunction

	task run_phase(uvm_phase phase);
	  forever begin
		monitor();
		end
	endtask

	task monitor();
		trans_h=new();
		@(posedge vif.pclk)
	   begin
		  trans_h.psel=vif.psel;
		  trans_h.penable=vif.penable;
		  trans_h.preset=vif.preset;
		  trans_h.pwrite=vif.pwrite;
		  trans_h.pready=vif.pready;
		  trans_h.paddr=vif.paddr;
		  trans_h.pwdata_in=vif.pwdata_in;
		  trans_h.prdata_out=vif.prdata_out;

		  `uvm_info("APB MON","APB MONITOR is monitoring",UVM_LOW)
		  trans_h.print();
		  an_port.write(trans_h);

	   end
	endtask
endclass
