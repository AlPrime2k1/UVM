COV = -coveropt 3 +cover +acc
RTL = ../RTL/apb_slave.sv ../RTL/i2c_slave.sv ../RTL/dsgn.sv
ASR = ../ENV/Bridge_assertion.sv
PKG = ../TEST/Bridge_pkg.sv
TOP = ../TOP/Bridge_top.sv
INCDIR = +incdir+../ENV/APB +incdir+../ENV/I2C +incdir+../ENV +incdir+../TEST +incdir+../TEST/CALLBACK_TEST +incdir+../TEST/SANITY_TEST +incdir+../TEST/BACK_TO_BACK_TEST +incdir+../TEST/SIMULTANEOUS_TEST +incdir+../TEST/APB_READ_TEST +incdir+../TEST/APB_NO_PSEL_TEST +incdir+../TEST/APB_NO_PRESET_TEST +incdir+../TEST/APB_WRITE_READ_TEST
CMD_TOP = -coverage -vopt Bridge_top -c -do 
GUI_TOP = Bridge_top
MERGE = snt.ucdb b2b.ucdb sim.ucdb rd.ucdb npsel.ucdb nprst.ucdb wtr.ucdb err.ucdb
HTML = report -html -htmldir MERGED_Report MERGED.ucdb


cli:
	vlog $(COV) $(RTL) $(ASR) $(PKG) $(TOP) $(INCDIR)
	vsim -assertdebug $(CMD_TOP) "coverage save -onexit -directive -cvg -codeAll snt.ucdb;run -all" +UVM_TESTNAME=sanity_test
	vsim -assertdebug $(CMD_TOP) "coverage save -onexit -directive -cvg -codeAll b2b.ucdb;run -all" +UVM_TESTNAME=back_to_back_test
	vsim -assertdebug $(CMD_TOP) "coverage save -onexit -directive -cvg -codeAll sim.ucdb;run -all" +UVM_TESTNAME=simultaneous_test
	vsim -assertdebug $(CMD_TOP) "coverage save -onexit -directive -cvg -codeAll rd.ucdb;run -all" +UVM_TESTNAME=read_test
	vsim -assertdebug $(CMD_TOP) "coverage save -onexit -directive -cvg -codeAll npsel.ucdb;run -all" +UVM_TESTNAME=no_psel_test
	vsim -assertdebug $(CMD_TOP) "coverage save -onexit -directive -cvg -codeAll nprst.ucdb;run -all" +UVM_TESTNAME=no_preset_test
	vsim -assertdebug $(CMD_TOP) "coverage save -onexit -directive -cvg -codeAll wtr.ucdb;run -all" +UVM_TESTNAME=write_read_test
	vsim -assertdebug $(CMD_TOP) "coverage save -onexit -directive -cvg -codeAll err.ucdb;run -all" +UVM_TESTNAME=callback_test
	vcover merge MERGED.ucdb $(MERGE)
	vcover $(HTML)

sanity_gui:
	vlog $(COV) $(RTL) $(ASR) $(PKG) $(TOP) $(INCDIR)
	vsim -assertdebug Bridge_top +UVM_TESTNAME=sanity_test

b2b_gui:
	vlog $(COV) $(RTL) $(ASR) $(PKG) $(TOP) $(INCDIR)
	vsim  -assertdebug $(GUI_TOP) +UVM_TESTNAME=back_to_back_test

sim_gui:
	vlog $(COV) $(RTL) $(ASR) $(PKG) $(TOP) $(INCDIR)
	vsim  -assertdebug $(GUI_TOP) +UVM_TESTNAME=simultaneous_test

read_gui:
	vlog $(COV) $(RTL) $(ASR) $(PKG) $(TOP) $(INCDIR)
	vsim  -assertdebug $(GUI_TOP) +UVM_TESTNAME=read_test

no_psel_gui:
	vlog $(COV) $(RTL) $(ASR) $(PKG) $(TOP) $(INCDIR)
	vsim  -assertdebug $(GUI_TOP) +UVM_TESTNAME=no_psel_test

no_preset_gui:
	vlog $(COV) $(RTL) $(ASR) $(PKG) $(TOP) $(INCDIR)
	vsim -assertdebug $(GUI_TOP) +UVM_TESTNAME=no_preset_test

wtr_gui:
	vlog $(COV) $(RTL) $(ASR) $(PKG) $(TOP) $(INCDIR)
	vsim  -assertdebug $(GUI_TOP) +UVM_TESTNAME=write_read_test

data_error_gui:
	vlog $(COV) $(RTL) $(ASR) $(PKG) $(TOP) $(INCDIR)
	vsim  -assertdebug $(GUI_TOP) +UVM_TESTNAME=callback_test




test:
	vlog $(COV) $(RTL) $(ASR) $(PKG) $(TOP) $(INCDIR)
	vsim -assertdebug $(CMD_TOP) "coverage save -onexit -directive -cvg -codeAll test.ucdb;run -all" +UVM_TESTNAME=simultaneous_test

test_gui:
	vlog $(COV) $(RTL) $(ASR) $(PKG) $(TOP) $(INCDIR)
	vsim $(GUI_TOP) +UVM_TESTNAME=simultaneous_test

testing_cli:
	vlog $(COV) $(RTL) $(PKG) $(TOP) $(INCDIR)
	vsim $(CMD_TOP) "coverage save -onexit -directive -cvg -codeAll nnn.ucdb;run -all" +UVM_TESTNAME=no_psel_test
	vsim $(CMD_TOP) "coverage save -onexit -directive -cvg -codeAll ooo.ucdb;run -all" +UVM_TESTnAME=write_read_test
	vcover merge NIG.ucdb nnn.ucdb ooo.ucdb
	vcover remove nnn.ucdb ooo.ucdb 
	vcover report -html -htmldir GER NIG.ucdb

testing_gui:
	vlog $(COV) $(RTL) $(PKG) $(TOP) $(INCDIR)
	vsim $(GUI_TOP) +UVM_TESTNAME=no_psel_test



