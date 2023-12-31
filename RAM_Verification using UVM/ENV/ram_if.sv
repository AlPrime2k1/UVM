//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Scaledge Technology
// Engineer: Kirti Kumar
// 
// Module Name: ram_if
// Project Name: RAM Verification in UVM
// Description: RAM interface consisting of all the clocking blocks and task for doing initial reset.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface ram_if(input bit clk);

  logic rst;
  //write_signals
   logic wr_enb;
   logic [3:0] wr_addr;
   logic [7:0] wr_data;

//read_signals
   logic rd_enb;
   logic [3:0] rd_addr;
   logic [7:0] rd_data;
   
   clocking wdr_cb@(posedge clk);
    default input #1 output #1;
	input rst;
	output wr_enb, wr_addr, wr_data;
   endclocking
   
   clocking wmon_cb@(posedge clk);
    default input #0 output #0;
	input rst;
	input wr_enb, wr_addr, wr_data;
   endclocking
   
   clocking rdr_cb@(posedge clk);
    default input #1 output #1;
	input rst;
	output rd_enb, rd_addr;
   endclocking
   
   clocking rmon_cb@(posedge clk);
    default input #0 output #0 ;
	input rst;
	input rd_enb, rd_addr, rd_data;
   endclocking
   
  // modport WDR_MP (clocking wdr_cb);
   
   modport WMON_MP (clocking wmon_cb);
   
  // modport RDR_MP (clocking rdr_cb);
   
   modport RMON_MP (clocking rmon_cb);

   task init_reset(int delay=20);
	 rst=1;
     #delay;
     rst=0;
	 $display("XXXXXXXXXXXXXXXXX Initial reset done XXXXXXXXXXXXXXXXXXXXX\n");
   endtask : init_reset

endinterface
