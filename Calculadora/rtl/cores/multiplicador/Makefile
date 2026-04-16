TOP = topMod_
TB = TB_multiplicador

OBJS = acumulador_multiplicador.v \
       Areg_multiplicador.v \
       comparador_multiplicador.v \
       contador_multiplicador.v \
       control_multiplicador.v \
       lsr_B_multiplicador.v \
       multiplex_multiplicador.v \
       topMod_multiplicador.v

sim:
	rm -f a.out *.vcd
	iverilog -o a.out $(TB).v $(OBJS)
	vvp a.out
	gtkwave $(TB).vcd

sim_post_syn:
	yosys -p "read_verilog $(OBJS); synth -top $(TOP); write_verilog $(TOP)_synth.v"
	iverilog -o a.out $(TB).v $(TOP)_synth.v
	vvp a.out
	gtkwave $(TB).vcd

svg:
	rm -f *.svg *.out *.dot *.json
	yosys -p "read_verilog $(OBJS); prep -top $(TOP); write_json $(TOP).json"
	netlistsvg $(TOP).json -o $(TOP).svg

clean:
	rm -rf *.svg *.out *.dot a.out *.vcd *.json $(TOP)_synth.v
	