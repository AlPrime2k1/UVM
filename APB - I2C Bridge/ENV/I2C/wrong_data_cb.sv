class wrong_data_cb extends I2C_monitor_callback;

`uvm_object_utils(wrong_data_cb)

function new(string name="wrong_data_cb");
  super.new(name);
endfunction

task data_change(I2C_trans trans_h);					// task extended from i2c monitor callback class
  if(trans_h.header==8'd203)
  	trans_h.rec_data=$urandom_range(10,100);
  `uvm_info("_______CB______","HEADER CHANGE IS CALLED HERE XXXXXXXXXXXXXXXXXX",UVM_LOW)
endtask

endclass
