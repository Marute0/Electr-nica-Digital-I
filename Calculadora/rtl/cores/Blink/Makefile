TOP = topMod
TB = topMod_TB
OBJS = topMod.v \
       blinking.v 


ECP5_SIM_CELLS := $(shell yosys-config --datdir)/ecp5/cells_sim.v

sim:
	rm -f a.out *.vcd
	iverilog -DBENCH $(TB).v $(OBJS)
	vvp a.out
	gtkwave $(TB).vcd

sim_post_syn:
	yosys -v3 -l synth.log -p "read_verilog $(OBJS); synth_ecp5 -top $(TOP) -json $(TOP).json; write_verilog -noattr $(TOP)_synth.v"
	iverilog $(TB).v $(TOP)_synth.v $(ECP5_SIM_CELLS)
	vvp a.out
	gtkwave $(TB).vcd

svg:
	rm -rf *.svg *.out *.dot *.json
	yosys -p "read_verilog $(OBJS); prep -top $(TOP); memory_map; opt; opt_expr; techmap; abc -g AND,OR,XOR; write_json $(TOP).json"
	netlistsvg $(TOP).json -o $(TOP).svg

clean:
	rm -rf *.svg *.out *.dot a.out *.vcd *.json $(TOP)_synth.v *.log
	