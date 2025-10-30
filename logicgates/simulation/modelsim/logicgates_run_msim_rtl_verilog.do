transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/logicgates {C:/Users/admin/Desktop/Quartus/logicgates/logicgatestb.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/logicgates/output_files {C:/Users/admin/Desktop/Quartus/logicgates/output_files/nand_gate.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/logicgates/output_files {C:/Users/admin/Desktop/Quartus/logicgates/output_files/nor_gate.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/logicgates/output_files {C:/Users/admin/Desktop/Quartus/logicgates/output_files/xnor_gate.v}

