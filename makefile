all:
		make clear;make compile;make simulate

compile:
		vlib work;
			vlog -sv testbench.sv

simulate:
	vsim testbench -l coverage.log -coverage -c -do "run -all;quit;"
	-wlf $(test_folder)/waveform.wlf


clear:
		clear
