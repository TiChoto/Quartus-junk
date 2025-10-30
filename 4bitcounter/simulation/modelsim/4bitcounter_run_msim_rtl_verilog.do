transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/4bitcounter {C:/Users/admin/Desktop/Quartus/4bitcounter/counter_4bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Desktop/Quartus/4bitcounter {C:/Users/admin/Desktop/Quartus/4bitcounter/counter_4bit_tb.v}

