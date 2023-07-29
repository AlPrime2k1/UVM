//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: sim_write_read_vseqs
// Project Name: RAM Verification in UVM
// Description: Virtual sequence for simultaneous read and write using simple read and write seqs
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class sim_write_read_vseqs extends ram_base_vseqs;

`uvm_object_utils (sim_write_read_vseqs)

//function new (string name = "ram_base_vseqs");
//	super.new(name);
//endfunction

ram_simple_wseqs  simple_wseqs_h;
ram_simple_rseqs  simple_rseqs_h;

task body();

//super.body();
  fork

  begin
   
		  /*simple_wseqs_h = ram_simple_wseqs::type_id::create("simple_wseqs_h ");
    void'(simple_wseqs_h.randomize() with {no_of_trans==10;});
    simple_wseqs_h.start(wseqr_h);			// this seqr is handle in base vseqs which points to actual seqr through virtual seqr
	*/
   `uvm_do_on_with(simple_wseqs_h,wseqr_h,{no_of_trans==10;})
  end

   begin
   /* simple_rseqs_h =ram_simple_rseqs::type_id::create("simple_rseqs_h ");
    void'(simple_rseqs_h.randomize() with {no_of_trans==10;});
    simple_rseqs_h.start(rseqr_h);*/
	`uvm_do_on_with(simple_rseqs_h,rseqr_h,{no_of_trans==10;})
  end

join
endtask

endclass
