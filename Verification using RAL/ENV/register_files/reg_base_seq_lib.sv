/* Register Base Sequence Library

Used RAL APIs : write(), read(), set(), get(), get_mirrored_value(), update(), reset(), set_reset(), get_reset(), needs_update()
                predict(), randomize()    
*/

class reg_base_sequence extends uvm_sequence;

  `uvm_object_utils(reg_base_sequence)

  bit [31:0] temp;                    // Temporary registers
  bit temp2,temp3;

  reg_model regmodel;
  
  function new (string name = "reg_base_sequence");
    super.new(name);
  endfunction
  
  task pre_body(); 
    if (starting_phase != null)
      starting_phase.raise_objection(this);
  endtask
  
  task separator(string name="__");         // Task to separate outputs in cmd
    `uvm_info("SEPARATOR",$sformatf("\n____________________________ %s done upto here ____________________________\n",name),UVM_LOW)
  endtask

  task body;
    uvm_status_e status;
    uvm_reg_data_t desired_val,mirror_val;
    
    bit [31:0] ctrl_rdata,io_rdata,status_rdata,mem_rdata;

// Write method    
    regmodel.status.write(status, 32'hAAAA);
    regmodel.control.write(status, 32'hBBBB);                       // Writing into all reg 
    regmodel.io.write(status, 16'hCCCC);                            // WRITE DONE TO DUT
    regmodel.mem.write(status, 16'hDDDD);

separator("write method");

// Read method
    regmodel.status.read(status,status_rdata);
    regmodel.control.read(status,ctrl_rdata);                       // Reading from all reg
    regmodel.io.read(status,io_rdata);                              // READ DONE TO DUT
    regmodel.mem.read(status,mem_rdata);

separator("read method");

// Get method
    #30;
    desired_val=regmodel.status.get();                                                                  // Getting from status 
    `uvm_info("GET",$sformatf("Getting from status using desired_val : %h\n",desired_val),UVM_LOW)      // Here getting from DUT

    desired_val=regmodel.control.get();                                                                 // Getting from ctrl
    `uvm_info("GET",$sformatf("Getting from ctrl using desired_val : %h\n",desired_val),UVM_LOW)

    desired_val=regmodel.io.get();                                                             // Getting from io without writing would give 0
    `uvm_info("GET",$sformatf("Getting from io using desired_val : %h",desired_val),UVM_LOW)

    desired_val=regmodel.mem.get();                                                                       // Getting from mem
    `uvm_info("GET",$sformatf("Getting from mem using desired_val : %h\n",desired_val),UVM_LOW)

separator("get method");

// Set and Update method
    regmodel.control.set(32'hBCBC);               // Setting in ctrl reg with different value
    regmodel.control.update(status);              // Updating reg [CTRL] so others stay same as before 
    regmodel.control.read(status,ctrl_rdata);                                     
    
    regmodel.mem.set(16'hDEDE);                   // Setting in mem, updating it and then reading it to display values
    regmodel.mem.update(status);
    regmodel.mem.read(status,mem_rdata);
////
    regmodel.status.read(status,status_rdata);
    regmodel.control.read(status,ctrl_rdata);         // Reading from all reg after changes in ctrl and mem registers
    regmodel.io.read(status,io_rdata);
    regmodel.mem.read(status,mem_rdata);              

    regmodel.io.set(16'hABCD);  
    regmodel.io.update(status);                       // Changing the value in one reg and trying to get below
    regmodel.io.read(status,io_rdata);      

separator("set and update method");  

// Getting from the desired value

    #30;                                                                                                
    desired_val=regmodel.status.get();                                                                 
    `uvm_info("GET",$sformatf("Getting from status thru desired_val : %h\n",desired_val),UVM_LOW)       
                                                                                              
    desired_val=regmodel.control.get();                                                                
    `uvm_info("GET",$sformatf("Getting from ctrl using desired_val : %h\n",desired_val),UVM_LOW)        
                                                                                              
    desired_val=regmodel.io.get();                                                                     
    `uvm_info("GET",$sformatf("Getting from io thru desired_val : %h\n",desired_val),UVM_LOW)           
                                                                                              
    desired_val=regmodel.mem.get();                                                                    
    `uvm_info("GET",$sformatf("Getting from mem using desired_val : %h\n",desired_val),UVM_LOW)      
////
// Resetting registers, if has_reset() is zero in configure(status reg), it won't reset -> Have to set_reset() first

    regmodel.status.reset();                // Won't work here as doesn't has reset value
    
    desired_val=regmodel.status.get();                                                              // Getting desired val
        `uvm_info("GET",$sformatf("GETTING DESIRED VAL AFTER RESETTING STATUS REG (not set) : %h\n",desired_val),UVM_LOW)
    
    temp=regmodel.status.get_reset();      // Here it'll show value of the status reg till now as it doesn't have a reset value
    `uvm_info("GET RESET",$sformatf("___ Getting reset of status reg : %h ____\n",temp),UVM_LOW) 

separator("reset and get reset method");
    
    temp3=regmodel.status.has_reset();        // Returns 1 when needs to update reg Else 0 -> if above line is commented, gives ZERO
    `uvm_info("HAS RESET",$sformatf("Has Reset var temp3 for status : %0d\n",temp3),UVM_LOW)

    temp3=regmodel.mem.has_reset();        // Returns 1 when needs to update reg Else 0 -> if above line is commented, gives ZERO
    `uvm_info("HAS RESET",$sformatf("Has Reset var temp3 for mem : %0d\n",temp3),UVM_LOW)

    regmodel.status.set_reset(32'hFEDCBA10);       // Setting reset value to fedcba10
    temp=regmodel.status.get_reset();             // Here it'll show value of the status reg set above
    `uvm_info("GET RESET",$sformatf("___ Getting reset of status reg after setting reset : %h ____\n",temp),UVM_LOW) 
    regmodel.status.reset();
    
    regmodel.control.set(16'h1111);         // Setting a value in ctrl reg won't get reflected in get_mirrored_value method

separator("set reset and has reset method");

// Getting from the mirror value 
    #30;                                                                                                
    mirror_val=regmodel.status.get_mirrored_value();                                                                 
    `uvm_info("GET MIRROR",$sformatf("Getting from status (mirror) thru mirrored_val : %h\n",mirror_val),UVM_LOW)       
//                                                                                              
    desired_val=regmodel.control.get();                                                              // Getting desired val
    `uvm_info("GET",$sformatf("Getting from ctrl using desired_val : %h\n",desired_val),UVM_LOW)      

    mirror_val=regmodel.control.get_mirrored_value();                                                 // Getting mirror val (not updated)               
    `uvm_info("GET MIRROR",$sformatf("Getting from ctrl (mirror) using mirrored_val : %h\n",mirror_val),UVM_LOW)        
//                                                                                              
    mirror_val=regmodel.io.get_mirrored_value();                                                                     
    `uvm_info("GET MIRROR",$sformatf("Getting from io (mirror) thru mirrored_val : %h\n",mirror_val),UVM_LOW)           
                                                                                              
    mirror_val=regmodel.mem.get_mirrored_value();                                                                    
    `uvm_info("GET MIRROR",$sformatf("Getting from mem (mirror) using mirrored_val : %h\n",mirror_val),UVM_LOW)  
////
separator("get mirrored value method");

    regmodel.mem.set(16'hA11A);
    temp2=regmodel.mem.needs_update();        // Returns 1 when needs to update reg Else 0 -> if above line is commented, gives ZERO

    `uvm_info("NEEDS UPDATE",$sformatf("Needs update var temp2 : %0d\n",temp2),UVM_LOW)
////
separator("needs update method");

    regmodel.mem.predict(16'hF1F0);           // Predict method sets to both desired value and mirror value but doesn't need update
    temp2=regmodel.mem.needs_update();        // Needs_update would return 0 here
    `uvm_info("NEEDS UPDATE",$sformatf("Needs update from mem into temp2 : %d",temp2),UVM_LOW)

    desired_val=regmodel.mem.get();
    `uvm_info("GET",$sformatf("Getting after PREDICTING data into mem reg : %h",desired_val),UVM_LOW)
    
    mirror_val=regmodel.mem.get_mirrored_value();
    `uvm_info("GET MIRROR",$sformatf("Getting after PREDICTING data into mem reg : %h",mirror_val),UVM_LOW)

    regmodel.mem.update(status);              // Won't do anything
    
    desired_val=regmodel.mem.get();
    `uvm_info("GET",$sformatf("Getting after PREDICTING and UPDATING data into mem reg : %h",desired_val),UVM_LOW)
    
    mirror_val=regmodel.mem.get_mirrored_value();
    `uvm_info("GET MIRROR",$sformatf("Getting after PREDICTING and UPDATING data into mem reg : %h",mirror_val),UVM_LOW)

    #50 regmodel.mem.read(status,mem_rdata);        // Will read the preovious value stored in reg
////
separator("predict method");


`uvm_info("DUT READOUT",$sformatf("\n------------------\nSTATUS : %h\nCTRL   : %h\nIO     : %h\nMEM    : %h\n------------------",status_rdata,ctrl_rdata,io_rdata,mem_rdata),UVM_LOW)
////
    regmodel.status.reset();
    regmodel.control.reset();
    regmodel.io.reset();
    regmodel.mem.reset();

    regmodel.control.randomize();
    
    desired_val=regmodel.status.get();                                                                 
    `uvm_info("GET",$sformatf("Getting reset value from status thru desired_val : %h\n",desired_val),UVM_LOW)       
                                                                                              
    desired_val=regmodel.control.get();                                                                
    `uvm_info("GET",$sformatf("Getting random value from ctrl using desired_val : %h\n",desired_val),UVM_LOW)        
                                                                                              
    desired_val=regmodel.io.get();                                                                     
    `uvm_info("GET",$sformatf("Getting from io after resetting : %h\n",desired_val),UVM_LOW)           
                                                                                              
    desired_val=regmodel.mem.get();                                                                    
    `uvm_info("GET",$sformatf("Getting from mem after resetting : %h\n",desired_val),UVM_LOW)      

//regmodel.control.update(status,UVM_FRONTDOOR);
  endtask
  
  task post_body();
    `uvm_info("REG ITEM",$sformatf("This is to show the contents of register item :\n %p\n",regmodel.control),UVM_LOW)
      if (starting_phase != null)
      starting_phase.drop_objection(this); 
  endtask
  
endclass     
