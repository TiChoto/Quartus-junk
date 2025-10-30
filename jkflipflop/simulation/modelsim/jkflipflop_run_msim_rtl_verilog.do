transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/jkflipflop {C:/Users/admin/Desktop/Quartus/jkflipflop/jk_flipflop.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/jkflipflop {C:/Users/admin/Desktop/Quartus/jkflipflop/jk_flipflop_tb.v}

