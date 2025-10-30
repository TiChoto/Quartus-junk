transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/encoder8to3 {C:/Users/admin/Desktop/Quartus/encoder8to3/encoder_8to3.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/encoder8to3 {C:/Users/admin/Desktop/Quartus/encoder8to3/encoder_8to3_tb.v}

