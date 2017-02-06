SRC = test.v uart.v

CLEAN = uart.bgn uart.drc uart.mrp uart.ngd uart.pcf \
	uart.bld uart.lso stopwatch.lso uart.ncd uart.ngm uart.srp \
	uart.bit uart_signalbrowser.* uart-routed_pad.tx \
	uart.map uart_summary.xml timing.twr \
	uart-routed* uart_usage* uart.ngc param.opt netlist.lst \
	xst uart.prj uart*.xrpt smartpreview.twr uart.svf _impactbatch.log

all: uart.bit

uart.prj: $(SRC)
	rm -f uart.prj
	@for i in `echo $^`; do \
	    echo "verilog worlk $$i" >> uart.prj; \
	done

uart.ngc: uart.prj
	xst -ifn uart.xst

uart.ngd: uart.ngc nexys2.ucf
	ngdbuild -uc nexys2.ucf uart.ngc

uart.ncd: uart.ngd
	map uart.ngd

uart-routed.ncd: uart.ncd
	par -ol high -w uart.ncd uart-routed.ncd

uart.bit: uart-routed.ncd
	bitgen -w uart-routed.ncd uart.bit



fpgas_ls:
	djtgcfg enum

fpga_init:
	djtgcfg init -d DOnbUsb

upload:
	djtgcfg prog -d DOnbUsb -i 1 -f uart.bit



clean:
	rm -rf $(CLEAN)
	rm -rf xlnx_auto_*_xdb
	rm -rf _xmsgs
	rm -f *.log
	rm -f *.lso
	rm -f *.xrpt
	rm -f *.xwbt

.PHONY: clean









# BOARD INTERACTION
#============================================================
#============================================================

# USER VARIABLES
dev = /dev/ttyUSB0
baud = 115200


define BANNER
     ##   ##   ####   #####   ######
     ##   ##  ##  ##  ##  ##    ##
     ##   ##  ######  ######    ##
     ##   ##  ##  ##  ##  ##    ##
     #######  ##  ##  ##   ##   ##

     PORT = $(dev)
     BAUD = $(baud)
endef
export BANNER


# Show debug header message
.rst-msg:
	@ clear
	@ echo -e "\n\n$${BANNER}\n"
	@ #echo -e "                 ~ Press reset button in the board to start ~\n"


# Configure serial interface
.serial-cfg:
	@ clear
	@ stty $(baud) raw cs8 -parenb -crtscts clocal cread ignpar ignbrk \
		-ixon -ixoff -ixany -brkint -icrnl -imaxbel -opost -onlcr \
		-isig -icanon -iexten -echo -echoe -echok -echoctl -echoke -F $(dev)


# Read/Show the device information
debug: .serial-cfg .rst-msg
	@ cat $(dev)


