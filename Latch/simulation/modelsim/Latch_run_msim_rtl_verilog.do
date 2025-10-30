transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/Latch {C:/Users/admin/Desktop/Quartus/Latch/latch_free_alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/Latch {C:/Users/admin/Desktop/Quartus/Latch/latch_free_testbench.v}

