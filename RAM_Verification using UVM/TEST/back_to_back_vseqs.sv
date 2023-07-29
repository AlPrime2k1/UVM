//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: back_to_back_vseqs
// Project Name: RAM Verification in UVM
// Description: Virtual sequence with task body as nack to back sequence.
// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class back_to_back_vseqs extends ram_base_vseqs;

`uvm_object_utils (back_to_back_vseqs)

ram_simple_wseqs  simple_wseqs_h;
ram_simple_rseqs  simple_rseqs_h;			// all the sequences required for testcase
disable_wseqs  dis_wseqs_h;
disable_rseqs  dis_rseqs_h;

task body();

//super.body();		commented as this is being done by pre_body in base vseqs
 repeat($urandom_range(5,10)) 
begin

fork
  begin
//    simple_wseqs_h = ram_simple_wseqs::type_id::create("simple_wseqs_h ");
//    void'(simple_wseqs_h.randomize());
//    simple_wseqs_h.start(wseqr_h);
`uvm_do_on(simple_wseqs_h,wseqr_h)


  end

  begin
//    dis_rseqs_h =disable_rseqs::type_id::create("dis_rseqs_h ");
//    void'(dis_rseqs_h.randomize());
//    dis_rseqs_h.start(rseqr_h);
`uvm_do_on(dis_rseqs_h,rseqr_h)
  end
join

fork
  begin
  //  dis_wseqs_h= disable_wseqs::type_id::create("dis_wseqs_h ");
   // void'(dis_wseqs_h.randomize());
   // dis_wseqs_h.start(wseqr_h);
`uvm_do_on(dis_wseqs_h,wseqr_h)

  end

  begin
    //simple_rseqs_h =ram_simple_rseqs::type_id::create("simple_rseqs_h ");
   // void'(simple_rseqs_h.randomize());
   // simple_rseqs_h.start(rseqr_h);
`uvm_do_on(simple_rseqs_h,rseqr_h)

  end
join
end
endtask

endclass
