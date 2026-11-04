IVERILOG ?= iverilog
VVP ?= vvp
YOSYS ?= yosys
.PHONY: test synth clean
test:
	mkdir -p build
	$(IVERILOG) -g2012 -Wall -s tb_line_directory2 -o build/sim rtl/line_directory2.sv tb/tb_line_directory2.sv
	$(VVP) build/sim
synth:
	mkdir -p build
	$(YOSYS) -Q -T -l build/synthesis.log -p 'read_verilog -sv rtl/line_directory2.sv; hierarchy -check -top line_directory2; synth -top line_directory2; stat'
clean:
	rm -f build/sim
