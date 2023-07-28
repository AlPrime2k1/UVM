vlib work
vlog ../RTL/ral_registers.sv ../TEST/ral_pkg.sv ../TOP/ral_top.sv +incdir+../ENV/env +incdir+../ENV/register_files +incdir+../TEST
vsim -novopt top
