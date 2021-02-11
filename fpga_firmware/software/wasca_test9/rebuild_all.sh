#!/bin/bash
#
# Rebuild everything.

# If available, update wasca link definition header from SatCom sources
WL_FOLDER=/cygdrive/d/dev/Saturn/SatCom/satlink/wasca
WL_FILE=$WL_FOLDER/wasca_link_spi.h
if test -f "$WL_FILE"; then
    rm -f satcom_lib/wasca_link_spi.h
    cp -p $WL_FOLDER/wasca_link_spi.h ../../../common
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
