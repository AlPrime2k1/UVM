class I2C_monitor extends uvm_monitor; 

	`uvm_component_utils(I2C_monitor) 
	`uvm_register_cb(I2C_monitor,I2C_monitor_callback)			// Registering callback here

	uvm_analysis_port #(I2C_trans) an_port;

	bit [2:0] count=7;
	virtual Bridge_inf vif;

	I2C_trans trans_h;

	function new(string name="I2C_monitor",uvm_component parent); 
   	super.new(name,parent);
		an_port=new("an_port",this);
  endfunction

	task run_phase(uvm_phase phase);
  	trans_h=new();	
		forever fork 
		begin
			@(negedge vif.sda)											// start
			begin
					  
				if(vif.scl==1 && vif.sda==0)
				  `uvm_info("I2C START","I2C MONITOR START DETECTED >>>>>>>>>>>>>>>>>>>>>",UVM_LOW)
				repeat(8)
				begin
				  @(posedge vif.scl)
				  trans_h.header[count]=vif.sda;			// Sampling address + control bit
				  count--;
				end


				@(posedge vif.scl) 										// wait for ack

				repeat(8)
				begin
				  @(posedge vif.scl)
				  trans_h.rec_data[count]=vif.sda;		// sampling data to rec_data
				  count--;
				end

				`uvm_do_callbacks(I2C_monitor,I2C_monitor_callback,data_change(trans_h));			// Placing  

				@(posedge vif.scl);										// wait for data ack
			end
		end

		begin
		@(posedge vif.sda)												// stop
		   begin
			 	if(vif.sda==1 && vif.scl==1)
			 	begin
			  	`uvm_info("I2C STOP","I2C MONITOR STOP DETECTED <<<<<<<<<<<<<<<<<<<<",UVM_LOW)
				 	an_port.write(trans_h);							// Writing to analysis port after stop condition detection
				 	trans_h.print();
			 	end
			 end
		end
		join
			
	endtask

endclass
