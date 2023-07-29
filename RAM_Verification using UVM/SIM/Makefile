vlog:
	vlog ../RTL/ram_16x8.v ../TEST/ram_pkg.sv ../TOP/ram_top.sv +incdir+../ENV +incdir+../TEST 


vsim:	
	vsim -novopt ram_top -c -do "run;exit" 


normal:
	vlog ../RTL/ram_16x8.v ../TEST/ram_pkg.sv ../TOP/ram_top.sv +incdir+../ENV +incdir+../TEST
	vsim -novopt ram_top -c -do "run -all;exit" +UVM_TESTNAME=normal_write_read_test 


b2b:
	vlog ../RTL/ram_16x8.v ../TEST/ram_pkg.sv ../TOP/ram_top.sv +incdir+../ENV +incdir+../TEST
	vsim ram_top -c -do "run -all" +UVM_TESTNAME=back_to_back_test -sv_seed 8888


simwr:
	vlog ../RTL/ram_16x8.v ../TEST/ram_pkg.sv ../TOP/ram_top.sv +incdir+../ENV +incdir+../TEST
	vsim ram_top -c -do "run -all;exit" +UVM_TESTNAME=sim_write_read_test -sv_seed 2145


all:
	vlog ../RTL/ram_16x8.v ../TEST/ram_pkg.sv ../TOP/ram_top.sv +incdir+../ENV +incdir+../TEST 

	vsim -novopt ram_top -c -do "run -all;exit" +UVM_TESTNAME=normal_write_read_test 
	vsim ram_top -c -do "run -all" +UVM_TESTNAME=back_to_back_test -sv_seed 8888
	vsim -novopt ram_top -c -do "run -all;exit" +UVM_TESTNAME=sim_write_read_test -sv_seed 2145