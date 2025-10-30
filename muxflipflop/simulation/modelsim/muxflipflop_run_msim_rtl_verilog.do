transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/muxflipflop {C:/Users/admin/Desktop/Quartus/muxflipflop/mux_dff.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/muxflipflop {C:/Users/admin/Desktop/Quartus/muxflipflop/muxdff_tb.v}

