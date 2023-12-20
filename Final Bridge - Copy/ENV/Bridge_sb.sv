`uvm_analysis_imp_decl(_apb)
`uvm_analysis_imp_decl(_i2c)

class Bridge_sb extends uvm_scoreboard; 
	`uvm_component_utils(Bridge_sb) 

	uvm_analysis_imp_apb #(APB_trans,Bridge_sb) apb_imp;
	uvm_analysis_imp_i2c #(I2C_trans,Bridge_sb) i2c_imp;

	APB_trans apb_q[$];
	I2C_trans i2c_q[$];

	APB_trans apb_tx,apb_cp;
	I2C_trans i2c_tx;
	
bit [7:0] mem [0:7];
bit [2:0] wr_pt,rd_pt;
bit flag;
bit [7:0] readout;

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	covergroup apb_cvg;
		PSEL : coverpoint apb_cp.psel{
		  bins hi={1};
		  bins lo={0};
	  }
		PWRITE : coverpoint apb_cp.pwrite{
		  bins hi={1};
		  bins lo={0};
	  }
		PREADY : coverpoint apb_cp.pready{
		  bins hi={1};
		  bins lo={0};
	  }
		PENABLE : coverpoint apb_cp.penable{
		  bins hi={1};
		  bins lo={0};
	  }
		PRESET : coverpoint apb_cp.preset{
		  bins hi={1};
		  bins lo={0};
	  }
	  	PWDATA : coverpoint apb_cp.pwdata_in{
		  bins lo={[8'd1:8'd90]};
		  bins mid={[8'd91:8'd190]};
		  bins hi={[8'd191:8'd255]};
	  }
	  	PRDATA : coverpoint apb_cp.prdata_out{
		  bins lo={[8'd1:8'd90]};
		  bins mid={[8'd91:8'd190]};
		  bins hi={[8'd191:8'd255]};
	  }
	  	PRESET_t : coverpoint apb_cp.preset{
		  bins lohi=(0=>1);
			bins hilo=(1=>0);
	  }
			PSEL_t : coverpoint apb_cp.psel{
			bins lohi=(0=>1);
			bins hilo=(1=>0);
		}

	  	PSELxPENABLE : cross PSEL,PENABLE{
	  	  ignore_bins ok=binsof(PSEL) intersect {0} && binsof(PENABLE) intersect {1};		// Ignoring PSEL 0 and PENABLE 1
	  }
		PSELxPENABLExPREADY: cross PSEL,PENABLE,PREADY{
		  ignore_bins low=binsof(PSEL.lo);
	  }
	endgroup

	covergroup i2c_cvg;
		HEADER : coverpoint i2c_tx.header{
		  bins ok={'d203};
	  }
		REC : coverpoint i2c_tx.rec_data{
		  bins lo={['d0:'d90]};
		  bins mid={['d91:'d190]};
		  bins hi={['d191:'d255]};
	  }
	endgroup
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	function new(string name="Bridge_sb",uvm_component parent); 
    super.new(name,parent);
		apb_imp=new("apb_imp",this);
		i2c_imp=new("i2c_imp",this);
		apb_cvg=new();
		i2c_cvg=new();
  endfunction
	
	function void write_apb(APB_trans trans_h);
 
		if(trans_h.psel && trans_h.pready && trans_h.penable )
		begin
	  	if(trans_h.preset)
	  	begin
	    	`uvm_info("APB WRITE METHOD",$sformatf("TX APB REC in SB : %0d",trans_h.pwdata_in),UVM_LOW)
				if(trans_h.pwrite)
				begin
					mem[wr_pt]=trans_h.pwdata_in;
					wr_pt++;
					`uvm_info("APB WRITE CYCLE",$sformatf("\\\\\\\\\\\\\\\\\\\\\\\\\\\MEMORY : %0p\t\t\tWR_PT=%0d\tRD_PT=%0d",mem,wr_pt,rd_pt),UVM_LOW)
	  		end
  		end
	  	else					// not preset
	  	begin
				wr_pt=0;
				rd_pt=0;
				for(int i=0;i<8;i++)
		  		mem[i]=0;
	  	end

		end
		apb_cp=new trans_h;
		apb_cvg.sample();
		flag=trans_h.preset;
	endfunction

	function void write_i2c(I2C_trans trans_h);
	  `uvm_info("I2C WRITE METHOD",$sformatf("TX I2C REC in SB : %0d",trans_h.rec_data),UVM_LOW)
	  i2c_q.push_back(trans_h);
	endfunction

	task run_phase(uvm_phase phase);
	  forever 
	  begin
	  	wait(i2c_q.size()>0);
	 		i2c_tx=i2c_q.pop_front();
	  	i2c_cvg.sample();

			if(mem[rd_pt]==i2c_tx.rec_data )
		  	`uvm_info("PASS",$sformatf("__ PASSED SUCCESSFULLY __ \n\n\t\t MEM : %p\t\tI2C_tx : %0d\n\t\tWR=%0d\t\tRD=%0d",mem,i2c_tx.rec_data,wr_pt,rd_pt),UVM_LOW)
			else
		  	`uvm_error("FAIL",$sformatf("__ FAILED MISERABLY __ \n\n\t\t MEM : %p\t\tI2C_tx : %0d\n\t\tWR=%0d\t\tRD=%0d",mem,i2c_tx.rec_data,wr_pt,rd_pt))
	  
			if(flag)
				rd_pt++;
	  end
	endtask
endclass
