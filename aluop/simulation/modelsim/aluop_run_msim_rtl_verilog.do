transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/aluop {C:/Users/admin/Desktop/Quartus/aluop/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/aluop {C:/Users/admin/Desktop/Quartus/aluop/ALU_TB.v}

