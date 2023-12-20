module Mux_2_1 (op, a, b, s);
	// Output Ports
	output reg op;
	// Input Ports
	input a, b, s;
	// Code
	always @ (s, a, b)
	begin
		case (s)
		1'b0:	op<=a;
		1'b1:	op<=b;
		default: op=1'bz;
		endcase	
	end
endmodule

// File - 1 to 2 Demux
// Description - if s=0 then input goes in op[0], else op[1].
module Demux_1_2 (op, ip, s);
	//  Port Declaration
	input ip, s;
	output [1:0] op;
	// Wires and Registers
	reg [1:0] op;
	// Code
	always @(ip or op or s)
	if (s==0) begin
		op[0]=ip;
		op[1]=1'bz;
	end else begin
		op[0]=1'bz;
		op[1]=ip;
	end
endmodule

// File - I2C Slave Communication Protocol
// Specifications - 7 bit Address

module i2c_slave (sda, scl, data_wr, data_rd);
	/* Logic - 
	comm_start = 1 means communication is currently going on with any of the slaves.
	address_check = 00 means address is not checked yet, 
	                01 means address is checked, but communication was not for this slave.
					11 means address is checked and communication was for this slave.
	rec_byte = stores received byte.
	trans_byte = stores bytes to be transmitted.
	loc = counter to store received bits (addr).
	read_write =  0 means the master will write to the slave device. 
		     	  1 means the master will read from slave device.
	tmp_read_write = Stores temporary value for read_write for 1 cycle.			  
	byte_complete = 1 means transmission or reception of a byte is completed.
	trans_reg_out = Bit out of transmission register
	trans_out = Final bit out to sda.
	ack_trans = Acknowledgement to be transmitted.
	rec_reg_in = Bit in for reception register
	rec_in = Initial bit in from sda.
	ack_rec = Acknowledgement to be received.
	tmp_byte_complete = Temporary byte complete to wait for proper clock edges.
	just_started = Communication just started. Valid only for 1st data tranmission for read operation.
	tmp_ack_rec = Temporary acknowledgement bit, which stored the previous transaction acknowledgement. 
	*/

	// Port Declarations
	inout sda;
	input scl;
	output reg [7:0] data_rd; // For Master to Slave Data
	input [7:0] data_wr;	  // For Slave to Master Data
	
	// Regs & Wires
