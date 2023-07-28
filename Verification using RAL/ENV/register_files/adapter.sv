// Adapter class

/* Difference between reg and bus item is that -

Reg item is pre-defined and consists of a lot of info about register like its max size, access controls, instance number, instance count, 
seeding number, number of fields, name etc.

Bus item is user defined and consists of data fields specified in the transaction class with byte enable and status.

Display can be uncommented in the functions see the difference.
*/

class adapter extends uvm_reg_adapter;
  `uvm_object_utils (adapter)

  function new (string name = "adapter");
      super.new (name);
  endfunction
 
  function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);    // Function to convert register item to bus item
    seq_item tx;    
    tx = seq_item::type_id::create("tx");
    
    tx.kind =trans_kind_e'(rw.kind);
    tx.addr  = rw.addr;
    if (tx.kind == WRITE)  tx.wdata = rw.data;
    if (tx.kind == READ) tx.rdata = rw.data;
    //`uvm_info("REG2BUS",$sformatf("REG to BUS Display : %p\n",tx),UVM_LOW)    
    return tx;
  endfunction

  function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);   // Function to convert bus item to register item
    seq_item tx;
    
    assert( $cast(tx, bus_item) )
      else `uvm_fatal("FATAL", "Failed to cast bus item to data packet")

     //$cast(rw.kind,tx.kind);
    rw.kind=uvm_access_e'(tx.kind);
    rw.addr = tx.addr;
    rw.data = tx.rdata;
    rw.status = UVM_IS_OK;
    //`uvm_info("BUS2REG",$sformatf("BUS to REG Display : %p\n",rw),UVM_LOW)
  endfunction
endclass
