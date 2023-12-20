//module : apb_slave();
//description :  APB slave is designed according to FSM described by ARM in version 3. Input condition is generated in apb_test using dummy APB master module.
//     pready signal indicate whether pslave is busy or not, and this signal is made in random manner. Detail regarding APB slave is given in ./spec. 

//**********************************************************************************************************************************************************

module apb_slave(psel,penable,paddr,pwrite,preset,pclk,prdata_out,pready,pwdata_in);

parameter DATA_W=8,ADD_W=8;

//input entities
input psel;   //select slave device 
input penable;    //enable slave device
input [ADD_W-1:0] paddr;  //address bus
input pwrite;   //control sig : 1 = write operation , 0 = read operation
input preset;   //active low reset
input pclk;   //system clock
//input [DATA_W-1:0] prdata_in; //peripheral to APB slave input bus
input [DATA_W-1:0] pwdata_in; //APB bridge to APB slave input bus

//output entities
output reg [DATA_W-1:0] prdata_out; //APB slave to peripheral output bus
//output  reg [DATA_W-1:0] pwdata_out;  //APB slave to APB bridge output bus
output reg pready;    //whether slave is ready for accepting input from either APB bridge or peripheral during write or read operation

//parameter declaration
parameter idle = 2'b00;   //idle state : during power reset
parameter setup = 2'b10;  //{psel,penable} = 2'b10 => setup mode
parameter enable = 2'b11; //{psel,penable} = 2'b11 => enable mode
parameter [ADD_W-1:0] slave_id = {32{1'b1}};    // slave id => when paddr match with slave id, then corresponding APB slave is activated

// intetrmediate entities
reg [1:0] state,nxt_state;  
reg [6:0] rnd_num;  //random number
reg wait_sig;   //wait signal, this sig is linked with randomizer and used to produce pready sig in random manner
reg write,read;   //

reg [7:0] mem [0:7];
bit [3:0] wr_pt=0,rd_pt=0;

//code:
initial     //initial condition
begin
  rnd_num = 7'b1101011;
  wait_sig = 1'b1;
end

always @(posedge pclk, negedge preset)    //state logic
begin
  if(!preset)
  begin
    state <= idle;
	wr_pt<=0;
	rd_pt<=0;
	prdata_out<=0;
	for (int i=0;i<8;i++)
	  mem[i]=0;
  end

  else if (paddr == slave_id)
    state <= nxt_state;

  else
    state <= idle;
end

always @(state, psel,penable,paddr,pwrite,pwdata_in,pready) //next state and output logic
begin
  if(paddr ==slave_id)
  begin
  
  case ({psel,penable})
  
  idle :
  begin
    //pwdata_out[DATA_W-1:0] = pwdata_out[DATA_W-1:0];
    prdata_out[DATA_W-1:0] = prdata_out[DATA_W-1:0];
    nxt_state = idle;
  end

  setup:
  begin
   // pwdata_out[DATA_W-1:0] = pwdata_out[DATA_W-1:0];
    prdata_out[DATA_W-1:0] = prdata_out[DATA_W-1:0];
    nxt_state = idle;
  end

  enable:
  begin
    if(pwrite == 1'b0 && pready == 1'b1)    				//read operation for APB slave
    begin  
      //$display("YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY");
      prdata_out = mem[rd_pt[2:0]];
	  rd_pt++;
    end
    
    else if(pwrite == 1'b1 && pready == 1'b1) 				//write operation for APB slave
    begin  
      //prdata_out = pwdata_in;
	  mem[wr_pt[2:0]]= pwdata_in;
	  wr_pt++;
    end
    nxt_state = enable;
  end
  

  endcase

  end
  else
    nxt_state = idle;

end

always @(posedge (pclk & psel & penable)) //generating wait sig in random manner
begin

  rnd_num = {rnd_num[5:0] , rnd_num[5]^rnd_num[6]};			// Bitwise OR to increase the chances of pready high
  wait_sig = rnd_num[0];

end

always @(posedge pclk)    //generating pready sig in random manner
begin
  if(psel == 1'b1 & penable == 1'b0)
    pready <= 1'b0;

  else if (psel == 1'b1 & penable == 1'b1 & wait_sig == 1'b1)
  begin
    pready <= 1'b0;
  end

  else if (psel == 1'b1 & penable == 1'b1 & wait_sig == 1'b0)
  begin
    pready <= 1'b1;
  end
  
  else
  begin
    pready <= 1'b0;
  end
end

endmodule

