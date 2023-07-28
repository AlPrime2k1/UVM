// DUT having multiple registers.

module ral_register
  #( parameter ADDR_WIDTH = 32,
     parameter DATA_WIDTH = 32 ) 
  (
    input clk,
    input reset,
    //control signals
    input [ADDR_WIDTH-1:0]  addr,
    input                   wr_en,    // 1 for write 0 for read
    
    //data signals
    input  [DATA_WIDTH-1:0] wdata,
    output [DATA_WIDTH-1:0] rdata
  ); 
  
  logic [DATA_WIDTH-1:0] t_data;
  
  reg [DATA_WIDTH-1:0] status;
  reg [DATA_WIDTH-1:0] control;
  reg [DATA_WIDTH-1:0] io_address;
  reg [DATA_WIDTH-1:0] mem_address;
  
  //Reset 
  always @(posedge reset) begin
    status      <= 0;
    control     <= 0;
    io_address  <= 0;
    mem_address <= 0;
  end

  assign rdata = t_data;

  always @(posedge clk) begin
    if (wr_en) begin
           if (addr == 32'h400) status      <= wdata;
      else if (addr == 32'h404) control     <= wdata;
      else if (addr == 32'h408) io_address  <= wdata;
      else if (addr == 32'h40C) mem_address <= wdata;
      $display($time,"--> Design WRITE OP\t\tADDR : %0h\tData : %0h",addr,wdata);
    end
    else if (!wr_en) begin
           if (addr == 32'h400) t_data = status       ;
      else if (addr == 32'h404) t_data = control      ;
      else if (addr == 32'h408) t_data = io_address   ;
      else if (addr == 32'h40C) t_data = mem_address  ;
      $display($time,"\tDesign READ OP\t\tADDR : %0h\tData : %0h\n",addr,t_data);
    end
  end  

endmodule