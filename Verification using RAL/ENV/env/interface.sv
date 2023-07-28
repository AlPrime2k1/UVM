// Interface file

interface ral_if(input logic clk,reset);
  
  logic [31:0] addr;
  logic        wr_en;
  logic [31:0] wdata;
  logic [31:0] rdata;

  clocking driver_cb @(posedge clk);
    default input #0 output #1;           // Clocking block for Driving
    output addr;
    output wr_en;
    output wdata;
    input  rdata;  
  endclocking
  
  clocking monitor_cb @(posedge clk);
    default input #0 output #1;           // Clocking block for Monitoring
    input addr;
    input wr_en;
    input wdata;
    input rdata;
  endclocking
  
  modport DRIVER  (clocking driver_cb);
  modport MONITOR (clocking monitor_cb);
  
endinterface