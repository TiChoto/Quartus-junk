transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/sequential_processor {C:/Users/admin/Desktop/sequential_processor/d_flipflop.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/sequential_processor {C:/Users/admin/Desktop/sequential_processor/shift_register.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/sequential_processor {C:/Users/admin/Desktop/sequential_processor/tb_shiftregister.v}

