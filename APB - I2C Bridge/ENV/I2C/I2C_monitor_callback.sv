class I2C_monitor_callback extends uvm_callback;
  
 //factory registration
 `uvm_object_utils(I2C_monitor_callback)

 function new(string name = "I2C_monitor_callback");
  super.new(name);
 endfunction

 virtual task data_change(I2C_trans trans_h);		//Callback virtual task extended in i2c_monitor
 endtask

endclass
