///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: ram_base_wseqs
// Project Name: RAM Verification in UVM
// Description: Ram base virual write seqs responsible for setting soft
// constraints which will be overridden in main write seqs extended from it.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class ram_base_wseqs extends uvm_sequence #(ram_wtrans);

   `uvm_object_utils(ram_base_wseqs)

	rand int no_of_trans;
    ram_wtrans trans_h;
  
	constraint number{soft no_of_trans==1;}

    function new (string name = "ram_base_wseqs");
       super.new(name);
    endfunction
 
// task body();
//  trans_h=ram_wtrans::type_id::create("trans_h");
//  repeat(10) begin
//   //`uvm_do(trans);
//   //`uvm_do_with(trans with {wr_addr<7;});
//   
//   start_item(trans_h);
//   assert(trans_h.randomize() );//with {trans_h.wr_enb==1;});
//   finish_item(trans_h);
//  end
// endtask
//
endclass
