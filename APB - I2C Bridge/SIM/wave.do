onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Bridge_top/inf/pclk
add wave -noupdate /Bridge_top/inf/scl
add wave -noupdate /Bridge_top/inf/preset
add wave -noupdate /Bridge_top/inf/pwrite
add wave -noupdate /Bridge_top/inf/psel
add wave -noupdate /Bridge_top/inf/penable
add wave -noupdate /Bridge_top/inf/pready
add wave -noupdate /Bridge_top/inf/paddr
add wave -noupdate /Bridge_top/inf/pwdata_in
add wave -noupdate /Bridge_top/inf/prdata_out
add wave -noupdate /Bridge_top/inf/sda
add wave -noupdate /Bridge_top/inf/sda_out
add wave -noupdate /Bridge_top/DUT/wr_pointer
add wave -noupdate /Bridge_top/DUT/rd_pointer
add wave -noupdate /Bridge_top/DUT/mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1 us}
