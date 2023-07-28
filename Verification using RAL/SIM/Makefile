# To compile and simulate in command prompt
cmd:
	vlib work
	vlog ../RTL/ral_registers.sv ../TEST/ral_pkg.sv ../TOP/ral_top.sv +incdir+../ENV/env +incdir+../ENV/register_files +incdir+../TEST
	vsim -novopt top -c -do "run -all;exit"

# To compile and simuate using QuestaSIM GUI
# Additionally do file is provided as well
gui:
	vlib work
	vlog ../RTL/ral_registers.sv ../TEST/ral_pkg.sv ../TOP/ral_top.sv +incdir+../ENV/env +incdir+../ENV/register_files +incdir+../TEST
	vsim -novopt top 

# To make work directory
lib:
	vlib work

# To compile
log:
	vlog ../RTL/ral_registers.sv ../TEST/ral_pkg.sv ../TOP/ral_top.sv +incdir+../ENV/env +incdir+../ENV/register_files +incdir+../TEST

# To simulate in cmd
sim:
	vsim -novopt top -c -do "run -all;exit"
