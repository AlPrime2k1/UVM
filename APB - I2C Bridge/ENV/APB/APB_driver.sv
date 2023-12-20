class APB_driver extends uvm_driver #(APB_trans); 
	`uvm_component_utils(APB_driver) 

	virtual Bridge_inf vif;				

	function new(string name="APB_driver",uvm_component parent); 
    	super.new(name,parent); 
  endfunction

	task run_phase(uvm_phase phase);
	  @(vif.pclk) @(posedge vif.preset);
	   
		forever begin
			fork
				forever begin
					seq_item_port.get_next_item(req);
			    `uvm_info("APB DRV","_______________APB DRIVER IS DRIVING",UVM_LOW)
			    req.print();	
        	send_to_dut(req);
        	seq_item_port.item_done();
				end

				forever begin
					@(posedge vif.pclk) @(posedge vif.preset);
				end
			join_any
		end
  endtask

	task send_to_dut(APB_trans trans_h);
	begin
			@(posedge vif.pclk)
		  begin
			  vif.preset<=trans_h.preset;
				vif.psel<=trans_h.psel;					// Driving Psel
				vif.pwrite<=trans_h.pwrite;
				vif.paddr<=trans_h.paddr;
				if(trans_h.pwrite)
					vif.pwdata_in<=trans_h.pwdata_in;
			end
		  @(posedge vif.pclk)
		  begin
				vif.penable<=trans_h.penable;		// Driving Penable
				wait(vif.pready);
				@(posedge vif.pclk) vif.penable<=0;
			end
	end
	endtask
endclass
