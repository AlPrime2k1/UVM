//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: normal_write_read_vseqs
// Project Name: RAM Verification in UVM
// Description: Normal write then read virtual seqs with simple read and write seqs and disable sequences.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class normal_write_read_vseqs extends ram_base_vseqs;

`uvm_object_utils (normal_write_read_vseqs)
	   
//function new (string name = "ram_base_vseqs");
//	super.new(name);
//endfunction

ram_simple_wseqs  simple_wseqs_h;
ram_simple_rseqs  simple_rseqs_h;
disable_wseqs  dis_wseqs_h;
disable_rseqs  dis_rseqs_h;

task body();

//super.body();
  begin

  begin
    simple_wseqs_h = ram_simple_wseqs::type_id::create("simple_wseqs_h ");
    void'(simple_wseqs_h.randomize() with {no_of_trans==10;});
    simple_wseqs_h.start(wseqr_h);
  end
fork
begin
    dis_wseqs_h= disable_wseqs::type_id::create("dis_wseqs_h ");
    void'(dis_wseqs_h.randomize());
    dis_wseqs_h.start(wseqr_h);
  end

   begin
//    simple_rseqs_h =ram_simple_rseqs::type_id::create("simple_rseqs_h ");
//    void'(simple_rseqs_h.randomize() with {no_of_trans==10;});
//    simple_rseqs_h.start(rseqr_h);
	   `uvm_do_on_with(simple_rseqs_h,rseqr_h,{no_of_trans==10;});
  end
join
begin
	dis_rseqs_h =disable_rseqs::type_id::create("dis_rseqs_h ");
    void'(dis_rseqs_h.randomize());
    dis_rseqs_h.start(rseqr_h);
	 
  end

end
endtask

endclass
