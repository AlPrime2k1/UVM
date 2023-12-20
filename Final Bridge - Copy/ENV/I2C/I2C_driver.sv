class I2C_driver extends uvm_driver #(I2C_trans); 

	`uvm_component_utils(I2C_driver) 

	virtual Bridge_inf vif;
	
	int i;

	function new(string name="I2C_driver",uvm_component parent); 
    	super.new(name,parent); 
  endfunction

	task run_phase(uvm_phase phase);
	  vif.sda_out<=1;// #50;  
	  forever begin
	  	seq_item_port.get_next_item(req);
			`uvm_info("I2C DRV","-------------- DRIVING FROM I2C STARTED -------------------",UVM_LOW)
			req.print();
		  send_to_dut(req);
			`uvm_info("I2C DRV","-------------- DRIVNG FROM I2C FINISHED -------------------",UVM_LOW)
			seq_item_port.item_done();
		end
  endtask

	task send_to_dut(I2C_trans trans_h);

		trans_h.concat();

		@(negedge vif.scl) #15 vif.sda_out<=0;		// Start condition
		`uvm_info("I2C START",">>>>>>>>>>> I2C DRIVER START DETECTED >>>>>>>>>>>>>>>",UVM_LOW)
		
		vif.header<=trans_h.header;

		for(i=7;i>=0;i--)
		begin
			@(negedge vif.scl)											// address passing
		  vif.sda_out<=trans_h.header[i];
		end
		
		@(negedge vif.scl) vif.sda_out<='bz; 			// address acknowledge

		repeat(9) @(negedge vif.scl);							// waiting to get serial data from dut

		vif.sda_out<=0;														// driving ack after reading from slave dut

		#15 vif.sda_out<=1;												// stop condition
		`uvm_info("I2C STOP","<<<<<<<<<<<<<<< I2C DRIVER STOP DETECTED <<<<<<<<<<<<<<<<<<",UVM_LOW)

	endtask
endclass
