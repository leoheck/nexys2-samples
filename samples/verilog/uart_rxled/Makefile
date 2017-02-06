
SRC = \
	baudgen_rx.v \
	uart_rx.v \
	rxleds.v

CLEAN = rxleds.bgn rxleds.drc rxleds.mrp rxleds.ngd rxleds.pcf \
	rxleds.bld rxleds.lso rxleds.ncd rxleds.ngm rxleds.srp \
	rxleds.bit rxleds_signalbrowser.* rxleds-routed_pad.tx \
	rxleds.map rxleds_summary.xml timing.twr \
	rxleds-routed* rxleds_usage* rxleds.ngc param.opt netlist.lst \
	xst rxleds.prj rxleds*.xrpt smartpreview.twr rxleds.svf _impactbatch.log

all: rxleds.bit

rxleds.prj: $(SRC)
	rm -f rxleds.prj
	@for i in `echo $^`; do \
	    echo "verilog work $$i" >> rxleds.prj; \
	done

rxleds.ngc: rxleds.prj
	xst -ifn rxleds.xst

rxleds.ngd: rxleds.ngc rxleds.ucf
	ngdbuild -uc rxleds.ucf rxleds.ngc

rxleds.ncd: rxleds.ngd
	map rxleds.ngd

rxleds-routed.ncd: rxleds.ncd
	par -ol high -w rxleds.ncd rxleds-routed.ncd

rxleds.bit: rxleds-routed.ncd
	bitgen -w rxleds-routed.ncd rxleds.bit


fpgas_ls:
	djtgcfg enum

fpga_init:
	djtgcfg init -d DOnbUsb

upload:
	djtgcfg prog -d DOnbUsb -i 1 -f rxleds.bit


dev=/dev/ttyUS0
screen:
	screen $(dev)

clean:
	rm -rf $(CLEAN)
	rm -rf xlnx_auto_*_xdb
	rm -rf _xmsgs
	rm -f *log
	rm -f *.lso
	rm -f *.xrpt
	rm -f *.xwbt


.PHONY: clean


