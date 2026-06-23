TOP = div_top
TB = div_TB

OBJS = sum_res_comp2.v \
       Breg.v \
       lsr_A.v \
       contador_dec.v \
       div_control.v \
       lsr_cociente.v \
       lsr_vAux.v \
       div_top.v

ECP5_SIM_CELLS=./lattice_sim/cells_sim_ecp5.v


sim:
	rm -f a.out *.vcd
	iverilog -DBENCH $(TB).v $(OBJS)
	vvp a.out
	gtkwave $(TB).vcd

sim_post_syn:
	yosys -v3 -l synth.log -p 'synth_ecp5 -top $(TOP) -json $(TOP).json; write_verilog -attr2comment $(TOP)_synth.v' $(OBJS)
	iverilog -I ./lattice_sim $(TB).v $(TOP)_synth.v $(ECP5_SIM_CELLS)
	vvp a.out
	gtkwave $(TB).vcd

svg:
	rm -rf *.svg *.out *.dot *.json
	yosys -p "read_verilog $(OBJS); prep -top $(TOP); memory_map; opt; opt_expr; techmap; abc -g AND,OR,XOR; write_json $(TOP).json"
	netlistsvg $(TOP).json -o $(TOP).svg

clean:
	rm -rf *.svg *.out *.dot a.out *.vcd *.json $(TOP)_synth.v *.log
	