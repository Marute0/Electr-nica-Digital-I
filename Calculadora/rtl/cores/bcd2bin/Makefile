Target = bcd2bin

OBJS = comp.v \
       contador_dec.v \
       sum_comp2.v \
       lsr_A_res.v \
       bcd2bin_control.v \
       bcd2bin.v 

ECP5_SIM_CELLS=../lattice_sim/cells_sim_ecp5.v


sim:
	rm -f a.out *.vcd
	iverilog -DBENCH $(Target)_TB.v $(OBJS)
	vvp a.out
	gtkwave $(Target)_TB.vcd

sim_post_syn:
	yosys -v3 -l synth.log -p 'synth_ecp5 -top $(Target) -json $(Target).json; write_verilog -attr2comment $(Target)_synth.v' $(OBJS)
	iverilog -I ./lattice_sim $(Target)_TB.v $(Target)_synth.v $(ECP5_SIM_CELLS)
	vvp a.out
	gtkwave $(Target)_TB.vcd

svg:
	rm -rf *.svg *.out *.dot *.json
	yosys -p "read_verilog $(OBJS); prep -top $(Target); memory_map; opt; opt_expr; techmap; abc -g AND,OR,XOR; write_json $(Target).json"
	netlistsvg $(Target).json -o $(Target).svg

clean:
	rm -rf *.svg *.out *.dot a.out *.vcd *.json $(Target)_synth.v *.log
	