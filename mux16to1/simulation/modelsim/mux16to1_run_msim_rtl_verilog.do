transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/mux16to1 {C:/Users/admin/Desktop/Quartus/mux16to1/mux_16to1.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/mux16to1 {C:/Users/admin/Desktop/Quartus/mux16to1/mux_16to1_tb.v}