//	reg comm_start, read_write, byte_complete, trans_reg_out, ack_trans, tmp_byte_complete, tmp_read_write, just_started, tmp_ack_rec;
	reg comm_start, trans_reg_out, ack_trans, tmp_byte_complete, tmp_read_write, just_started, tmp_ack_rec;
	bit read_write, byte_complete;
	wire trans_out, ack_rec, rec_reg_in, rec_in;
	reg [1:0] address_check;
	reg [7:0] rec_byte, trans_byte;
	reg [2:0] loc;
	
	parameter address=7'd101;

	Mux_2_1 m1 (trans_out, trans_reg_out, ack_trans, byte_complete);	// op,a,b,s	 => !s->a s->b
	Demux_1_2 d1 ({ack_rec, rec_reg_in}, rec_in, byte_complete);		// op,in,s   => !s->op[0] s->op[1]
	bufif1(sda, trans_out, ((read_write ^ byte_complete) & (address_check[0] & address_check[1])));		// op,in,ctrl
	bufif0(rec_in, sda, (read_write ^ byte_complete));													// op,in,!ctrl
	
	// Codes
	// Task for address received
	task address_received;
		input [7:0] rec;
      input [1:0] addr;
		output [1:0] addr_return;
		output rw;
		begin
          if (rec[7:1]==address) // If received address is the slave address then
				begin
                  $display("Correct slave chosen");
					addr_return=2'b11;
					rw=rec[0];
				end	
			else // If received address is not the slave address then
					addr_return=2'b01;
		end
	endtask
	
	// Task for byte received
	task byte_received;
		input [7:0] rec;
		begin
			data_rd=rec;
		end
	endtask
	
	// Task for byte transmitted
	task byte_transmitted;
		output [7:0] trans;
		begin
			trans=data_wr;
		end
	endtask
	
	// Detection of start of communication
	always @ (negedge sda)
	begin
		if (sda==0 && scl==1) // If clock is high and sda is pulled to low then
		begin
			comm_start=1;
			loc=7;
			address_check=2'b00;
			read_write=0;
			tmp_read_write=0;
			byte_complete=0;
			tmp_byte_complete=0;
			ack_trans=0;
			trans_byte=data_wr ;	//8'b1101_0001;
			just_started=1;
		end	
	end		
			
	// Detection of end of communication		
	always @ (posedge sda)		
	begin
		if (sda==1 && scl==1) // If clock is high and sda is pushed to high then
		begin
			comm_start=0;
			loc=7;
			address_check=2'b00;
			tmp_read_write=0;
			read_write=0;
			tmp_byte_complete=0;
			byte_complete=0;
			ack_trans=0;
		end	
	end
	
	// Data Reception
	/* sda can only be changed when scl is low & when it is high, sda should be stable. So on negative edge of clock data is transmitted, 		on positive edge it is received. After every 8 bits of data transfer, acknowledgement must be sent. Is acknowledgement = 0 then data 		is acknowledged and if 1 then not*/
	always @ (posedge scl)
	begin
		if (address_check==2'b00 && comm_start==1) // If address is not checked and communication is started then 
			begin	
				rec_byte[loc]=rec_reg_in;
				if (ack_trans!=1)
					begin
						if (rec_byte[loc]==1 || rec_byte[loc]==0) // If received bit is not damaged then
							ack_trans=0;
						else	
							ack_trans=1;
					end
				loc=loc-1;
				if (loc == 3'b111)
					begin
						tmp_byte_complete=1;
						address_received(rec_byte, address_check, address_check, tmp_read_write);
					end
			end
		else if (address_check==2'b11 && comm_start==1 && read_write==0 && byte_complete==0)
			begin	
				if (loc==3'd7)
					ack_trans=0;
				rec_byte[loc]=rec_reg_in;
				if (ack_trans!=1)
					begin
						if (rec_byte[loc]==1 || rec_byte[loc]==0) // If received bit is not damaged then
							ack_trans=0;
						else	
							ack_trans=1;
					end
				loc=loc-1;
				if (loc == 3'b111)
					begin
						tmp_byte_complete=1;
						byte_received(rec_byte);
					end	
				else 
					tmp_byte_complete=0;
			end	
	end
	
	// Data Transmission
	always @ (negedge scl)
	begin
		byte_complete=tmp_byte_complete;
		if (tmp_byte_complete==1)
			tmp_byte_complete=0;			
		else if (address_check==2'b11 && comm_start==1 && tmp_read_write==1 && just_started==1 && byte_complete==0)
			begin	
				trans_reg_out=trans_byte[loc];
				loc=loc-1;	
				if (loc == 3'b111)
					begin
						tmp_byte_complete=1;
						byte_transmitted(trans_byte);
						just_started=0;
					end	
				else
					tmp_byte_complete=0;
			end	
//		else if (address_check==2'b11 && comm_start==1 && tmp_read_write==1 && tmp_ack_rec==0 && byte_complete==0)
		else if (address_check==2'b11 && comm_start==1 && tmp_read_write==1 && tmp_ack_rec==0 && tmp_byte_complete==0)
			 begin	
				trans_reg_out=trans_byte[loc];
				loc=loc-1;	
				if (loc == 3'b111)
					begin
						tmp_byte_complete=1;
						byte_transmitted(trans_byte);
					end	
				else
					tmp_byte_complete=0;
			end	
	end
	
	always @ (negedge byte_complete)
		read_write=tmp_read_write;
	
	always @ (ack_rec)
	begin
		if(ack_rec==0 || ack_rec==1)
			tmp_ack_rec=ack_rec;
	end
endmodule
