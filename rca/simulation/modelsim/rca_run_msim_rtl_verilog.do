transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/rca {C:/Users/admin/Desktop/Quartus/rca/full_adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/rca {C:/Users/admin/Desktop/Quartus/rca/rca_8bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/rca {C:/Users/admin/Desktop/Quartus/rca/rca_8bit_tb.v}

