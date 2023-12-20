interface Bridge_inf(input bit pclk,scl);
  logic preset,pwrite,psel,penable,pready;
  logic [7:0] paddr;
  logic [7:0] pwdata_in;
  logic [7:0] prdata_out;
  wire sda;
  logic sda_out='bz;
  logic [7:0] header;
  logic slv_sel;
  assign sda=sda_out;

	task initial_reset(input int a=20);
		preset=0;
		#a;
		preset=1;
		$display("INITIAL RESET DONE SUCCESSFULLY");
	endtask

//task intermediate_reset(input )

endinterface
