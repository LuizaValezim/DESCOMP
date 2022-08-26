onerror {exit -code 1}
vlib work
vcom -work work Aula2.vho
vcom -work work Waveform2.vwf.vht
vsim  -c -t 1ps -L cyclonev -L altera -L altera_mf -L 220model -L sgate -L altera_lnsim work.Aula2_vhd_vec_tst
vcd file -direction Aula2.msim.vcd
vcd add -internal Aula2_vhd_vec_tst/*
vcd add -internal Aula2_vhd_vec_tst/i1/*
proc simTimestamp {} {
    echo "Simulation time: $::now ps"
    if { [string equal running [runStatus]] } {
        after 2500 simTimestamp
    }
}
after 2500 simTimestamp
run -all
quit -f
