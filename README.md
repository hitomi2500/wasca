# wasca
Sega Saturn multipurpose cartridge, still in development phase. It will mimic Power Memory / Backup / 1MB ROMs from KoF and Ultraman, and 1M/4M RAM expansion. Additionally, wasca support Heart of Darkness prototype. More than that, it can launch any 3rd party code, for example PseudoSaturn. 
Future firmware upgrades might include Netlink and ODE functionality.
Cart is based on Altera MAX 10 FPGA with external SDRAM and internal Nios II soft CPU. 

# Flashing the cartridge
To make the board runnning, you will need to install DFUse demo software from ST Microelectronics
 and the correct drivers for the upgrade mode. If wasca is not detected by DFUse demo, try changing
the driver with zadig.
Flashing sequence:
 1) Power off your Saturn, disconnect the cartridge from the Saturn.
 2) Set the jumper in the bottom right corner into the "top" position.
 3) Connect the cartridge to PC via USB type C cable.
 4) Open DFUse demo and check that the device appeared in the list at the top. If not, check the driver.
 5) Press "Choose..." in DFUse demo and select the FPGA update firmware.
 6) Press "Upgrade...", disregard any warnings, wait until complete.
 7) Disconnect the cartridge from PC.
 8) Set the jumper in the bottom right corner into the "bottom" position.
 9) Connect the cartridge to PC via USB type C cable. The RGB led should start switching between yellow and blue colors. Wait until it either turns green or red. The left led should start blinking. If not, disconnect and repeat step 9 several times. Sometimes it takes 3-4 times to work. If failing, try repeating from step 6.
 10) Disconnect the cartridge from PC 
 11) Set the jumper in the bottom right corner into the "top" position.
 12) Connect the cartridge to PC via USB type C cable.
 13) Check that the device appeared in DFUse demo in the list at the top. 
 14) Press "Choose..." in DFUse demo and select the MCU update firmware.
 15) Press "Upgrade...", disregard any warnings, wait until complete.
 16) Disconnect the cartridge from PC.
 17) Set the jumper in the bottom right corner into the "bottom" position. Plug the cartridge back into the Saturn. You're done!

![alt tag](https://cloud.githubusercontent.com/assets/11516784/10396575/f904efe8-6eab-11e5-9087-5b3f436224b8.png)
![alt tag](https://cloud.githubusercontent.com/assets/11516784/10396577/001321d8-6eac-11e5-92fe-511548c1dfb1.png)
