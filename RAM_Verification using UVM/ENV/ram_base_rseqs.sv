//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: ram_base_rseqs
// Project Name: RAM Verification in UVM
// Description: Ram base virual read seqs responsible for setting soft constraints which will be overridden in main read seqs extended from it.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



class ram_base_rseqs extends uvm_sequence #(ram_rtrans);

   `uvm_object_utils(ram_base_rseqs)
	rand int no_of_trans;
    ram_rtrans trans_h;
   constraint num{soft no_of_trans==1;}

    function new (string name = "ram_base_rseqs");
       super.new(name);
    endfunction
   
//    task body();
//      trans_h = ram_rtrans::type_id::create("trans_h");
//      repeat(10) begin
//	    
//		start_item(trans_h);
//		assert(trans_h.randomize());//with {trans_h.rd_enb==0;});
//		finish_item(trans_h);
//	  end
//	endtask
//
endclass
		
