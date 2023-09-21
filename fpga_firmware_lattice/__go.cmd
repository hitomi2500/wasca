@set YOSYSHQ_ROOT=E:\Saturn\Wasca\oss-cad-suite\

@set SSL_CERT_FILE=%YOSYSHQ_ROOT%etc\cacert.pem

@set PATH=%YOSYSHQ_ROOT%bin;%YOSYSHQ_ROOT%lib;%YOSYSHQ_ROOT%py3bin;%PATH%
@set PYTHON_EXECUTABLE=%YOSYSHQ_ROOT%py3bin\python3.exe
@set QT_PLUGIN_PATH=%YOSYSHQ_ROOT%lib\qt5\plugins
@set QT_LOGGING_RULES=*=false

@set GTK_EXE_PREFIX=%YOSYSHQ_ROOT%
@set GTK_DATA_PREFIX=%YOSYSHQ_ROOT%
@set GDK_PIXBUF_MODULEDIR=%YOSYSHQ_ROOT%lib\gdk-pixbuf-2.0\2.10.0\loaders
@set GDK_PIXBUF_MODULE_FILE=%YOSYSHQ_ROOT%lib\gdk-pixbuf-2.0\2.10.0\loaders.cache
@gdk-pixbuf-query-loaders.exe --update-cache

yosys -p "synth_ecp5 -top top -json blinky.json" blinky.v
nextpnr-ecp5 --json blinky.json --textcfg blinky_out_config --25k --package CABGA256 --lpf ecp5evn.lpf
ecppack --svf blinky.svf blinky_out_config blinky.bit