transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/controlunit {C:/Users/admin/Desktop/Quartus/controlunit/controlunit.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/alu {C:/Users/admin/Desktop/Quartus/alu/alubranch.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/eregisterfile {C:/Users/admin/Desktop/Quartus/eregisterfile/eregisterfile.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/MIPSblocks {C:/Users/admin/Desktop/Quartus/MIPSblocks/instructionflow_tb.v}

