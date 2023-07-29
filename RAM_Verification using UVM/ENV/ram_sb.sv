//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: ram_sb
// Project Name: RAM Verification in UVM
// Description: Scoreboard to collect and compare actual and expected transaction values and display results. 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`uvm_analysis_imp_decl(_wr_mon)
`uvm_analysis_imp_decl(_rd_mon)

class ram_sb extends uvm_scoreboard;

`uvm_component_utils(ram_sb)									// factory registration

																// transaction class handle
ram_wtrans wtrans_exp;
ram_rtrans rtrans_exp;

// analysis port
uvm_analysis_imp_wr_mon #(ram_wtrans, ram_sb) wr_imp;			// port declaration
uvm_analysis_imp_rd_mon #(ram_rtrans, ram_sb) rd_imp;

ram_wtrans wr_q[$];
ram_rtrans rd_q[$];												// queue array declaration

bit [7:0] mem[int];												// Memory for reference model

function new (string name = "ram_sb" , uvm_component parent=null );			// function new
     super.new(name , parent);
	 wr_imp = new("wr_imp" , this);
	 rd_imp = new("rd_imp" , this);
	// wtrans_exp=new("wtrans_exp");
	// rtrans_exp=new("rtrans_exp");
	 //ram_dyn= new[`DEPTH];
endfunction
 


																	// write method for write monitor
function void write_wr_mon(ram_wtrans wtrans_exp );				
    `uvm_info("WR SB","WR SB",UVM_LOW);								// printing the received data then pushing into queue
    wtrans_exp.print();
	wr_q.push_back(wtrans_exp);
endfunction

																	// write method for read monitor 
virtual function void write_rd_mon(ram_rtrans rtrans_exp );
    `uvm_info("RD SB","RD SB",UVM_LOW);
    rtrans_exp.print();												// printing the received data then pushing into queue
    rd_q.push_back(rtrans_exp);

endfunction

task run_phase(uvm_phase phase);									// run phase

	forever begin
		wait(wr_q.size()>0);										// assigning queue items to transaction handle
		  wtrans_exp=wr_q.pop_back();
		  rtrans_exp=rd_q.pop_back();
///////////////////////////////////////////////////////////////////////////////
		if(wtrans_exp.wr_enb)										// Write operation reference model logic
		begin
			mem[wtrans_exp.wr_addr]=wtrans_exp.wr_data;	
		    `uvm_info("SB",$sformatf("MEMORY=%p\n",mem),UVM_LOW);	// Displaying ref model memory

		end		

		if (rtrans_exp.rd_enb) 										// Read operation ref model logic
		begin
			if ( mem[rtrans_exp.rd_addr]== rtrans_exp.rd_data) 
			begin
				`uvm_info("SB",$sformatf("-=-=--= PASS --=-=-=-= MEM_data=%p at ADDR=%0d\tRD DATA=%p",mem[rtrans_exp.rd_addr],rtrans_exp.rd_addr,rtrans_exp.rd_data),UVM_LOW);
			end

			else
			begin

				`uvm_error("SB",$sformatf("XXXXXX FAIL XXXXXXXXX MEM_data=%p at ADDR=%0d\texp_data = %p",mem[rtrans_exp.rd_addr],rtrans_exp.rd_addr,rtrans_exp.rd_data ));
				`uvm_info("SB",$sformatf("MEMORY=%p\n",mem),UVM_LOW);
			end
		end
/////////////////////////////////////////////////////////////////////////////////
	end
endtask : run_phase


endclass
