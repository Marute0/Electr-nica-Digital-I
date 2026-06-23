TARGET = send_LEDS
ECP5_SIM_CELLS=./lattice_sim/cells_sim_ecp5.v

OBJS = timer.v \
       count_out.v \
       mux.v \
       timer_control.v \
	comp_timer.v \
	send_LEDS.v \
       led_mem.v \
       count_addr.v \
	ws2812.v \
       send_LEDS_control.v \
       GRB_lsr.v \
       count_ws2812.v \
       ws2812_control.v \
       comp_send_LEDS.v 

BUILD_DIR = build

sim:
	rm -f a.out *.vcd
	iverilog  -DBENCH $(TARGET)_TB.v $(OBJS)
	vvp a.out
	gtkwave $(TARGET)_TB.vcd
sim_post_syn:
	yosys -v3 -l synth.log -p 'synth_ecp5 -top $(TARGET) -json $(TARGET).json; write_verilog -attr2comment $(TARGET)_synth.v' $(OBJS)
	iverilog  -I ./lattice_sim  $(TARGET)_TB.v $(TARGET)_synth.v $(ECP5_SIM_CELLS) 
	vvp a.out
	gtkwave $(TARGET)_TB.vcd

$(TARGET)_out.config: $(TARGET).json
	nextpnr-ecp5 --json $(BUILD_DIR)/$< --lpf $(TARGET).lpf --textcfg $(BUILD_DIR)/$@ --25k --package CABGA256 --speed 6  --timing-allow-fail --seed 1 --lpf-allow-unconstrained  --log $(TARGET)_pnr.log

$(TARGET).bit: $(TARGET)_out.config
	ecppack --bootaddr 0 --compress \
		$(BUILD_DIR)/$(TARGET)_out.config \
		--bit $(BUILD_DIR)/$(TARGET).bit

$(TARGET).json: $(OBJS)
	mkdir -p $(BUILD_DIR)
	yosys -v3 -l $(BUILD_DIR)/synth.log \
		-p 'synth_ecp5 -top $(TARGET); write_json $(BUILD_DIR)/$(TARGET).json' \
		$(OBJS)

configure_lattice: $(TARGET).bit
	sudo openFPGALoader -c ft232RL --pins=TXD:CTS:DTR:RXD \
		-m $(BUILD_DIR)/$(TARGET).bit

svg: $(OBJS)
	rm -rf *svg *out *dot
	yosys -p "prep -top ${TARGET}; memory_map; opt; opt_expr; techmap; abc -g AND,OR,XOR; write_json ${TARGET}.json" ${OBJS}
	yosys -p "read_verilog ${TARGET}.v; proc; memory_map; opt; opt_expr; techmap; abc -g AND,OR,XOR; show -format dot -prefix ${TARGET}_out"
	netlistsvg ${TARGET}.json -o ${TARGET}.svg
	firefox ${TARGET}.svg
clean:
	rm -rf *svg *out *dot a.out *.vcd *json *_synth.v *log