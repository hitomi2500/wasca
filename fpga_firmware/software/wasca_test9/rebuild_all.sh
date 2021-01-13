#!/bin/bash
#
# Rebuild everything.

# If available, update wasca link definition header from SatCom sources
WL_FILE=/cygdrive/d/dev/Saturn/SatCom/satlink/wasca/wasca_link.h
if test -f "$WL_FILE"; then
rm -f satcom_lib/wasca_link.h
    cp -p "$WL_FILE" satcom_lib/wasca_link.h
fi

# Rebuild BSP
cd ../wasca_test9_bsp/

make clean

./create-this-bsp

cd ../wasca_test9

# Rebuild application
make clean
make

# Generate programming files
./rebuild_flash.sh
