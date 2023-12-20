// Parameter Declarations
`define address 7'd101 // i2c address size

`define ADD_W  8   // for apb
`define DATA_W 8 

// FIFO constants
`define DATA_WIDTH  8
`define ADDR_WIDTH  3
`define DEPTH  2**(`ADDR_WIDTH)-1
/*
`include "apb_slave.sv"
`include "i2c_slave.sv"
*/
module dsgn (
                    input wire scl ,
                    inout wire sda ,
//                    input  wire [7:0] data_wr ,
//                    output wire [7:0] data_rd ,          // For Master to Slave Data

                    input wire psel,                       //select slave device 
                    input wire penable,                    //enable slave device
                    input wire [`ADD_W-1:0] paddr,          //address bus
                    input wire pwrite,                     //control sig : 1 = write operation , 0 = read operation
                    input wire preset,                     //active low reset
                    input wire pclk,                       //system clock
//                    input wire [DATA_W-1:0] prdata_in,     //peripheral to APB slave input bus
                    input wire [`DATA_W-1:0] pwdata_in,     //APB bridge to APB slave input bus

                    output wire [`DATA_W-1:0] prdata_out,   //APB slave to APB bridge output bus
//                    output wire [DATA_W-1:0] pwdata_out,   //APB slave to peripheral output bus
                    output wire pready                     //whether slave is ready for accepting input from either APB bridge or peripheral during write or read operation
) ;

  logic [`DATA_W-1:0] temp_prdata_in  ;
  //logic [`DATA_W-1:0] pwdata_out ;
  logic [7:0] data_wr ;
  logic [7:0] data_rd ;

  reg [`ADDR_WIDTH:0] wr_pointer ;
  reg [`ADDR_WIDTH:0] rd_pointer ;
  reg [`DATA_WIDTH-1:0] mem [0:`DEPTH] ;

	//assign prdata_out=temp_prdata_in;

  apb_slave apb_slv_inst (
                          .psel        (psel       ),
                          .penable     (penable    ),
                          .paddr       (paddr      ),
                          .pwrite      (pwrite     ),
                          .preset      (preset     ),
                          .pclk        (pclk       ),
                         // .pwdata_out  (pwdata_out ), //OP
                          .prdata_out  (prdata_out ), //OP
                          .pready      (pready     ), //OP
                         // .prdata_in   (prdata_in  ),
                          .pwdata_in   (pwdata_in  )
                          ) ;

  i2c_slave i2c_slv_inst (
                          .sda      (sda     ),
                          .scl      (scl     ),
                          .data_wr  (data_wr ), 
                          .data_rd  (data_rd )    // OP
                          ) ;

  always @(negedge preset) 
  begin
    rd_pointer = 0 ;
    wr_pointer = 0 ;
		//temp_prdata_in = 0;
	for(int i=0;i<8;i++)
	  mem[i]=0;
  end

  always @(posedge sda, negedge preset) begin
    if(!preset) begin
      rd_pointer = 0 ;
      wr_pointer = 0 ;
			//temp_prdata_in = 0 ;
	  for(int i=0;i<8;i++)
		mem[i]=0;
    end  
    else if(scl) begin
	  //if(preset)
      rd_pointer++ ;
    end
  end

  always @(pwdata_in) begin  
	if(psel)
	begin
	  mem[wr_pointer[2:0]] = pwdata_in ; 
    wr_pointer++;
  	end
  end

  assign data_wr = mem[rd_pointer[2:0]] ;

endmodule
