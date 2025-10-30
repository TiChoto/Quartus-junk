transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/mux4to1 {C:/Users/admin/Desktop/Quartus/mux4to1/mux4to1.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/mux4to1 {C:/Users/admin/Desktop/Quartus/mux4to1/mux4to1_tb.v}

