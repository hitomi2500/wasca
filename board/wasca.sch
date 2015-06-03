EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:altera
LIBS:wasca
LIBS:ftdi
LIBS:74xgxx
LIBS:switches
LIBS:maxim
LIBS:wasca-cache
EELAYER 25 0
EELAYER END
$Descr A2 23386 16535
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 10M04SFE144C8G U6
U 1 1 5530484D
P 18300 4850
F 0 "U6" H 20350 8050 60  0000 C CNN
F 1 "10M04SFE144C8G" H 18300 5150 60  0000 C CNN
F 2 "Housings_QFP:TQFP-144_20x20mm_Pitch0.5mm" H 17950 4850 60  0001 C CNN
F 3 "" H 17950 4850 60  0000 C CNN
	1    18300 4850
	1    0    0    -1  
$EndComp
$Comp
L MT48LC32M16A2TG IC1
U 1 1 5530A78B
P 20750 13050
F 0 "IC1" H 20150 14250 40  0000 C CNN
F 1 "MT48LC32M16A2TG" H 21400 11750 40  0000 C CNN
F 2 "Wasca:TSOP_II_54" H 20750 13050 35  0000 C CIN
F 3 "" H 20750 12800 60  0000 C CNN
	1    20750 13050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 5530AE54
P 18300 8450
F 0 "#PWR01" H 18300 8200 50  0001 C CNN
F 1 "GND" H 18300 8300 50  0000 C CNN
F 2 "" H 18300 8450 60  0000 C CNN
F 3 "" H 18300 8450 60  0000 C CNN
	1    18300 8450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 5530B291
P 3950 8500
F 0 "#PWR02" H 3950 8250 50  0001 C CNN
F 1 "GND" H 3950 8350 50  0000 C CNN
F 2 "" H 3950 8500 60  0000 C CNN
F 3 "" H 3950 8500 60  0000 C CNN
	1    3950 8500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 5530B2A8
P 5500 8500
F 0 "#PWR03" H 5500 8250 50  0001 C CNN
F 1 "GND" H 5500 8350 50  0000 C CNN
F 2 "" H 5500 8500 60  0000 C CNN
F 3 "" H 5500 8500 60  0000 C CNN
	1    5500 8500
	1    0    0    -1  
$EndComp
$Comp
L CARTRIDGE_EDGE_CONNECTOR CN1
U 1 1 5530C876
P 4700 5250
F 0 "CN1" H 4450 9050 60  0000 C CNN
F 1 "CARTRIDGE_EDGE_CONNECTOR" H 4700 2000 60  0000 C CNN
F 2 "Wasca:CARTRIDGE_EDGE_CONNECTOR2" H 4700 5250 60  0001 C CNN
F 3 "" H 4700 5250 60  0000 C CNN
	1    4700 5250
	1    0    0    -1  
$EndComp
Text Label 3500 7150 0    40   ~ 0
ABUS_D0
Entry Wire Line
	3300 7150 3200 7250
Text Label 3500 7250 0    40   ~ 0
ABUS_D1
Text Label 3500 7350 0    40   ~ 0
ABUS_D2
Text Label 3500 7450 0    40   ~ 0
ABUS_D3
Text Label 3500 7650 0    40   ~ 0
ABUS_D8
Text Label 3500 7750 0    40   ~ 0
ABUS_D9
Text Label 3500 7850 0    40   ~ 0
ABUS_D10
Text Label 3500 7950 0    40   ~ 0
ABUS_D11
Text Label 5700 7150 0    40   ~ 0
ABUS_D7
Text Label 5700 7250 0    40   ~ 0
ABUS_D6
Text Label 5700 7350 0    40   ~ 0
ABUS_D5
Text Label 5700 7450 0    40   ~ 0
ABUS_D4
Text Label 5700 7650 0    40   ~ 0
ABUS_D15
Text Label 5700 7750 0    40   ~ 0
ABUS_D14
Text Label 5700 7850 0    40   ~ 0
ABUS_D13
Text Label 5700 7950 0    40   ~ 0
ABUS_D12
Entry Wire Line
	3300 7250 3200 7350
Entry Wire Line
	3300 7350 3200 7450
Entry Wire Line
	3300 7450 3200 7550
Entry Wire Line
	3300 7650 3200 7750
Entry Wire Line
	3300 7750 3200 7850
Entry Wire Line
	3300 7850 3200 7950
Entry Wire Line
	3300 7950 3200 8050
Entry Wire Line
	6150 7150 6250 7250
Entry Wire Line
	6150 7250 6250 7350
Entry Wire Line
	6150 7350 6250 7450
Entry Wire Line
	6150 7450 6250 7550
Entry Wire Line
	6150 7650 6250 7750
Entry Wire Line
	6150 7750 6250 7850
Entry Wire Line
	6150 7850 6250 7950
Entry Wire Line
	6150 7950 6250 8050
Entry Bus Bus
	6250 8150 6350 8250
Text Label 3500 6650 0    40   ~ 0
ABUS_FC0
Text Label 3500 6750 0    40   ~ 0
ABUS_TIM0
Text Label 3500 6850 0    40   ~ 0
ABUS_TIM2
Text Label 3500 6950 0    40   ~ 0
ABUS_AS
Text Label 3500 6350 0    40   ~ 0
ABUS_CS0
Text Label 3500 6450 0    40   ~ 0
ABUS_CS2
Text Label 3500 6550 0    40   ~ 0
ABUS_WR0
Text Label 5650 6650 0    40   ~ 0
ABUS_FC1
Text Label 5650 6750 0    40   ~ 0
ABUS_TIM1
Text Label 5650 6850 0    40   ~ 0
ABUS_WAIT
Text Label 5650 6950 0    40   ~ 0
ABUS_IRQ
Text Label 5650 6350 0    40   ~ 0
ABUS_RD
Text Label 5650 6450 0    40   ~ 0
ABUS_CS1
Text Label 5650 6550 0    40   ~ 0
ABUS_WR1
Text Label 3500 6150 0    40   ~ 0
ABUS_A1
Text Label 3500 5850 0    40   ~ 0
ABUS_A9
Text Label 3500 5950 0    40   ~ 0
ABUS_A11
Text Label 3500 6050 0    40   ~ 0
ABUS_A10
Text Label 3500 5650 0    40   ~ 0
ABUS_A8
Text Label 3500 5350 0    40   ~ 0
ABUS_A15
Text Label 3500 5450 0    40   ~ 0
ABUS_A12
Text Label 3500 5550 0    40   ~ 0
ABUS_A13
Text Label 5650 6150 0    40   ~ 0
ABUS_A0
Text Label 5650 5850 0    40   ~ 0
ABUS_A4
Text Label 5650 5950 0    40   ~ 0
ABUS_A3
Text Label 5650 6050 0    40   ~ 0
ABUS_A2
Text Label 5650 5650 0    40   ~ 0
ABUS_A5
Text Label 5650 5350 0    40   ~ 0
ABUS_A14
Text Label 5650 5450 0    40   ~ 0
ABUS_A7
Text Label 5650 5550 0    40   ~ 0
ABUS_A6
Text Label 3500 5000 0    40   ~ 0
ABUS_A17
Text Label 3500 4700 0    40   ~ 0
ABUS_A23
Text Label 3500 4800 0    40   ~ 0
ABUS_A21
Text Label 3500 4900 0    40   ~ 0
ABUS_A19
Text Label 3500 4600 0    40   ~ 0
ABUS_A25
Text Label 5650 5000 0    40   ~ 0
ABUS_A16
Text Label 5650 4700 0    40   ~ 0
ABUS_A22
Text Label 5650 4800 0    40   ~ 0
ABUS_A20
Text Label 5650 4900 0    40   ~ 0
ABUS_A18
Text Label 5650 4600 0    40   ~ 0
ABUS_A24
Text Label 3500 2200 0    40   ~ 0
SCSPCLK
Text Label 19650 12000 0    40   ~ 0
SDR_A0
Text Label 19650 12100 0    40   ~ 0
SDR_A1
Text Label 19650 12200 0    40   ~ 0
SDR_A2
Text Label 19650 12300 0    40   ~ 0
SDR_A3
Text Label 19650 12400 0    40   ~ 0
SDR_A4
Text Label 19650 12500 0    40   ~ 0
SDR_A5
Text Label 19650 12600 0    40   ~ 0
SDR_A6
Text Label 19650 12700 0    40   ~ 0
SDR_A7
Text Label 19650 12800 0    40   ~ 0
SDR_A8
Text Label 19650 12900 0    40   ~ 0
SDR_A9
Text Label 19650 13000 0    40   ~ 0
SDR_A10
Text Label 19650 13100 0    40   ~ 0
SDR_A11
Text Label 19650 13200 0    40   ~ 0
SDR_A12
Text Label 19650 13350 0    40   ~ 0
SDR_BA0
Text Label 19650 13450 0    40   ~ 0
SDR_BA1
Text Label 19650 13600 0    40   ~ 0
SDR_CLK
Text Label 19650 13700 0    40   ~ 0
SDR_CKE
Text Label 19650 13850 0    40   ~ 0
SDR_RAS
Text Label 19650 13950 0    40   ~ 0
SDR_CAS
Text Label 19650 14050 0    40   ~ 0
SDR_WE
Text Label 19650 14200 0    40   ~ 0
SDR_CS
Text Label 21650 12000 0    40   ~ 0
SDR_DQ0
Text Label 21650 12100 0    40   ~ 0
SDR_DQ1
Text Label 21650 12200 0    40   ~ 0
SDR_DQ2
Text Label 21650 12300 0    40   ~ 0
SDR_DQ3
Text Label 21650 12400 0    40   ~ 0
SDR_DQ4
Text Label 21650 12500 0    40   ~ 0
SDR_DQ5
Text Label 21650 12600 0    40   ~ 0
SDR_DQ6
Text Label 21650 12700 0    40   ~ 0
SDR_DQ7
Text Label 21650 12800 0    40   ~ 0
SDR_DQ8
Text Label 21650 12900 0    40   ~ 0
SDR_DQ9
Text Label 21650 13000 0    40   ~ 0
SDR_DQ10
Text Label 21650 13100 0    40   ~ 0
SDR_DQ11
Text Label 21650 13200 0    40   ~ 0
SDR_DQ12
Text Label 21650 13300 0    40   ~ 0
SDR_DQ13
Text Label 21650 13400 0    40   ~ 0
SDR_DQ14
Text Label 21650 13500 0    40   ~ 0
SDR_DQ15
Text Label 21650 13750 0    40   ~ 0
SDR_DQML
Text Label 21650 13850 0    40   ~ 0
SDR_DQMH
Text Label 20750 6350 0    40   ~ 0
SDR_A0
Text Label 20750 6550 0    40   ~ 0
SDR_A1
Text Label 20750 6650 0    40   ~ 0
SDR_A2
Text Label 20750 6750 0    40   ~ 0
SDR_A3
Text Label 20750 2350 0    40   ~ 0
SDR_A4
Text Label 20750 2450 0    40   ~ 0
SDR_A5
Text Label 20750 2550 0    40   ~ 0
SDR_A6
Text Label 20750 2650 0    40   ~ 0
SDR_A7
Text Label 20750 2750 0    40   ~ 0
SDR_A8
Text Label 20750 2850 0    40   ~ 0
SDR_A9
Text Label 20750 6250 0    40   ~ 0
SDR_A10
Text Label 20750 2950 0    40   ~ 0
SDR_A11
Text Label 20750 3050 0    40   ~ 0
SDR_A12
Text Label 20750 6050 0    40   ~ 0
SDR_BA0
Text Label 20750 6150 0    40   ~ 0
SDR_BA1
Text Label 20750 3350 0    40   ~ 0
SDR_CLK
Text Label 20750 3150 0    40   ~ 0
SDR_CKE
Text Label 20750 5850 0    40   ~ 0
SDR_RAS
Text Label 20750 5750 0    40   ~ 0
SDR_CAS
Text Label 20750 5650 0    40   ~ 0
SDR_WE
Text Label 20750 5950 0    40   ~ 0
SDR_CS
Text Label 20750 5150 0    40   ~ 0
SDR_DQ0
Text Label 20750 5050 0    40   ~ 0
SDR_DQ1
Text Label 20750 4950 0    40   ~ 0
SDR_DQ2
Text Label 20750 4750 0    40   ~ 0
SDR_DQ3
Text Label 20750 4650 0    40   ~ 0
SDR_DQ4
Text Label 20750 5250 0    40   ~ 0
SDR_DQ5
Text Label 20750 5350 0    40   ~ 0
SDR_DQ6
Text Label 20750 5450 0    40   ~ 0
SDR_DQ7
Text Label 20750 3650 0    40   ~ 0
SDR_DQ8
Text Label 20750 3850 0    40   ~ 0
SDR_DQ9
Text Label 20750 3950 0    40   ~ 0
SDR_DQ10
Text Label 20750 4150 0    40   ~ 0
SDR_DQ11
Text Label 20750 4250 0    40   ~ 0
SDR_DQ12
Text Label 20750 4350 0    40   ~ 0
SDR_DQ13
Text Label 20750 4450 0    40   ~ 0
SDR_DQ14
Text Label 20750 4550 0    40   ~ 0
SDR_DQ15
Text Label 20750 5550 0    40   ~ 0
SDR_DQML
Text Label 20750 3550 0    40   ~ 0
SDR_DQMH
Text Label 3500 1800 0    40   ~ 0
RESET
$Comp
L GND #PWR04
U 1 1 553255F0
P 20750 14550
F 0 "#PWR04" H 20750 14300 50  0001 C CNN
F 1 "GND" H 20750 14400 50  0000 C CNN
F 2 "" H 20750 14550 60  0000 C CNN
F 3 "" H 20750 14550 60  0000 C CNN
	1    20750 14550
	1    0    0    -1  
$EndComp
Text Label 20050 11350 0    60   ~ 0
+3_3V
Text Label 14550 3350 0    40   ~ 0
JTAG_TMS
Text Label 14550 3550 0    40   ~ 0
JTAG_TCK
Text Label 14550 3650 0    40   ~ 0
JTAG_TDI
Text Label 14550 3750 0    40   ~ 0
JTAG_TDO
$Comp
L 74ALVC164245 U3
U 1 1 55357BE8
P 8250 5350
F 0 "U3" H 7950 6250 60  0000 L BNN
F 1 "74ALVC164245" H 7950 6200 60  0000 L TNN
F 2 "Housings_SSOP:TSSOP-48_6.1x12.5mm_Pitch0.5mm" H 8250 5000 60  0001 C CNN
F 3 "" H 8250 5000 60  0000 C CNN
	1    8250 5350
	-1   0    0    -1  
$EndComp
$Comp
L 74ALVC164245 U1
U 1 1 55357CB5
P 4850 10100
F 0 "U1" H 4550 11000 60  0000 L BNN
F 1 "74ALVC164245" H 4550 10950 60  0000 L TNN
F 2 "Housings_SSOP:TSSOP-48_6.1x12.5mm_Pitch0.5mm" H 4850 9750 60  0001 C CNN
F 3 "" H 4850 9750 60  0000 C CNN
	1    4850 10100
	-1   0    0    -1  
$EndComp
Entry Bus Bus
	6500 8250 6600 8150
Entry Wire Line
	6600 6450 6700 6350
Entry Wire Line
	6600 6550 6700 6450
Entry Wire Line
	6600 6650 6700 6550
Entry Wire Line
	6600 6750 6700 6650
Entry Wire Line
	6600 6850 6700 6750
Entry Wire Line
	6600 6950 6700 6850
Entry Wire Line
	6600 7150 6700 7050
Entry Wire Line
	6600 7050 6700 6950
Text Label 6900 6350 0    40   ~ 0
ABUS_D7
Text Label 6900 6450 0    40   ~ 0
ABUS_D6
Text Label 6900 6550 0    40   ~ 0
ABUS_D5
Text Label 6900 6650 0    40   ~ 0
ABUS_D4
Text Label 6900 6750 0    40   ~ 0
ABUS_D15
Text Label 6900 6850 0    40   ~ 0
ABUS_D14
Text Label 6900 6950 0    40   ~ 0
ABUS_D13
Text Label 6900 7050 0    40   ~ 0
ABUS_D12
Entry Wire Line
	6150 6150 6250 6050
Entry Wire Line
	6150 6050 6250 5950
Entry Wire Line
	6150 5950 6250 5850
Entry Wire Line
	6150 5850 6250 5750
Entry Wire Line
	6150 5650 6250 5550
Entry Wire Line
	6150 5550 6250 5450
Entry Wire Line
	6150 5450 6250 5350
Entry Wire Line
	6150 5350 6250 5250
Text Label 6900 5550 0    40   ~ 0
ABUS_A5
Text Label 6900 5250 0    40   ~ 0
ABUS_A14
Text Label 6900 5350 0    40   ~ 0
ABUS_A7
Text Label 6900 5450 0    40   ~ 0
ABUS_A6
Text Label 6900 5950 0    40   ~ 0
ABUS_A0
Text Label 6900 5650 0    40   ~ 0
ABUS_A4
Text Label 6900 5750 0    40   ~ 0
ABUS_A3
Text Label 6900 5850 0    40   ~ 0
ABUS_A2
Entry Wire Line
	6600 5850 6700 5950
Entry Wire Line
	6600 5750 6700 5850
Entry Wire Line
	6600 5650 6700 5750
Entry Wire Line
	6600 5550 6700 5650
Entry Wire Line
	6600 5450 6700 5550
Entry Wire Line
	6600 5350 6700 5450
Entry Wire Line
	6600 5250 6700 5350
Entry Wire Line
	6600 5150 6700 5250
Entry Bus Bus
	6500 5050 6600 5150
Entry Bus Bus
	6500 5050 6600 5150
Entry Bus Bus
	6250 5150 6350 5050
Text Label 9800 5250 0    40   ~ 0
ABUS_3V_MUX0
Text Label 9800 5350 0    40   ~ 0
ABUS_3V_MUX1
Text Label 9800 5450 0    40   ~ 0
ABUS_3V_MUX2
Text Label 9800 5550 0    40   ~ 0
ABUS_3V_MUX3
Text Label 9800 5650 0    40   ~ 0
ABUS_3V_MUX4
Text Label 9800 5750 0    40   ~ 0
ABUS_3V_MUX5
Text Label 9800 5850 0    40   ~ 0
ABUS_3V_MUX6
Text Label 9800 5950 0    40   ~ 0
ABUS_3V_MUX7
Text Label 3500 10700 0    40   ~ 0
ABUS_D0
Text Label 3500 10600 0    40   ~ 0
ABUS_D1
Text Label 3500 10500 0    40   ~ 0
ABUS_D2
Text Label 3500 10400 0    40   ~ 0
ABUS_D3
Text Label 3500 10300 0    40   ~ 0
ABUS_D8
Text Label 3500 10200 0    40   ~ 0
ABUS_D9
Text Label 3500 10100 0    40   ~ 0
ABUS_D10
Text Label 3500 10000 0    40   ~ 0
ABUS_D11
Entry Wire Line
	3200 10600 3300 10700
Entry Wire Line
	3200 10500 3300 10600
Entry Wire Line
	3200 10400 3300 10500
Entry Wire Line
	3200 10300 3300 10400
Entry Wire Line
	3200 10200 3300 10300
Entry Wire Line
	3200 10100 3300 10200
Entry Wire Line
	3200 10000 3300 10100
Entry Wire Line
	3200 9900 3300 10000
Text Label 3500 11100 0    40   ~ 0
ABUS_A1
Text Label 3500 11400 0    40   ~ 0
ABUS_A9
Text Label 3500 11300 0    40   ~ 0
ABUS_A11
Text Label 3500 11200 0    40   ~ 0
ABUS_A10
Text Label 3500 11500 0    40   ~ 0
ABUS_A8
Text Label 3500 11800 0    40   ~ 0
ABUS_A15
Text Label 3500 11700 0    40   ~ 0
ABUS_A12
Text Label 3500 11600 0    40   ~ 0
ABUS_A13
Entry Wire Line
	3000 5450 3100 5350
Entry Wire Line
	3000 5550 3100 5450
Entry Wire Line
	3000 5650 3100 5550
Entry Wire Line
	3000 5750 3100 5650
Entry Wire Line
	3000 5950 3100 5850
Entry Wire Line
	3000 6050 3100 5950
Entry Wire Line
	3000 6150 3100 6050
Entry Wire Line
	3000 6250 3100 6150
Entry Wire Line
	3000 11000 3100 11100
Entry Wire Line
	3000 11100 3100 11200
Entry Wire Line
	3000 11200 3100 11300
Entry Wire Line
	3000 11300 3100 11400
Entry Wire Line
	3000 11400 3100 11500
Entry Wire Line
	3000 11500 3100 11600
Entry Wire Line
	3000 11600 3100 11700
Entry Wire Line
	3000 11700 3100 11800
Text Label 6400 10000 0    40   ~ 0
ABUS_3V_MUX8
Text Label 6400 10100 0    40   ~ 0
ABUS_3V_MUX9
Text Label 6400 10200 0    40   ~ 0
ABUS_3V_MUX10
Text Label 6400 10300 0    40   ~ 0
ABUS_3V_MUX11
Text Label 6400 10400 0    40   ~ 0
ABUS_3V_MUX12
Text Label 6400 10500 0    40   ~ 0
ABUS_3V_MUX13
Text Label 6400 10600 0    40   ~ 0
ABUS_3V_MUX14
Text Label 6400 10700 0    40   ~ 0
ABUS_3V_MUX15
Text Label 15500 4550 0    40   ~ 0
ABUS_3V_MUX0
Text Label 15500 4650 0    40   ~ 0
ABUS_3V_MUX1
Text Label 15500 4750 0    40   ~ 0
ABUS_3V_MUX2
Text Label 15500 4850 0    40   ~ 0
ABUS_3V_MUX3
Text Label 15500 4950 0    40   ~ 0
ABUS_3V_MUX4
Text Label 15500 5150 0    40   ~ 0
ABUS_3V_MUX5
Text Label 15500 5250 0    40   ~ 0
ABUS_3V_MUX6
Text Label 15500 5350 0    40   ~ 0
ABUS_3V_MUX7
Text Label 20850 7350 0    40   ~ 0
ABUS_3V_MUX8
Text Label 20850 7450 0    40   ~ 0
ABUS_3V_MUX9
Text Label 20850 7550 0    40   ~ 0
ABUS_3V_MUX10
Text Label 20850 7650 0    40   ~ 0
ABUS_3V_MUX11
Text Label 15500 7650 0    40   ~ 0
ABUS_3V_MUX12
Text Label 15500 7550 0    40   ~ 0
ABUS_3V_MUX13
Text Label 15500 7450 0    40   ~ 0
ABUS_3V_MUX14
Text Label 15500 7350 0    40   ~ 0
ABUS_3V_MUX15
Text Label 7050 4750 0    40   ~ 0
+5V
$Comp
L GND #PWR05
U 1 1 553685DB
P 8200 7800
F 0 "#PWR05" H 8200 7550 50  0001 C CNN
F 1 "GND" H 8200 7650 50  0000 C CNN
F 2 "" H 8200 7800 60  0000 C CNN
F 3 "" H 8200 7800 60  0000 C CNN
	1    8200 7800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR06
U 1 1 5536993C
P 9650 5050
F 0 "#PWR06" H 9650 4800 50  0001 C CNN
F 1 "GND" H 9650 4900 50  0000 C CNN
F 2 "" H 9650 5050 60  0000 C CNN
F 3 "" H 9650 5050 60  0000 C CNN
	1    9650 5050
	1    0    0    -1  
$EndComp
Text Label 9900 6250 0    40   ~ 0
ABUS_3V_MUX_EN2
Text Label 9000 5150 0    40   ~ 0
ABUS_3V_MUX_EN1
Text Label 9900 6150 0    40   ~ 0
ABUS_3V_MUX_DATA_DIR
Text Label 6500 11000 0    40   ~ 0
ABUS_3V_MUX_EN2
Text Label 6500 10900 0    40   ~ 0
ABUS_3V_MUX_DATA_DIR
$Comp
L GND #PWR07
U 1 1 5536AAA8
P 6250 9800
F 0 "#PWR07" H 6250 9550 50  0001 C CNN
F 1 "GND" H 6250 9650 50  0000 C CNN
F 2 "" H 6250 9800 60  0000 C CNN
F 3 "" H 6250 9800 60  0000 C CNN
	1    6250 9800
	1    0    0    -1  
$EndComp
Text Label 5600 9900 0    40   ~ 0
ABUS_3V_MUX_EN1
Text Label 3650 9500 0    40   ~ 0
+5V
Text Label 5850 9500 0    40   ~ 0
+3_3V
Text Label 9250 4750 0    40   ~ 0
+3_3V
Text Label 15450 4450 0    40   ~ 0
ABUS_3V_MUX_EN1
Text Label 15450 5450 0    40   ~ 0
ABUS_3V_MUX_EN2
Text Label 15450 5550 0    40   ~ 0
ABUS_3V_MUX_DATA_DIR
Text Label 5700 1600 0    40   ~ 0
+5V
Text Label 2800 1600 0    40   ~ 0
+5V
$Comp
L 74ALVC164245 U2
U 1 1 5536D248
P 8250 1700
F 0 "U2" H 7950 2600 60  0000 L BNN
F 1 "74ALVC164245" H 7950 2550 60  0000 L TNN
F 2 "Housings_SSOP:TSSOP-48_6.1x12.5mm_Pitch0.5mm" H 8250 1350 60  0001 C CNN
F 3 "" H 8250 1350 60  0000 C CNN
	1    8250 1700
	-1   0    0    -1  
$EndComp
Text Label 6900 2700 0    40   ~ 0
ABUS_FC1
Text Label 6900 2300 0    40   ~ 0
ABUS_TIM1
Text Label 7150 13900 0    40   ~ 0
ABUS_WAIT
Text Label 7150 14000 0    40   ~ 0
ABUS_IRQ
Text Label 6900 3000 0    40   ~ 0
ABUS_RD
Text Label 6900 2900 0    40   ~ 0
ABUS_CS1
Text Label 6900 2800 0    40   ~ 0
ABUS_WR1
Text Label 6900 1900 0    40   ~ 0
ABUS_FC0
Text Label 6900 1800 0    40   ~ 0
ABUS_TIM0
Text Label 6900 1700 0    40   ~ 0
ABUS_TIM2
Text Label 6900 1600 0    40   ~ 0
ABUS_AS
Text Label 6900 2200 0    40   ~ 0
ABUS_CS0
Text Label 6900 2100 0    40   ~ 0
ABUS_CS2
Text Label 6900 2000 0    40   ~ 0
ABUS_WR0
Text Label 7150 12200 0    40   ~ 0
ABUS_A17
Text Label 6900 3200 0    40   ~ 0
ABUS_A23
Text Label 6900 3300 0    40   ~ 0
ABUS_A21
Text Label 6900 3400 0    40   ~ 0
ABUS_A19
Text Label 6900 3100 0    40   ~ 0
ABUS_A25
Text Label 7150 12900 0    40   ~ 0
SCSPCLK
Text Label 7150 12700 0    40   ~ 0
ABUS_A16
Text Label 7150 12400 0    40   ~ 0
ABUS_A22
Text Label 7150 12500 0    40   ~ 0
ABUS_A20
Text Label 7150 12600 0    40   ~ 0
ABUS_A18
Text Label 7150 12300 0    40   ~ 0
ABUS_A24
Text Label 7150 12800 0    40   ~ 0
RESET
$Comp
L 74ALVC164245 U4
U 1 1 5536E7A3
P 8500 12300
F 0 "U4" H 8200 13200 60  0000 L BNN
F 1 "74ALVC164245" H 8200 13150 60  0000 L TNN
F 2 "Housings_SSOP:TSSOP-48_6.1x12.5mm_Pitch0.5mm" H 8500 11950 60  0001 C CNN
F 3 "" H 8500 11950 60  0000 C CNN
	1    8500 12300
	-1   0    0    -1  
$EndComp
Text Label 9150 2700 0    40   ~ 0
ABUS_3V_FC1
Text Label 9150 2300 0    40   ~ 0
ABUS_3V_TIM1
Text Label 9150 3000 0    40   ~ 0
ABUS_3V_RD
Text Label 9150 2900 0    40   ~ 0
ABUS_3V_CS1
Text Label 9150 2800 0    40   ~ 0
ABUS_3V_WR1
Text Label 9150 1900 0    40   ~ 0
ABUS_3V_FC0
Text Label 9150 1800 0    40   ~ 0
ABUS_3V_TIM0
Text Label 9150 1700 0    40   ~ 0
ABUS_3V_TIM2
Text Label 9150 1600 0    40   ~ 0
ABUS_3V_AS
Text Label 9150 2200 0    40   ~ 0
ABUS_3V_CS0
Text Label 9150 2100 0    40   ~ 0
ABUS_3V_CS2
Text Label 9150 2000 0    40   ~ 0
ABUS_3V_WR0
Text Label 9150 3200 0    40   ~ 0
ABUS_3V_A23
Text Label 9150 3300 0    40   ~ 0
ABUS_3V_A21
Text Label 9150 3400 0    40   ~ 0
ABUS_3V_A19
Text Label 9150 3100 0    40   ~ 0
ABUS_3V_A25
Text Label 9400 12200 0    40   ~ 0
ABUS_3V_A17
Text Label 9400 12900 0    40   ~ 0
SCSPCLK_3V
Text Label 9400 12700 0    40   ~ 0
ABUS_3V_A16
Text Label 9400 12400 0    40   ~ 0
ABUS_3V_A22
Text Label 9400 12500 0    40   ~ 0
ABUS_3V_A20
Text Label 9400 12600 0    40   ~ 0
ABUS_3V_A18
Text Label 9400 12300 0    40   ~ 0
ABUS_3V_A24
Text Label 9400 12800 0    40   ~ 0
RESET_3V
$Comp
L GND #PWR08
U 1 1 55373676
P 9650 1400
F 0 "#PWR08" H 9650 1150 50  0001 C CNN
F 1 "GND" H 9650 1250 50  0000 C CNN
F 2 "" H 9650 1400 60  0000 C CNN
F 3 "" H 9650 1400 60  0000 C CNN
	1    9650 1400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR09
U 1 1 553738F4
P 9650 2500
F 0 "#PWR09" H 9650 2250 50  0001 C CNN
F 1 "GND" H 9650 2350 50  0000 C CNN
F 2 "" H 9650 2500 60  0000 C CNN
F 3 "" H 9650 2500 60  0000 C CNN
	1    9650 2500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR010
U 1 1 55373B0B
P 9900 12000
F 0 "#PWR010" H 9900 11750 50  0001 C CNN
F 1 "GND" H 9900 11850 50  0000 C CNN
F 2 "" H 9900 12000 60  0000 C CNN
F 3 "" H 9900 12000 60  0000 C CNN
	1    9900 12000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR011
U 1 1 55373BF2
P 9900 13200
F 0 "#PWR011" H 9900 12950 50  0001 C CNN
F 1 "GND" H 9900 13050 50  0000 C CNN
F 2 "" H 9900 13200 60  0000 C CNN
F 3 "" H 9900 13200 60  0000 C CNN
	1    9900 13200
	1    0    0    -1  
$EndComp
Text Label 9300 13100 0    40   ~ 0
+5V
Text Label 9400 13900 0    40   ~ 0
ABUS_3V_WAIT
Text Label 9400 14000 0    40   ~ 0
ABUS_3V_IRQ
Text Label 7300 11700 0    40   ~ 0
+5V
Text Label 7050 1100 0    40   ~ 0
+5V
Text Label 9250 1100 0    40   ~ 0
+3_3V
Text Label 9500 11700 0    40   ~ 0
+3_3V
$Comp
L GND #PWR012
U 1 1 55374C6F
P 8200 4150
F 0 "#PWR012" H 8200 3900 50  0001 C CNN
F 1 "GND" H 8200 4000 50  0000 C CNN
F 2 "" H 8200 4150 60  0000 C CNN
F 3 "" H 8200 4150 60  0000 C CNN
	1    8200 4150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR013
U 1 1 55374E3F
P 8450 14750
F 0 "#PWR013" H 8450 14500 50  0001 C CNN
F 1 "GND" H 8450 14600 50  0000 C CNN
F 2 "" H 8450 14750 60  0000 C CNN
F 3 "" H 8450 14750 60  0000 C CNN
	1    8450 14750
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR014
U 1 1 55375E46
P 10250 13800
F 0 "#PWR014" H 10250 13550 50  0001 C CNN
F 1 "GND" H 10250 13650 50  0000 C CNN
F 2 "" H 10250 13800 60  0000 C CNN
F 3 "" H 10250 13800 60  0000 C CNN
	1    10250 13800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR015
U 1 1 55377281
P 4800 12550
F 0 "#PWR015" H 4800 12300 50  0001 C CNN
F 1 "GND" H 4800 12400 50  0000 C CNN
F 2 "" H 4800 12550 60  0000 C CNN
F 3 "" H 4800 12550 60  0000 C CNN
	1    4800 12550
	1    0    0    -1  
$EndComp
Text Label 15500 6850 0    40   ~ 0
ABUS_3V_FC0
Text Label 15500 7050 0    40   ~ 0
ABUS_3V_TIM0
Text Label 15500 7150 0    40   ~ 0
ABUS_3V_TIM2
Text Label 15500 7250 0    40   ~ 0
ABUS_3V_AS
Text Label 15500 5850 0    40   ~ 0
ABUS_3V_A23
Text Label 15500 5750 0    40   ~ 0
ABUS_3V_A21
Text Label 15500 5650 0    40   ~ 0
ABUS_3V_A19
Text Label 15500 5950 0    40   ~ 0
ABUS_3V_A25
Text Label 15500 6350 0    40   ~ 0
ABUS_3V_FC1
Text Label 15500 6450 0    40   ~ 0
ABUS_3V_TIM1
Text Label 15500 6050 0    40   ~ 0
ABUS_3V_RD
Text Label 15500 6150 0    40   ~ 0
ABUS_3V_CS1
Text Label 15500 6250 0    40   ~ 0
ABUS_3V_WR1
Text Label 15500 6550 0    40   ~ 0
ABUS_3V_CS0
Text Label 15500 6650 0    40   ~ 0
ABUS_3V_CS2
Text Label 15500 6750 0    40   ~ 0
ABUS_3V_WR0
Text Label 15500 2850 0    40   ~ 0
ABUS_3V_A17
Text Label 15500 4350 0    40   ~ 0
SCSPCLK_3V
Text Label 15500 3850 0    40   ~ 0
ABUS_3V_A16
Text Label 15500 3050 0    40   ~ 0
ABUS_3V_A22
Text Label 15500 3150 0    40   ~ 0
ABUS_3V_A20
Text Label 15500 3450 0    40   ~ 0
ABUS_3V_A18
Text Label 15500 2950 0    40   ~ 0
ABUS_3V_A24
Text Label 15500 3950 0    40   ~ 0
RESET_3V
Text Label 15500 4050 0    40   ~ 0
ABUS_3V_WAIT
Text Label 15500 4150 0    40   ~ 0
ABUS_3V_IRQ
$Comp
L SD_Card CON1
U 1 1 5537B422
P 11700 2150
F 0 "CON1" H 11050 2700 50  0000 C CNN
F 1 "SD_Card" H 12300 1600 50  0000 C CNN
F 2 "Connect:SD_Card_Receptacle" H 11900 2500 50  0000 C CNN
F 3 "" H 11700 2150 60  0000 C CNN
	1    11700 2150
	-1   0    0    -1  
$EndComp
Text Label 12600 1150 2    40   ~ 0
+3_3V
$Comp
L R R1
U 1 1 5536F553
P 13700 1400
F 0 "R1" V 13780 1400 50  0000 C CNN
F 1 "50K" V 13700 1400 50  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 13630 1400 30  0001 C CNN
F 3 "" H 13700 1400 30  0000 C CNN
	1    13700 1400
	-1   0    0    -1  
$EndComp
Text Label 14650 1350 0    40   ~ 0
+3_3V
$Comp
L L_Small L1
U 1 1 553815DE
P 18650 1350
F 0 "L1" H 18680 1390 50  0000 L CNN
F 1 "L_Small" H 18680 1310 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 18850 1200 60  0001 C CNN
F 3 "" H 18650 1350 60  0000 C CNN
	1    18650 1350
	0    -1   -1   0   
$EndComp
$Comp
L C_Small C12
U 1 1 55383C59
P 15100 1500
F 0 "C12" H 15110 1570 50  0000 L CNN
F 1 "0.1uF" H 15110 1420 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 15100 1500 60  0001 C CNN
F 3 "" H 15100 1500 60  0000 C CNN
	1    15100 1500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR016
U 1 1 55383C5F
P 15100 1600
F 0 "#PWR016" H 15100 1350 50  0001 C CNN
F 1 "GND" H 15100 1450 50  0001 C CNN
F 2 "" H 15100 1600 60  0000 C CNN
F 3 "" H 15100 1600 60  0000 C CNN
	1    15100 1600
	1    0    0    -1  
$EndComp
$Comp
L C_Small C15
U 1 1 55383C66
P 15400 1500
F 0 "C15" H 15410 1570 50  0000 L CNN
F 1 "0.1uF" H 15410 1420 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 15400 1500 60  0001 C CNN
F 3 "" H 15400 1500 60  0000 C CNN
	1    15400 1500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR017
U 1 1 55383C6C
P 15400 1600
F 0 "#PWR017" H 15400 1350 50  0001 C CNN
F 1 "GND" H 15400 1450 50  0001 C CNN
F 2 "" H 15400 1600 60  0000 C CNN
F 3 "" H 15400 1600 60  0000 C CNN
	1    15400 1600
	1    0    0    -1  
$EndComp
$Comp
L C_Small C7
U 1 1 55383D80
P 7300 11850
F 0 "C7" H 7310 11920 50  0000 L CNN
F 1 "0.1uF" H 7310 11770 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 7300 11850 60  0001 C CNN
F 3 "" H 7300 11850 60  0000 C CNN
	1    7300 11850
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR018
U 1 1 55383D86
P 7300 11950
F 0 "#PWR018" H 7300 11700 50  0001 C CNN
F 1 "GND" H 7300 11800 50  0001 C CNN
F 2 "" H 7300 11950 60  0000 C CNN
F 3 "" H 7300 11950 60  0000 C CNN
	1    7300 11950
	1    0    0    -1  
$EndComp
$Comp
L C_Small C16
U 1 1 55383D8D
P 15400 1950
F 0 "C16" H 15410 2020 50  0000 L CNN
F 1 "0.1uF" H 15410 1870 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 15400 1950 60  0001 C CNN
F 3 "" H 15400 1950 60  0000 C CNN
	1    15400 1950
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR019
U 1 1 55383D93
P 15400 2050
F 0 "#PWR019" H 15400 1800 50  0001 C CNN
F 1 "GND" H 15400 1900 50  0001 C CNN
F 2 "" H 15400 2050 60  0000 C CNN
F 3 "" H 15400 2050 60  0000 C CNN
	1    15400 2050
	1    0    0    -1  
$EndComp
$Comp
L C_Small C11
U 1 1 55383E52
P 15100 1000
F 0 "C11" H 15110 1070 50  0000 L CNN
F 1 "0.1uF" H 15110 920 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 15100 1000 60  0001 C CNN
F 3 "" H 15100 1000 60  0000 C CNN
	1    15100 1000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR020
U 1 1 55383E58
P 15100 1100
F 0 "#PWR020" H 15100 850 50  0001 C CNN
F 1 "GND" H 15100 950 50  0001 C CNN
F 2 "" H 15100 1100 60  0000 C CNN
F 3 "" H 15100 1100 60  0000 C CNN
	1    15100 1100
	1    0    0    -1  
$EndComp
$Comp
L C_Small C14
U 1 1 55383E5F
P 15400 1000
F 0 "C14" H 15410 1070 50  0000 L CNN
F 1 "0.1uF" H 15410 920 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 15400 1000 60  0001 C CNN
F 3 "" H 15400 1000 60  0000 C CNN
	1    15400 1000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR021
U 1 1 55383E65
P 15400 1100
F 0 "#PWR021" H 15400 850 50  0001 C CNN
F 1 "GND" H 15400 950 50  0001 C CNN
F 2 "" H 15400 1100 60  0000 C CNN
F 3 "" H 15400 1100 60  0000 C CNN
	1    15400 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	17700 8250 17700 8350
Wire Wire Line
	17700 8350 17800 8350
Wire Wire Line
	17800 8350 17900 8350
Wire Wire Line
	17900 8350 18000 8350
Wire Wire Line
	18000 8350 18100 8350
Wire Wire Line
	18100 8350 18200 8350
Wire Wire Line
	18200 8350 18300 8350
Wire Wire Line
	18300 8350 18400 8350
Wire Wire Line
	18400 8350 18500 8350
Wire Wire Line
	18500 8350 18600 8350
Wire Wire Line
	18600 8350 18700 8350
Wire Wire Line
	18700 8350 18800 8350
Wire Wire Line
	18800 8350 18900 8350
Wire Wire Line
	18900 8350 19000 8350
Wire Wire Line
	19000 8350 19000 8250
Wire Wire Line
	17800 8250 17800 8350
Connection ~ 17800 8350
Wire Wire Line
	17900 8250 17900 8350
Connection ~ 17900 8350
Wire Wire Line
	18000 8250 18000 8350
Connection ~ 18000 8350
Wire Wire Line
	18100 8250 18100 8350
Connection ~ 18100 8350
Wire Wire Line
	18200 8250 18200 8350
Connection ~ 18200 8350
Wire Wire Line
	18300 8250 18300 8350
Wire Wire Line
	18300 8350 18300 8450
Connection ~ 18300 8350
Wire Wire Line
	18400 8250 18400 8350
Connection ~ 18400 8350
Wire Wire Line
	18500 8250 18500 8350
Connection ~ 18500 8350
Wire Wire Line
	18600 8250 18600 8350
Connection ~ 18600 8350
Wire Wire Line
	18700 8250 18700 8350
Connection ~ 18700 8350
Wire Wire Line
	18800 8250 18800 8350
Connection ~ 18800 8350
Wire Wire Line
	18900 8250 18900 8350
Connection ~ 18900 8350
Wire Wire Line
	3950 8150 4050 8150
Wire Wire Line
	3950 2300 3950 2800
Wire Wire Line
	3950 2800 3950 3300
Wire Wire Line
	3950 3300 3950 3800
Wire Wire Line
	3950 3800 3950 4400
Wire Wire Line
	3950 4400 3950 5100
Wire Wire Line
	3950 5100 3950 5750
Wire Wire Line
	3950 5750 3950 6250
Wire Wire Line
	3950 6250 3950 7050
Wire Wire Line
	3950 7050 3950 7550
Wire Wire Line
	3950 7550 3950 8050
Wire Wire Line
	3950 8050 3950 8150
Wire Wire Line
	3950 8150 3950 8500
Wire Wire Line
	4050 8050 3950 8050
Connection ~ 3950 8150
Wire Wire Line
	4050 7550 3950 7550
Connection ~ 3950 8050
Wire Wire Line
	5500 8150 5400 8150
Wire Wire Line
	5500 8050 5400 8050
Connection ~ 5500 8150
Wire Wire Line
	5500 7050 5400 7050
Connection ~ 5500 8050
Wire Wire Line
	5500 7550 5400 7550
Connection ~ 5500 7550
Wire Wire Line
	4050 7050 3950 7050
Connection ~ 3950 7550
Wire Wire Line
	4050 5750 3950 5750
Connection ~ 3950 7050
Wire Wire Line
	5500 5750 5400 5750
Connection ~ 5500 7050
Wire Wire Line
	5500 6250 5400 6250
Connection ~ 5500 6250
Wire Wire Line
	4050 6250 3950 6250
Connection ~ 3950 6250
Wire Wire Line
	5500 5100 5400 5100
Connection ~ 5500 5750
Wire Wire Line
	5500 4400 5400 4400
Wire Wire Line
	5500 2200 5500 2300
Wire Wire Line
	5500 2300 5500 2800
Wire Wire Line
	5500 2800 5500 3300
Wire Wire Line
	5500 3300 5500 3800
Wire Wire Line
	5500 3800 5500 4400
Wire Wire Line
	5500 4400 5500 5100
Wire Wire Line
	5500 5100 5500 5750
Wire Wire Line
	5500 5750 5500 6250
Wire Wire Line
	5500 6250 5500 7050
Wire Wire Line
	5500 7050 5500 7550
Wire Wire Line
	5500 7550 5500 8050
Wire Wire Line
	5500 8050 5500 8150
Wire Wire Line
	5500 8150 5500 8500
Connection ~ 5500 5100
Wire Wire Line
	5400 3800 5500 3800
Connection ~ 5500 4400
Wire Wire Line
	5400 3300 5500 3300
Connection ~ 5500 3800
Wire Wire Line
	5400 2800 5500 2800
Connection ~ 5500 3300
Wire Wire Line
	5400 2300 5500 2300
Connection ~ 5500 2800
Wire Wire Line
	5400 2200 5500 2200
Connection ~ 5500 2300
Wire Wire Line
	4050 2300 3950 2300
Connection ~ 3950 5750
Wire Wire Line
	4050 5100 3950 5100
Connection ~ 3950 5100
Wire Wire Line
	4050 4400 3950 4400
Connection ~ 3950 4400
Wire Wire Line
	4050 3800 3950 3800
Connection ~ 3950 3800
Wire Wire Line
	4050 3300 3950 3300
Connection ~ 3950 3300
Wire Wire Line
	4050 2800 3950 2800
Connection ~ 3950 2800
Wire Wire Line
	3850 8350 4050 8350
Wire Wire Line
	3850 1600 3850 1700
Wire Wire Line
	3850 1700 3850 4200
Wire Wire Line
	3850 4200 3850 8350
Wire Wire Line
	3850 4200 4050 4200
Wire Wire Line
	3850 1700 4050 1700
Connection ~ 3850 4200
Wire Wire Line
	2600 1600 3050 1600
Wire Wire Line
	3050 1600 3850 1600
Wire Wire Line
	3850 1600 4050 1600
Connection ~ 3850 1700
Wire Wire Line
	5600 8350 5400 8350
Wire Wire Line
	5600 1600 5600 1700
Wire Wire Line
	5600 1700 5600 4200
Wire Wire Line
	5600 4200 5600 8350
Wire Wire Line
	5600 4200 5400 4200
Wire Wire Line
	5600 1700 5400 1700
Connection ~ 5600 4200
Wire Wire Line
	5400 1600 5600 1600
Wire Wire Line
	5600 1600 6000 1600
Wire Wire Line
	6000 1600 6100 1600
Connection ~ 5600 1700
Wire Wire Line
	3300 7150 4050 7150
Wire Bus Line
	3200 7250 3200 7350
Wire Bus Line
	3200 7350 3200 7450
Wire Bus Line
	3200 7450 3200 7550
Wire Bus Line
	3200 7550 3200 7750
Wire Bus Line
	3200 7750 3200 7850
Wire Bus Line
	3200 7850 3200 7950
Wire Bus Line
	3200 7950 3200 8050
Wire Bus Line
	3200 8050 3200 9900
Wire Bus Line
	3200 9900 3200 10000
Wire Bus Line
	3200 10000 3200 10100
Wire Bus Line
	3200 10100 3200 10200
Wire Bus Line
	3200 10200 3200 10300
Wire Bus Line
	3200 10300 3200 10400
Wire Bus Line
	3200 10400 3200 10500
Wire Bus Line
	3200 10500 3200 10600
Wire Wire Line
	3300 7250 4050 7250
Wire Wire Line
	3300 7350 4050 7350
Wire Wire Line
	3300 7450 4050 7450
Wire Wire Line
	3300 7650 4050 7650
Wire Wire Line
	3300 7750 4050 7750
Wire Wire Line
	3300 7850 4050 7850
Wire Wire Line
	3300 7950 4050 7950
Wire Wire Line
	5400 7150 6150 7150
Wire Wire Line
	5400 7250 6150 7250
Wire Wire Line
	5400 7350 6150 7350
Wire Wire Line
	5400 7450 6150 7450
Wire Wire Line
	5400 7650 6150 7650
Wire Wire Line
	5400 7750 6150 7750
Wire Wire Line
	5400 7850 6150 7850
Wire Wire Line
	5400 7950 6150 7950
Wire Wire Line
	3300 6650 4050 6650
Wire Wire Line
	3300 6750 4050 6750
Wire Wire Line
	3300 6850 4050 6850
Wire Wire Line
	3300 6950 4050 6950
Wire Wire Line
	3300 6350 4050 6350
Wire Wire Line
	3300 6450 4050 6450
Wire Wire Line
	3300 6550 4050 6550
Wire Wire Line
	5400 6650 6150 6650
Wire Wire Line
	5400 6750 6150 6750
Wire Wire Line
	5400 6850 6150 6850
Wire Wire Line
	5400 6950 6150 6950
Wire Wire Line
	5400 6350 6150 6350
Wire Wire Line
	5400 6450 6150 6450
Wire Wire Line
	5400 6550 6150 6550
Wire Wire Line
	3100 6150 4050 6150
Wire Wire Line
	3100 5850 4050 5850
Wire Wire Line
	3100 5950 4050 5950
Wire Wire Line
	3100 6050 4050 6050
Wire Wire Line
	3100 5650 4050 5650
Wire Wire Line
	3100 5350 4050 5350
Wire Wire Line
	3100 5450 4050 5450
Wire Wire Line
	3100 5550 4050 5550
Wire Wire Line
	5400 6150 6150 6150
Wire Wire Line
	5400 5850 6150 5850
Wire Wire Line
	5400 5950 6150 5950
Wire Wire Line
	5400 6050 6150 6050
Wire Wire Line
	5400 5650 6150 5650
Wire Wire Line
	5400 5350 6150 5350
Wire Wire Line
	5400 5450 6150 5450
Wire Wire Line
	5400 5550 6150 5550
Wire Wire Line
	3300 5000 4050 5000
Wire Wire Line
	3300 4700 4050 4700
Wire Wire Line
	3300 4800 4050 4800
Wire Wire Line
	3300 4900 4050 4900
Wire Wire Line
	3300 4600 4050 4600
Wire Wire Line
	5400 5000 6150 5000
Wire Wire Line
	5400 4700 6150 4700
Wire Wire Line
	5400 4800 6150 4800
Wire Wire Line
	5400 4900 6150 4900
Wire Wire Line
	5400 4600 6150 4600
Wire Wire Line
	3300 2200 4050 2200
Wire Wire Line
	19950 12000 19550 12000
Wire Wire Line
	19950 12100 19550 12100
Wire Wire Line
	19950 12200 19550 12200
Wire Wire Line
	19950 12300 19550 12300
Wire Wire Line
	19950 12400 19550 12400
Wire Wire Line
	19950 12500 19550 12500
Wire Wire Line
	19950 12600 19550 12600
Wire Wire Line
	19950 12700 19550 12700
Wire Wire Line
	19950 12800 19550 12800
Wire Wire Line
	19950 12900 19550 12900
Wire Wire Line
	19950 13000 19550 13000
Wire Wire Line
	19950 13100 19550 13100
Wire Wire Line
	19950 13200 19550 13200
Wire Wire Line
	19950 13350 19550 13350
Wire Wire Line
	19950 13450 19550 13450
Wire Wire Line
	19950 13600 19550 13600
Wire Wire Line
	19950 13700 19550 13700
Wire Wire Line
	19950 13850 19550 13850
Wire Wire Line
	19950 13950 19550 13950
Wire Wire Line
	19950 14050 19550 14050
Wire Wire Line
	19950 14200 19550 14200
Wire Wire Line
	21950 12000 21550 12000
Wire Wire Line
	21950 12100 21550 12100
Wire Wire Line
	21950 12200 21550 12200
Wire Wire Line
	21950 12300 21550 12300
Wire Wire Line
	21950 12400 21550 12400
Wire Wire Line
	21950 12500 21550 12500
Wire Wire Line
	21950 12600 21550 12600
Wire Wire Line
	21950 12700 21550 12700
Wire Wire Line
	21950 12800 21550 12800
Wire Wire Line
	21950 12900 21550 12900
Wire Wire Line
	21950 13000 21550 13000
Wire Wire Line
	21950 13100 21550 13100
Wire Wire Line
	21950 13200 21550 13200
Wire Wire Line
	21950 13300 21550 13300
Wire Wire Line
	21950 13400 21550 13400
Wire Wire Line
	21950 13500 21550 13500
Wire Wire Line
	21950 13750 21550 13750
Wire Wire Line
	21950 13850 21550 13850
Wire Wire Line
	21050 6350 20650 6350
Wire Wire Line
	21050 6550 20650 6550
Wire Wire Line
	21050 6650 20650 6650
Wire Wire Line
	21050 6750 20650 6750
Wire Wire Line
	21050 2350 20650 2350
Wire Wire Line
	21050 2450 20650 2450
Wire Wire Line
	21050 2550 20650 2550
Wire Wire Line
	21050 2650 20650 2650
Wire Wire Line
	21050 2750 20650 2750
Wire Wire Line
	21050 2850 20650 2850
Wire Wire Line
	21050 6250 20650 6250
Wire Wire Line
	21050 3050 20650 3050
Wire Wire Line
	21050 6050 20650 6050
Wire Wire Line
	21050 6150 20650 6150
Wire Wire Line
	21050 3350 20650 3350
Wire Wire Line
	21050 3150 20650 3150
Wire Wire Line
	21050 5850 20650 5850
Wire Wire Line
	21050 5750 20650 5750
Wire Wire Line
	21050 5650 20650 5650
Wire Wire Line
	21050 5950 20650 5950
Wire Wire Line
	21050 5150 20650 5150
Wire Wire Line
	21050 5050 20650 5050
Wire Wire Line
	21050 4950 20650 4950
Wire Wire Line
	21050 4750 20650 4750
Wire Wire Line
	21050 4650 20650 4650
Wire Wire Line
	21050 5250 20650 5250
Wire Wire Line
	21050 5350 20650 5350
Wire Wire Line
	21050 5450 20650 5450
Wire Wire Line
	21050 3650 20650 3650
Wire Wire Line
	21050 3850 20650 3850
Wire Wire Line
	21050 3950 20650 3950
Wire Wire Line
	21050 4150 20650 4150
Wire Wire Line
	21050 4250 20650 4250
Wire Wire Line
	21050 4350 20650 4350
Wire Wire Line
	21050 4450 20650 4450
Wire Wire Line
	21050 4550 20650 4550
Wire Wire Line
	21050 5550 20650 5550
Wire Wire Line
	21050 3550 20650 3550
Wire Wire Line
	3300 1800 4050 1800
Wire Wire Line
	20450 14450 20450 14550
Wire Wire Line
	20450 14550 20550 14550
Wire Wire Line
	20550 14550 20650 14550
Wire Wire Line
	20650 14550 20750 14550
Wire Wire Line
	20750 14550 20850 14550
Wire Wire Line
	20850 14550 20950 14550
Wire Wire Line
	20950 14550 21050 14550
Wire Wire Line
	21050 14550 21050 14450
Connection ~ 20750 14550
Wire Wire Line
	20750 14450 20750 14550
Wire Wire Line
	20650 14450 20650 14550
Connection ~ 20650 14550
Wire Wire Line
	20550 14450 20550 14550
Connection ~ 20550 14550
Wire Wire Line
	20850 14450 20850 14550
Connection ~ 20850 14550
Wire Wire Line
	20950 14450 20950 14550
Connection ~ 20950 14550
Wire Wire Line
	20450 11350 20450 11750
Wire Wire Line
	19150 11350 19550 11350
Wire Wire Line
	19550 11350 19900 11350
Wire Wire Line
	19900 11350 20450 11350
Wire Wire Line
	20450 11350 20550 11350
Wire Wire Line
	20550 11350 20650 11350
Wire Wire Line
	20650 11350 20750 11350
Wire Wire Line
	20750 11350 20850 11350
Wire Wire Line
	20850 11350 20950 11350
Wire Wire Line
	20950 11350 21050 11350
Wire Wire Line
	21050 11350 21350 11350
Wire Wire Line
	21350 11350 21700 11350
Wire Wire Line
	21700 11350 22050 11350
Wire Wire Line
	21050 11350 21050 11750
Wire Wire Line
	20950 11750 20950 11350
Connection ~ 20950 11350
Wire Wire Line
	20850 11750 20850 11350
Connection ~ 20850 11350
Wire Wire Line
	20750 11750 20750 11350
Connection ~ 20750 11350
Wire Wire Line
	20650 11750 20650 11350
Connection ~ 20650 11350
Wire Wire Line
	20550 11750 20550 11350
Connection ~ 20550 11350
Connection ~ 20450 11350
Wire Wire Line
	16600 1350 16600 1450
Wire Wire Line
	14450 1350 14950 1350
Wire Wire Line
	14950 1350 15100 1350
Wire Wire Line
	15100 1350 15400 1350
Wire Wire Line
	15400 1350 15700 1350
Wire Wire Line
	15700 1350 16000 1350
Wire Wire Line
	16000 1350 16600 1350
Wire Wire Line
	16600 1350 16700 1350
Wire Wire Line
	16700 1350 16800 1350
Wire Wire Line
	16800 1350 16900 1350
Wire Wire Line
	16900 1350 17000 1350
Wire Wire Line
	17000 1350 17100 1350
Wire Wire Line
	17100 1350 17200 1350
Wire Wire Line
	17200 1350 17300 1350
Wire Wire Line
	17300 1350 17400 1350
Wire Wire Line
	17400 1350 17500 1350
Wire Wire Line
	17500 1350 17600 1350
Wire Wire Line
	17600 1350 17700 1350
Wire Wire Line
	17900 1350 18000 1350
Wire Wire Line
	18000 1350 18100 1350
Wire Wire Line
	18100 1350 18200 1350
Wire Wire Line
	18200 1350 18300 1350
Wire Wire Line
	18300 1350 18400 1350
Wire Wire Line
	18400 1350 18500 1350
Wire Wire Line
	18500 1350 18550 1350
Wire Wire Line
	17700 1350 17700 1450
Wire Wire Line
	17600 1450 17600 1350
Connection ~ 17600 1350
Wire Wire Line
	17500 1450 17500 1350
Connection ~ 17500 1350
Wire Wire Line
	17400 1450 17400 1350
Connection ~ 17400 1350
Wire Wire Line
	17300 1450 17300 1350
Connection ~ 17300 1350
Wire Wire Line
	17200 1450 17200 1350
Connection ~ 17200 1350
Wire Wire Line
	17100 1450 17100 1350
Connection ~ 17100 1350
Wire Wire Line
	17000 1450 17000 1350
Connection ~ 17000 1350
Wire Wire Line
	16900 1450 16900 1350
Connection ~ 16900 1350
Wire Wire Line
	16800 1450 16800 1350
Connection ~ 16800 1350
Wire Wire Line
	16700 1450 16700 1350
Connection ~ 16700 1350
Wire Wire Line
	17900 1350 17900 1450
Wire Wire Line
	18500 850  18500 1350
Wire Wire Line
	18500 1350 18500 1450
Wire Wire Line
	18400 1450 18400 1350
Connection ~ 18400 1350
Wire Wire Line
	18300 1450 18300 1350
Connection ~ 18300 1350
Wire Wire Line
	18200 1450 18200 1350
Connection ~ 18200 1350
Wire Wire Line
	18100 1450 18100 1350
Connection ~ 18100 1350
Wire Wire Line
	18000 1450 18000 1350
Connection ~ 18000 1350
Wire Wire Line
	18800 850  18800 1350
Wire Wire Line
	18800 1350 18800 1450
Wire Wire Line
	19600 1350 19600 1450
Connection ~ 19600 1350
Wire Wire Line
	19500 1350 19500 1450
Connection ~ 19500 1350
Wire Wire Line
	19400 1350 19400 1450
Connection ~ 19400 1350
Wire Wire Line
	19300 1350 19300 1450
Connection ~ 19300 1350
Wire Wire Line
	19200 1350 19200 1450
Connection ~ 19200 1350
Wire Wire Line
	19100 1350 19100 1450
Connection ~ 19100 1350
Wire Wire Line
	19000 1350 19000 1450
Connection ~ 19000 1350
Wire Wire Line
	18900 1350 18900 1450
Connection ~ 18900 1350
Wire Wire Line
	19700 1350 19700 1450
Wire Wire Line
	16050 3350 14300 3350
Wire Wire Line
	16050 3550 14300 3550
Wire Wire Line
	16050 3650 14300 3650
Wire Wire Line
	16050 3750 14300 3750
Wire Bus Line
	6250 7250 6250 7350
Wire Bus Line
	6250 7350 6250 7450
Wire Bus Line
	6250 7450 6250 7550
Wire Bus Line
	6250 7550 6250 7750
Wire Bus Line
	6250 7750 6250 7850
Wire Bus Line
	6250 7850 6250 7950
Wire Bus Line
	6250 7950 6250 8050
Wire Bus Line
	6250 8050 6250 8150
Wire Bus Line
	6600 6450 6600 6550
Wire Bus Line
	6600 6550 6600 6650
Wire Bus Line
	6600 6650 6600 6750
Wire Bus Line
	6600 6750 6600 6850
Wire Bus Line
	6600 6850 6600 6950
Wire Bus Line
	6600 6950 6600 7050
Wire Bus Line
	6600 7050 6600 7150
Wire Bus Line
	6600 7150 6600 8150
Wire Bus Line
	6350 8250 6500 8250
Wire Wire Line
	6700 6350 7450 6350
Wire Wire Line
	6700 6450 7450 6450
Wire Wire Line
	6700 6550 7450 6550
Wire Wire Line
	6700 6650 7450 6650
Wire Wire Line
	6700 6750 7450 6750
Wire Wire Line
	6700 6850 7450 6850
Wire Wire Line
	6700 6950 7450 6950
Wire Wire Line
	6700 7050 7450 7050
Wire Bus Line
	6250 5150 6250 5250
Wire Bus Line
	6250 5250 6250 5350
Wire Bus Line
	6250 5350 6250 5450
Wire Bus Line
	6250 5450 6250 5550
Wire Bus Line
	6250 5550 6250 5750
Wire Bus Line
	6250 5750 6250 5850
Wire Bus Line
	6250 5850 6250 5950
Wire Bus Line
	6250 5950 6250 6050
Wire Wire Line
	6700 5550 7450 5550
Wire Wire Line
	6700 5250 7450 5250
Wire Wire Line
	6700 5350 7450 5350
Wire Wire Line
	6700 5450 7450 5450
Wire Wire Line
	6700 5950 7450 5950
Wire Wire Line
	6700 5650 7450 5650
Wire Wire Line
	6700 5750 7450 5750
Wire Wire Line
	6700 5850 7450 5850
Wire Bus Line
	6600 5150 6600 5250
Wire Bus Line
	6600 5250 6600 5350
Wire Bus Line
	6600 5350 6600 5450
Wire Bus Line
	6600 5450 6600 5550
Wire Bus Line
	6600 5550 6600 5650
Wire Bus Line
	6600 5650 6600 5750
Wire Bus Line
	6600 5750 6600 5850
Wire Bus Line
	6350 5050 6500 5050
Wire Wire Line
	8950 5250 9750 5250
Wire Wire Line
	9750 5250 10650 5250
Wire Wire Line
	8950 5350 9650 5350
Wire Wire Line
	9650 5350 10650 5350
Wire Wire Line
	8950 5450 9550 5450
Wire Wire Line
	9550 5450 10650 5450
Wire Wire Line
	8950 5550 9450 5550
Wire Wire Line
	9450 5550 10650 5550
Wire Wire Line
	8950 5650 9350 5650
Wire Wire Line
	9350 5650 10650 5650
Wire Wire Line
	8950 5750 9250 5750
Wire Wire Line
	9250 5750 10650 5750
Wire Wire Line
	8950 5850 9150 5850
Wire Wire Line
	9150 5850 10650 5850
Wire Wire Line
	8950 5950 9050 5950
Wire Wire Line
	9050 5950 10650 5950
Wire Wire Line
	3300 10700 4050 10700
Wire Wire Line
	3300 10600 4050 10600
Wire Wire Line
	3300 10500 4050 10500
Wire Wire Line
	3300 10400 4050 10400
Wire Wire Line
	3300 10300 4050 10300
Wire Wire Line
	3300 10200 4050 10200
Wire Wire Line
	3300 10100 4050 10100
Wire Wire Line
	3300 10000 4050 10000
Wire Wire Line
	3100 11100 4050 11100
Wire Wire Line
	3100 11400 4050 11400
Wire Wire Line
	3100 11300 4050 11300
Wire Wire Line
	3100 11200 4050 11200
Wire Wire Line
	3100 11500 4050 11500
Wire Wire Line
	3100 11800 4050 11800
Wire Wire Line
	3100 11700 4050 11700
Wire Wire Line
	3100 11600 4050 11600
Wire Bus Line
	3000 5450 3000 5550
Wire Bus Line
	3000 5550 3000 5650
Wire Bus Line
	3000 5650 3000 5750
Wire Bus Line
	3000 5750 3000 5950
Wire Bus Line
	3000 5950 3000 6050
Wire Bus Line
	3000 6050 3000 6150
Wire Bus Line
	3000 6150 3000 6250
Wire Bus Line
	3000 6250 3000 11000
Wire Bus Line
	3000 11000 3000 11100
Wire Bus Line
	3000 11100 3000 11200
Wire Bus Line
	3000 11200 3000 11300
Wire Bus Line
	3000 11300 3000 11400
Wire Bus Line
	3000 11400 3000 11500
Wire Bus Line
	3000 11500 3000 11600
Wire Bus Line
	3000 11600 3000 11700
Wire Wire Line
	5550 11100 5650 11100
Wire Wire Line
	5650 11100 5650 10000
Wire Wire Line
	5550 10000 5650 10000
Wire Wire Line
	5650 10000 7250 10000
Connection ~ 5650 10000
Wire Wire Line
	5550 10100 5750 10100
Wire Wire Line
	5750 10100 7250 10100
Wire Wire Line
	5550 10200 5850 10200
Wire Wire Line
	5850 10200 7250 10200
Wire Wire Line
	5550 10300 5950 10300
Wire Wire Line
	5950 10300 7250 10300
Wire Wire Line
	5550 10400 6050 10400
Wire Wire Line
	6050 10400 7250 10400
Wire Wire Line
	5550 10500 6150 10500
Wire Wire Line
	6150 10500 7250 10500
Wire Wire Line
	5550 10600 6250 10600
Wire Wire Line
	6250 10600 7250 10600
Wire Wire Line
	5550 10700 6350 10700
Wire Wire Line
	6350 10700 7250 10700
Wire Wire Line
	5750 11200 5550 11200
Connection ~ 5750 10100
Wire Wire Line
	5850 10200 5850 11300
Wire Wire Line
	5850 11300 5550 11300
Connection ~ 5850 10200
Wire Wire Line
	5950 10300 5950 11400
Wire Wire Line
	5950 11400 5550 11400
Connection ~ 5950 10300
Wire Wire Line
	6050 10400 6050 11500
Wire Wire Line
	6050 11500 5550 11500
Connection ~ 6050 10400
Wire Wire Line
	6150 10500 6150 11600
Wire Wire Line
	6150 11600 5550 11600
Connection ~ 6150 10500
Wire Wire Line
	6250 10600 6250 11700
Wire Wire Line
	6250 11700 5550 11700
Connection ~ 6250 10600
Wire Wire Line
	6350 10700 6350 11800
Wire Wire Line
	6350 11800 5550 11800
Connection ~ 6350 10700
Wire Wire Line
	5750 11200 5750 10100
Wire Wire Line
	15300 4550 16050 4550
Wire Wire Line
	15300 4650 16050 4650
Wire Wire Line
	15300 4750 16050 4750
Wire Wire Line
	15300 4850 16050 4850
Wire Wire Line
	15300 4950 16050 4950
Wire Wire Line
	15300 5150 16050 5150
Wire Wire Line
	15300 5250 16050 5250
Wire Wire Line
	15300 5350 16050 5350
Wire Wire Line
	20650 7350 21400 7350
Wire Wire Line
	20650 7450 21400 7450
Wire Wire Line
	20650 7550 21400 7550
Wire Wire Line
	20650 7650 21400 7650
Wire Wire Line
	15300 7650 16050 7650
Wire Wire Line
	15300 7550 16050 7550
Wire Wire Line
	15300 7450 16050 7450
Wire Wire Line
	15300 7350 16050 7350
Wire Wire Line
	6950 4750 7350 4750
Wire Wire Line
	7350 4750 7450 4750
Wire Wire Line
	7450 4850 7350 4850
Wire Wire Line
	7350 4850 7350 4750
Connection ~ 7350 4750
Wire Wire Line
	7850 7650 7850 7750
Wire Wire Line
	7850 7750 7950 7750
Wire Wire Line
	7950 7750 8050 7750
Wire Wire Line
	8050 7750 8150 7750
Wire Wire Line
	8150 7750 8200 7750
Wire Wire Line
	8200 7750 8250 7750
Wire Wire Line
	8250 7750 8350 7750
Wire Wire Line
	8350 7750 8450 7750
Wire Wire Line
	8450 7750 8550 7750
Wire Wire Line
	8550 7750 8550 7650
Wire Wire Line
	8450 7650 8450 7750
Connection ~ 8450 7750
Wire Wire Line
	8350 7650 8350 7750
Connection ~ 8350 7750
Wire Wire Line
	8250 7650 8250 7750
Connection ~ 8250 7750
Wire Wire Line
	8150 7650 8150 7750
Connection ~ 8150 7750
Wire Wire Line
	8050 7650 8050 7750
Connection ~ 8050 7750
Wire Wire Line
	7950 7650 7950 7750
Connection ~ 7950 7750
Wire Wire Line
	8200 7800 8200 7750
Connection ~ 8200 7750
Wire Wire Line
	8950 5050 9650 5050
Wire Wire Line
	8950 6250 10400 6250
Wire Wire Line
	8950 5150 9500 5150
Wire Wire Line
	8950 6150 10400 6150
Wire Wire Line
	5550 11000 7000 11000
Wire Wire Line
	5550 10900 7000 10900
Wire Wire Line
	5550 9800 6250 9800
Wire Wire Line
	5550 9900 6100 9900
Wire Wire Line
	3550 9500 3650 9500
Wire Wire Line
	3650 9500 3950 9500
Wire Wire Line
	3950 9500 4050 9500
Wire Wire Line
	4050 9600 3950 9600
Wire Wire Line
	3950 9600 3950 9500
Connection ~ 3950 9500
Wire Wire Line
	5550 9500 5650 9500
Wire Wire Line
	5650 9500 6400 9500
Wire Wire Line
	5550 9600 5650 9600
Wire Wire Line
	5650 9600 5650 9500
Connection ~ 5650 9500
Wire Wire Line
	8950 4750 9050 4750
Wire Wire Line
	9050 4750 9800 4750
Wire Wire Line
	8950 4850 9050 4850
Wire Wire Line
	9050 4850 9050 4750
Connection ~ 9050 4750
Wire Wire Line
	15300 4450 16050 4450
Wire Wire Line
	15300 5450 16050 5450
Wire Wire Line
	15300 5550 16050 5550
Wire Wire Line
	6700 2700 7450 2700
Wire Wire Line
	6700 2300 7450 2300
Wire Wire Line
	6950 13900 7700 13900
Wire Wire Line
	6950 14000 7700 14000
Wire Wire Line
	6700 3000 7450 3000
Wire Wire Line
	6700 2900 7450 2900
Wire Wire Line
	6700 2800 7450 2800
Wire Wire Line
	6700 1900 7450 1900
Wire Wire Line
	6700 1800 7450 1800
Wire Wire Line
	6700 1700 7450 1700
Wire Wire Line
	6700 1600 7450 1600
Wire Wire Line
	6700 2200 7450 2200
Wire Wire Line
	6700 2100 7450 2100
Wire Wire Line
	6700 2000 7450 2000
Wire Wire Line
	6950 12200 7700 12200
Wire Wire Line
	6700 3200 7450 3200
Wire Wire Line
	6700 3300 7450 3300
Wire Wire Line
	6700 3400 7450 3400
Wire Wire Line
	6700 3100 7450 3100
Wire Wire Line
	6950 12900 7700 12900
Wire Wire Line
	6950 12700 7700 12700
Wire Wire Line
	6950 12400 7700 12400
Wire Wire Line
	6950 12500 7700 12500
Wire Wire Line
	6950 12600 7700 12600
Wire Wire Line
	6950 12300 7700 12300
Wire Wire Line
	6950 12800 7700 12800
Wire Wire Line
	8950 2700 9700 2700
Wire Wire Line
	8950 2300 9700 2300
Wire Wire Line
	8950 3000 9700 3000
Wire Wire Line
	8950 2900 9700 2900
Wire Wire Line
	8950 2800 9700 2800
Wire Wire Line
	8950 1900 9700 1900
Wire Wire Line
	8950 1800 9700 1800
Wire Wire Line
	8950 1700 9700 1700
Wire Wire Line
	8950 1600 9700 1600
Wire Wire Line
	8950 2200 9700 2200
Wire Wire Line
	8950 2100 9700 2100
Wire Wire Line
	8950 2000 9700 2000
Wire Wire Line
	8950 3200 9700 3200
Wire Wire Line
	8950 3300 9700 3300
Wire Wire Line
	8950 3400 9700 3400
Wire Wire Line
	8950 3100 9700 3100
Wire Wire Line
	9200 12200 9950 12200
Wire Wire Line
	9200 12900 9950 12900
Wire Wire Line
	9200 12700 9950 12700
Wire Wire Line
	9200 12400 9950 12400
Wire Wire Line
	9200 12500 9950 12500
Wire Wire Line
	9200 12600 9950 12600
Wire Wire Line
	9200 12300 9950 12300
Wire Wire Line
	9200 12800 9950 12800
Wire Wire Line
	8950 1400 9050 1400
Wire Wire Line
	9050 1400 9650 1400
Wire Wire Line
	8950 1500 9050 1500
Wire Wire Line
	9050 1500 9050 1400
Connection ~ 9050 1400
Wire Wire Line
	8950 2500 9050 2500
Wire Wire Line
	9050 2500 9650 2500
Wire Wire Line
	8950 2600 9050 2600
Wire Wire Line
	9050 2600 9050 2500
Connection ~ 9050 2500
Wire Wire Line
	9200 12000 9300 12000
Wire Wire Line
	9300 12000 9900 12000
Wire Wire Line
	9200 12100 9300 12100
Wire Wire Line
	9300 12100 9300 12000
Connection ~ 9300 12000
Wire Wire Line
	9200 13200 9900 13200
Wire Wire Line
	9200 13100 9600 13100
Wire Wire Line
	9200 13900 9950 13900
Wire Wire Line
	9200 14000 9950 14000
Wire Wire Line
	7200 11700 7300 11700
Wire Wire Line
	7300 11700 7600 11700
Wire Wire Line
	7600 11700 7700 11700
Wire Wire Line
	7700 11800 7600 11800
Wire Wire Line
	7600 11800 7600 11700
Connection ~ 7600 11700
Wire Wire Line
	6950 1100 7000 1100
Wire Wire Line
	7000 1100 7350 1100
Wire Wire Line
	7350 1100 7450 1100
Wire Wire Line
	7450 1200 7350 1200
Wire Wire Line
	7350 1200 7350 1100
Connection ~ 7350 1100
Wire Wire Line
	8950 1100 9050 1100
Wire Wire Line
	9050 1100 9900 1100
Wire Wire Line
	8950 1200 9050 1200
Wire Wire Line
	9050 1200 9050 1100
Connection ~ 9050 1100
Wire Wire Line
	9200 11700 9300 11700
Wire Wire Line
	9300 11700 10100 11700
Wire Wire Line
	9200 11800 9300 11800
Wire Wire Line
	9300 11800 9300 11700
Connection ~ 9300 11700
Wire Wire Line
	7850 4000 7850 4100
Wire Wire Line
	7850 4100 7950 4100
Wire Wire Line
	7950 4100 8050 4100
Wire Wire Line
	8050 4100 8150 4100
Wire Wire Line
	8150 4100 8200 4100
Wire Wire Line
	8200 4100 8250 4100
Wire Wire Line
	8250 4100 8350 4100
Wire Wire Line
	8350 4100 8450 4100
Wire Wire Line
	8450 4100 8550 4100
Wire Wire Line
	8550 4100 8550 4000
Wire Wire Line
	8450 4000 8450 4100
Connection ~ 8450 4100
Wire Wire Line
	8350 4000 8350 4100
Connection ~ 8350 4100
Wire Wire Line
	8250 4000 8250 4100
Connection ~ 8250 4100
Wire Wire Line
	8150 4000 8150 4100
Connection ~ 8150 4100
Wire Wire Line
	8050 4000 8050 4100
Connection ~ 8050 4100
Wire Wire Line
	7950 4000 7950 4100
Connection ~ 7950 4100
Wire Wire Line
	8200 4150 8200 4100
Connection ~ 8200 4100
Wire Wire Line
	8100 14600 8100 14700
Wire Wire Line
	8100 14700 8200 14700
Wire Wire Line
	8200 14700 8300 14700
Wire Wire Line
	8300 14700 8400 14700
Wire Wire Line
	8400 14700 8450 14700
Wire Wire Line
	8450 14700 8500 14700
Wire Wire Line
	8500 14700 8600 14700
Wire Wire Line
	8600 14700 8700 14700
Wire Wire Line
	8700 14700 8800 14700
Wire Wire Line
	8800 14700 8800 14600
Wire Wire Line
	8700 14600 8700 14700
Connection ~ 8700 14700
Wire Wire Line
	8600 14600 8600 14700
Connection ~ 8600 14700
Wire Wire Line
	8500 14600 8500 14700
Connection ~ 8500 14700
Wire Wire Line
	8400 14600 8400 14700
Connection ~ 8400 14700
Wire Wire Line
	8300 14600 8300 14700
Connection ~ 8300 14700
Wire Wire Line
	8200 14600 8200 14700
Connection ~ 8200 14700
Wire Wire Line
	8450 14750 8450 14700
Connection ~ 8450 14700
Wire Wire Line
	9200 13800 9300 13800
Wire Wire Line
	9300 13800 10250 13800
Wire Wire Line
	9200 13300 9300 13300
Wire Wire Line
	9300 13300 9300 13400
Wire Wire Line
	9300 13400 9300 13500
Wire Wire Line
	9300 13500 9300 13600
Wire Wire Line
	9300 13600 9300 13700
Wire Wire Line
	9300 13700 9300 13800
Connection ~ 9300 13800
Wire Wire Line
	9200 13700 9300 13700
Connection ~ 9300 13700
Wire Wire Line
	9200 13600 9300 13600
Connection ~ 9300 13600
Wire Wire Line
	9200 13500 9300 13500
Connection ~ 9300 13500
Wire Wire Line
	9200 13400 9300 13400
Connection ~ 9300 13400
Wire Wire Line
	4450 12400 4450 12500
Wire Wire Line
	4450 12500 4550 12500
Wire Wire Line
	4550 12500 4650 12500
Wire Wire Line
	4650 12500 4750 12500
Wire Wire Line
	4750 12500 4800 12500
Wire Wire Line
	4800 12500 4850 12500
Wire Wire Line
	4850 12500 4950 12500
Wire Wire Line
	4950 12500 5050 12500
Wire Wire Line
	5050 12500 5150 12500
Wire Wire Line
	5150 12500 5150 12400
Wire Wire Line
	5050 12400 5050 12500
Connection ~ 5050 12500
Wire Wire Line
	4950 12400 4950 12500
Connection ~ 4950 12500
Wire Wire Line
	4850 12400 4850 12500
Connection ~ 4850 12500
Wire Wire Line
	4750 12400 4750 12500
Connection ~ 4750 12500
Wire Wire Line
	4650 12400 4650 12500
Connection ~ 4650 12500
Wire Wire Line
	4550 12400 4550 12500
Connection ~ 4550 12500
Wire Wire Line
	4800 12550 4800 12500
Connection ~ 4800 12500
Wire Wire Line
	15300 6850 16050 6850
Wire Wire Line
	15300 7050 16050 7050
Wire Wire Line
	15300 7150 16050 7150
Wire Wire Line
	15300 7250 16050 7250
Wire Wire Line
	15300 5850 16050 5850
Wire Wire Line
	15300 5750 16050 5750
Wire Wire Line
	15300 5650 16050 5650
Wire Wire Line
	15300 5950 16050 5950
Wire Wire Line
	15300 6350 16050 6350
Wire Wire Line
	15300 6450 16050 6450
Wire Wire Line
	15300 6050 16050 6050
Wire Wire Line
	15300 6150 16050 6150
Wire Wire Line
	15300 6250 16050 6250
Wire Wire Line
	15300 6550 16050 6550
Wire Wire Line
	15300 6650 16050 6650
Wire Wire Line
	15300 6750 16050 6750
Wire Wire Line
	15300 2850 16050 2850
Wire Wire Line
	15300 4350 16050 4350
Wire Wire Line
	15300 3850 16050 3850
Wire Wire Line
	15300 3050 16050 3050
Wire Wire Line
	15300 3150 16050 3150
Wire Wire Line
	15300 3450 16050 3450
Wire Wire Line
	15300 2950 16050 2950
Wire Wire Line
	15300 3950 16050 3950
Wire Wire Line
	15300 4050 16050 4050
Wire Wire Line
	15300 4150 16050 4150
Wire Wire Line
	12700 2050 12700 2350
Wire Wire Line
	12700 2350 12700 2650
Wire Wire Line
	12700 2350 12600 2350
Wire Wire Line
	12700 2050 12600 2050
Connection ~ 12700 2350
Wire Wire Line
	14100 1850 13100 1850
Wire Wire Line
	13100 1850 12600 1850
Wire Wire Line
	14000 1950 13300 1950
Wire Wire Line
	13300 1950 12600 1950
Wire Wire Line
	12600 2250 13900 2250
Wire Wire Line
	12600 2150 12800 2150
Wire Wire Line
	12600 1750 12900 1750
Wire Wire Line
	12900 1150 12900 1250
Connection ~ 12900 1150
Wire Wire Line
	13100 1150 13100 1250
Connection ~ 13100 1150
Wire Wire Line
	13100 1550 13100 1850
Connection ~ 13100 1850
Wire Wire Line
	13300 1150 13300 1250
Connection ~ 13300 1150
Wire Wire Line
	13300 1550 13300 1950
Connection ~ 13300 1950
Wire Wire Line
	13500 1250 13500 1150
Connection ~ 13500 1150
Wire Wire Line
	13500 1550 13500 2450
Connection ~ 13500 2450
Wire Wire Line
	13700 1250 13700 1150
Wire Wire Line
	13700 1550 13700 2550
Wire Wire Line
	13700 2550 12600 2550
Wire Wire Line
	10800 2350 10700 2350
Wire Wire Line
	10700 2250 10700 2350
Wire Wire Line
	10700 2350 10700 2450
Wire Wire Line
	10800 2250 10700 2250
Connection ~ 10700 2350
Connection ~ 12800 1150
Wire Wire Line
	22050 11350 22050 11400
Connection ~ 21050 11350
Connection ~ 21700 11350
Wire Wire Line
	21350 11400 21350 11350
Connection ~ 21350 11350
Wire Wire Line
	19150 11350 19150 11400
Wire Wire Line
	19550 11400 19550 11350
Connection ~ 19550 11350
Wire Wire Line
	19900 11400 19900 11350
Connection ~ 19900 11350
Connection ~ 3850 1600
Connection ~ 5600 1600
Wire Wire Line
	12900 1750 12900 1550
Connection ~ 16600 1350
Connection ~ 19700 1350
Connection ~ 18800 1350
Connection ~ 18500 1350
Wire Wire Line
	15700 1400 15700 1350
Connection ~ 15700 1350
Wire Wire Line
	16000 1400 16000 1350
Wire Wire Line
	15100 1400 15100 1350
Wire Wire Line
	15400 1400 15400 1350
Wire Wire Line
	15700 1800 15700 1850
Wire Wire Line
	16000 1800 16000 1850
Wire Wire Line
	15100 1850 15100 1800
Wire Wire Line
	15400 1800 15400 1850
Wire Wire Line
	15700 850  15700 900 
Wire Wire Line
	16000 850  16000 900 
Wire Wire Line
	15100 900  15100 850 
Wire Wire Line
	15400 850  15400 900 
Wire Wire Line
	14950 850  14950 1350
Wire Wire Line
	14950 1350 14950 1800
Wire Wire Line
	14950 850  15100 850 
Wire Wire Line
	15100 850  15400 850 
Wire Wire Line
	15400 850  15700 850 
Wire Wire Line
	15700 850  16000 850 
Wire Wire Line
	14950 1800 15100 1800
Wire Wire Line
	15100 1800 15400 1800
Wire Wire Line
	15400 1800 15700 1800
Wire Wire Line
	15700 1800 16000 1800
Connection ~ 14950 1350
Wire Wire Line
	15100 850  15400 850 
Connection ~ 15400 850 
Connection ~ 15100 850 
Connection ~ 15700 850 
Wire Wire Line
	15400 1350 15100 1350
Connection ~ 15100 1350
Connection ~ 15400 1350
Connection ~ 15400 1800
Connection ~ 15100 1800
$Comp
L C_Small C26
U 1 1 553870EB
P 17400 1000
F 0 "C26" H 17410 1070 50  0000 L CNN
F 1 "0.1uF" H 17410 920 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 17400 1000 60  0001 C CNN
F 3 "" H 17400 1000 60  0000 C CNN
	1    17400 1000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR022
U 1 1 553870F1
P 17400 1100
F 0 "#PWR022" H 17400 850 50  0001 C CNN
F 1 "GND" H 17400 950 50  0001 C CNN
F 2 "" H 17400 1100 60  0000 C CNN
F 3 "" H 17400 1100 60  0000 C CNN
	1    17400 1100
	1    0    0    -1  
$EndComp
$Comp
L C_Small C28
U 1 1 553870F7
P 17700 1000
F 0 "C28" H 17710 1070 50  0000 L CNN
F 1 "0.1uF" H 17710 920 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 17700 1000 60  0001 C CNN
F 3 "" H 17700 1000 60  0000 C CNN
	1    17700 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	17400 850  17400 900 
Wire Wire Line
	17700 850  17700 900 
Wire Wire Line
	16800 850  17100 850 
Wire Wire Line
	17100 850  17400 850 
Wire Wire Line
	17400 850  17700 850 
Wire Wire Line
	17700 850  18000 850 
Wire Wire Line
	18000 850  18300 850 
Wire Wire Line
	18300 850  18500 850 
Wire Wire Line
	17700 850  17400 850 
Connection ~ 17700 850 
Connection ~ 17400 850 
Connection ~ 18000 850 
$Comp
L C_Small C23
U 1 1 55387180
P 16800 1000
F 0 "C23" H 16810 1070 50  0000 L CNN
F 1 "0.1uF" H 16810 920 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 16800 1000 60  0001 C CNN
F 3 "" H 16800 1000 60  0000 C CNN
	1    16800 1000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR023
U 1 1 55387186
P 16800 1100
F 0 "#PWR023" H 16800 850 50  0001 C CNN
F 1 "GND" H 16800 950 50  0001 C CNN
F 2 "" H 16800 1100 60  0000 C CNN
F 3 "" H 16800 1100 60  0000 C CNN
	1    16800 1100
	1    0    0    -1  
$EndComp
$Comp
L C_Small C24
U 1 1 5538718C
P 17100 1000
F 0 "C24" H 17110 1070 50  0000 L CNN
F 1 "0.1uF" H 17110 920 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 17100 1000 60  0001 C CNN
F 3 "" H 17100 1000 60  0000 C CNN
	1    17100 1000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR024
U 1 1 55387192
P 17100 1100
F 0 "#PWR024" H 17100 850 50  0001 C CNN
F 1 "GND" H 17100 950 50  0001 C CNN
F 2 "" H 17100 1100 60  0000 C CNN
F 3 "" H 17100 1100 60  0000 C CNN
	1    17100 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	16800 900  16800 850 
Wire Wire Line
	17100 900  17100 850 
Connection ~ 17100 850 
Connection ~ 16800 850 
Wire Wire Line
	18000 850  18300 850 
Connection ~ 18300 850 
Wire Wire Line
	16000 1350 16600 1350
Connection ~ 16000 1350
Connection ~ 15700 1800
$Comp
L C_Small C37
U 1 1 5538ABE0
P 20100 1000
F 0 "C37" H 20110 1070 50  0000 L CNN
F 1 "0.1uF" H 20110 920 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 20100 1000 60  0001 C CNN
F 3 "" H 20100 1000 60  0000 C CNN
	1    20100 1000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR025
U 1 1 5538ABE6
P 20100 1100
F 0 "#PWR025" H 20100 850 50  0001 C CNN
F 1 "GND" H 20100 950 50  0001 C CNN
F 2 "" H 20100 1100 60  0000 C CNN
F 3 "" H 20100 1100 60  0000 C CNN
	1    20100 1100
	1    0    0    -1  
$EndComp
$Comp
L C_Small C38
U 1 1 5538ABEC
P 20400 1000
F 0 "C38" H 20410 1070 50  0000 L CNN
F 1 "0.1uF" H 20410 920 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 20400 1000 60  0001 C CNN
F 3 "" H 20400 1000 60  0000 C CNN
	1    20400 1000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR026
U 1 1 5538ABF2
P 20400 1100
F 0 "#PWR026" H 20400 850 50  0001 C CNN
F 1 "GND" H 20400 950 50  0001 C CNN
F 2 "" H 20400 1100 60  0000 C CNN
F 3 "" H 20400 1100 60  0000 C CNN
	1    20400 1100
	1    0    0    -1  
$EndComp
$Comp
L C_Small C35
U 1 1 5538ABF8
P 19500 1000
F 0 "C35" H 19510 1070 50  0000 L CNN
F 1 "0.1uF" H 19510 920 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 19500 1000 60  0001 C CNN
F 3 "" H 19500 1000 60  0000 C CNN
	1    19500 1000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR027
U 1 1 5538ABFE
P 19500 1100
F 0 "#PWR027" H 19500 850 50  0001 C CNN
F 1 "GND" H 19500 950 50  0001 C CNN
F 2 "" H 19500 1100 60  0000 C CNN
F 3 "" H 19500 1100 60  0000 C CNN
	1    19500 1100
	1    0    0    -1  
$EndComp
$Comp
L C_Small C36
U 1 1 5538AC04
P 19800 1000
F 0 "C36" H 19810 1070 50  0000 L CNN
F 1 "0.1uF" H 19810 920 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 19800 1000 60  0001 C CNN
F 3 "" H 19800 1000 60  0000 C CNN
	1    19800 1000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR028
U 1 1 5538AC0A
P 19800 1100
F 0 "#PWR028" H 19800 850 50  0001 C CNN
F 1 "GND" H 19800 950 50  0001 C CNN
F 2 "" H 19800 1100 60  0000 C CNN
F 3 "" H 19800 1100 60  0000 C CNN
	1    19800 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	20100 850  20100 900 
Wire Wire Line
	20400 850  20400 900 
Wire Wire Line
	19500 850  19500 900 
Wire Wire Line
	19800 850  19800 900 
Wire Wire Line
	18800 850  18900 850 
Wire Wire Line
	18900 850  19200 850 
Wire Wire Line
	19200 850  19500 850 
Wire Wire Line
	19500 850  19800 850 
Wire Wire Line
	19800 850  20100 850 
Wire Wire Line
	20100 850  20400 850 
Connection ~ 19800 850 
Connection ~ 19500 850 
Connection ~ 20100 850 
$Comp
L C_Small C32
U 1 1 5538AC1E
P 18900 1000
F 0 "C32" H 18910 1070 50  0000 L CNN
F 1 "0.1uF" H 18910 920 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 18900 1000 60  0001 C CNN
F 3 "" H 18900 1000 60  0000 C CNN
	1    18900 1000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR029
U 1 1 5538AC24
P 18900 1100
F 0 "#PWR029" H 18900 850 50  0001 C CNN
F 1 "GND" H 18900 950 50  0001 C CNN
F 2 "" H 18900 1100 60  0000 C CNN
F 3 "" H 18900 1100 60  0000 C CNN
	1    18900 1100
	1    0    0    -1  
$EndComp
$Comp
L C_Small C34
U 1 1 5538AC2A
P 19200 1000
F 0 "C34" H 19210 1070 50  0000 L CNN
F 1 "0.1uF" H 19210 920 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 19200 1000 60  0001 C CNN
F 3 "" H 19200 1000 60  0000 C CNN
	1    19200 1000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR030
U 1 1 5538AC30
P 19200 1100
F 0 "#PWR030" H 19200 850 50  0001 C CNN
F 1 "GND" H 19200 950 50  0001 C CNN
F 2 "" H 19200 1100 60  0000 C CNN
F 3 "" H 19200 1100 60  0000 C CNN
	1    19200 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	18900 900  18900 850 
Wire Wire Line
	19200 900  19200 850 
Connection ~ 19200 850 
Connection ~ 18900 850 
$Comp
L FT201XS U7
U 1 1 5537FBB9
P 19950 9750
F 0 "U7" H 19400 10350 50  0000 L CNN
F 1 "FT201XS" H 20250 10350 50  0000 L CNN
F 2 "Housings_SSOP:SSOP-16_3.9x4.9mm_Pitch0.635mm" H 19650 10650 50  0000 C CNN
F 3 "" H 19950 9750 50  0000 C CNN
	1    19950 9750
	-1   0    0    -1  
$EndComp
Wire Wire Line
	20750 8950 20750 9350
Wire Wire Line
	20750 9350 20750 9950
Wire Wire Line
	20750 9950 20750 10000
Wire Wire Line
	20750 9350 20650 9350
Wire Wire Line
	20750 8950 19850 8950
Wire Wire Line
	19850 8950 19850 9050
Connection ~ 20750 9350
$Comp
L GND #PWR031
U 1 1 55384B1D
P 19850 10450
F 0 "#PWR031" H 19850 10200 50  0001 C CNN
F 1 "GND" H 19850 10300 50  0001 C CNN
F 2 "" H 19850 10450 60  0000 C CNN
F 3 "" H 19850 10450 60  0000 C CNN
	1    19850 10450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR032
U 1 1 55384F73
P 20050 10450
F 0 "#PWR032" H 20050 10200 50  0001 C CNN
F 1 "GND" H 20050 10300 50  0001 C CNN
F 2 "" H 20050 10450 60  0000 C CNN
F 3 "" H 20050 10450 60  0000 C CNN
	1    20050 10450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR033
U 1 1 55385094
P 12700 2650
F 0 "#PWR033" H 12700 2400 50  0001 C CNN
F 1 "GND" H 12700 2500 50  0001 C CNN
F 2 "" H 12700 2650 60  0000 C CNN
F 3 "" H 12700 2650 60  0000 C CNN
	1    12700 2650
	-1   0    0    -1  
$EndComp
$Comp
L GND #PWR034
U 1 1 553850FB
P 10700 2450
F 0 "#PWR034" H 10700 2200 50  0001 C CNN
F 1 "GND" H 10700 2300 50  0001 C CNN
F 2 "" H 10700 2450 60  0000 C CNN
F 3 "" H 10700 2450 60  0000 C CNN
	1    10700 2450
	-1   0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 55386F8B
P 13500 1400
F 0 "R2" V 13580 1400 50  0000 C CNN
F 1 "50K" V 13500 1400 50  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 13430 1400 30  0001 C CNN
F 3 "" H 13500 1400 30  0000 C CNN
	1    13500 1400
	-1   0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 55386FFB
P 13300 1400
F 0 "R3" V 13380 1400 50  0000 C CNN
F 1 "50K" V 13300 1400 50  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 13230 1400 30  0001 C CNN
F 3 "" H 13300 1400 30  0000 C CNN
	1    13300 1400
	-1   0    0    -1  
$EndComp
$Comp
L R R4
U 1 1 5538706B
P 13100 1400
F 0 "R4" V 13180 1400 50  0000 C CNN
F 1 "50K" V 13100 1400 50  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 13030 1400 30  0001 C CNN
F 3 "" H 13100 1400 30  0000 C CNN
	1    13100 1400
	-1   0    0    -1  
$EndComp
$Comp
L R R5
U 1 1 553870E7
P 12900 1400
F 0 "R5" V 12980 1400 50  0000 C CNN
F 1 "50K" V 12900 1400 50  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 12830 1400 30  0001 C CNN
F 3 "" H 12900 1400 30  0000 C CNN
	1    12900 1400
	-1   0    0    -1  
$EndComp
$Comp
L R R6
U 1 1 55387161
P 21050 9650
F 0 "R6" V 20850 9650 50  0000 C CNN
F 1 "27" V 20950 9650 50  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 20980 9650 30  0001 C CNN
F 3 "" H 21050 9650 30  0000 C CNN
	1    21050 9650
	0    1    1    0   
$EndComp
$Comp
L R R7
U 1 1 55387217
P 21050 9750
F 0 "R7" V 21130 9750 50  0000 C CNN
F 1 "27" V 21200 9750 50  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 20980 9750 30  0001 C CNN
F 3 "" H 21050 9750 30  0000 C CNN
	1    21050 9750
	0    1    1    0   
$EndComp
$Comp
L GND #PWR035
U 1 1 553890D7
P 21900 10150
F 0 "#PWR035" H 21900 9900 50  0001 C CNN
F 1 "GND" H 21900 10000 50  0001 C CNN
F 2 "" H 21900 10150 60  0000 C CNN
F 3 "" H 21900 10150 60  0000 C CNN
	1    21900 10150
	1    0    0    -1  
$EndComp
Wire Wire Line
	21900 9950 21900 10150
$Comp
L R R8
U 1 1 5538A649
P 21750 10400
F 0 "R8" H 21650 10300 50  0000 C CNN
F 1 "4.7K" H 21600 10400 50  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 21680 10400 30  0001 C CNN
F 3 "" H 21750 10400 30  0000 C CNN
	1    21750 10400
	-1   0    0    1   
$EndComp
$Comp
L R R9
U 1 1 5538A931
P 21750 10800
F 0 "R9" H 21650 10700 50  0000 C CNN
F 1 "4.7K" H 21600 10800 50  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 21680 10800 30  0001 C CNN
F 3 "" H 21750 10800 30  0000 C CNN
	1    21750 10800
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR036
U 1 1 5538ADAB
P 21750 10950
F 0 "#PWR036" H 21750 10700 50  0001 C CNN
F 1 "GND" H 21750 10800 50  0001 C CNN
F 2 "" H 21750 10950 60  0000 C CNN
F 3 "" H 21750 10950 60  0000 C CNN
	1    21750 10950
	1    0    0    -1  
$EndComp
Wire Wire Line
	21750 10550 21750 10600
Wire Wire Line
	21750 10600 21750 10650
Wire Wire Line
	19050 10600 21750 10600
Wire Wire Line
	19050 10050 19050 10600
Connection ~ 21750 10600
Wire Wire Line
	19250 10050 19050 10050
$Comp
L GND #PWR037
U 1 1 5538C040
P 22350 10150
F 0 "#PWR037" H 22350 9900 50  0001 C CNN
F 1 "GND" H 22350 10000 50  0001 C CNN
F 2 "" H 22350 10150 60  0000 C CNN
F 3 "" H 22350 10150 60  0000 C CNN
	1    22350 10150
	1    0    0    -1  
$EndComp
Wire Wire Line
	21900 9950 21950 9950
Wire Wire Line
	20750 9950 20650 9950
$Comp
L C_Small C46
U 1 1 5538F7C2
P 21300 9950
F 0 "C46" H 21310 10020 50  0000 L CNN
F 1 "0.1uF" H 21200 9750 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 21300 9950 60  0001 C CNN
F 3 "" H 21300 9950 60  0000 C CNN
	1    21300 9950
	1    0    0    -1  
$EndComp
$Comp
L C_Small C48
U 1 1 55391CEA
P 21500 9950
F 0 "C48" H 21510 10020 50  0000 L CNN
F 1 "0.1uF" H 21500 9750 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 21500 9950 60  0001 C CNN
F 3 "" H 21500 9950 60  0000 C CNN
	1    21500 9950
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR038
U 1 1 55391D80
P 21500 10050
F 0 "#PWR038" H 21500 9800 50  0001 C CNN
F 1 "GND" H 21500 9900 50  0001 C CNN
F 2 "" H 21500 10050 60  0000 C CNN
F 3 "" H 21500 10050 60  0000 C CNN
	1    21500 10050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR039
U 1 1 55391F3F
P 21300 10050
F 0 "#PWR039" H 21300 9800 50  0001 C CNN
F 1 "GND" H 21300 9900 50  0001 C CNN
F 2 "" H 21300 10050 60  0000 C CNN
F 3 "" H 21300 10050 60  0000 C CNN
	1    21300 10050
	1    0    0    -1  
$EndComp
Wire Wire Line
	21300 9850 21300 9750
Connection ~ 21300 9750
Wire Wire Line
	21500 9650 21500 9850
Connection ~ 21500 9650
Wire Wire Line
	21200 9650 21500 9650
Wire Wire Line
	21500 9650 21950 9650
Wire Wire Line
	21200 9750 21300 9750
Wire Wire Line
	21300 9750 21950 9750
Wire Wire Line
	20900 9750 20650 9750
Wire Wire Line
	20900 9650 20650 9650
Wire Wire Line
	21750 10250 21750 9550
Wire Wire Line
	21300 9550 21750 9550
Wire Wire Line
	21750 9550 21950 9550
Wire Wire Line
	20050 9050 20900 9050
Wire Wire Line
	20900 9050 21250 9050
Text Label 20950 9050 0    40   ~ 0
+5V
$Comp
L GND #PWR040
U 1 1 5539C36B
P 17700 1100
F 0 "#PWR040" H 17700 850 50  0001 C CNN
F 1 "GND" H 17700 950 50  0001 C CNN
F 2 "" H 17700 1100 60  0000 C CNN
F 3 "" H 17700 1100 60  0000 C CNN
	1    17700 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	6950 4750 6950 4800
Wire Wire Line
	3650 9550 3650 9500
Connection ~ 3650 9500
Wire Wire Line
	7300 11750 7300 11700
Connection ~ 7300 11700
$Comp
L C_Small C10
U 1 1 553A373E
P 10100 11800
F 0 "C10" H 10110 11870 50  0000 L CNN
F 1 "0.1uF" H 10110 11720 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 10100 11800 60  0001 C CNN
F 3 "" H 10100 11800 60  0000 C CNN
	1    10100 11800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR041
U 1 1 553A3744
P 10100 11900
F 0 "#PWR041" H 10100 11650 50  0001 C CNN
F 1 "GND" H 10100 11750 50  0001 C CNN
F 2 "" H 10100 11900 60  0000 C CNN
F 3 "" H 10100 11900 60  0000 C CNN
	1    10100 11900
	1    0    0    -1  
$EndComp
$Comp
L C_Small C5
U 1 1 553A47D9
P 6950 4900
F 0 "C5" H 6960 4970 50  0000 L CNN
F 1 "0.1uF" H 6960 4820 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 6950 4900 60  0001 C CNN
F 3 "" H 6950 4900 60  0000 C CNN
	1    6950 4900
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR042
U 1 1 553A47DF
P 6950 5000
F 0 "#PWR042" H 6950 4750 50  0001 C CNN
F 1 "GND" H 6950 4850 50  0001 C CNN
F 2 "" H 6950 5000 60  0000 C CNN
F 3 "" H 6950 5000 60  0000 C CNN
	1    6950 5000
	1    0    0    -1  
$EndComp
$Comp
L C_Small C8
U 1 1 553A4892
P 9800 4850
F 0 "C8" H 9810 4920 50  0000 L CNN
F 1 "0.1uF" H 9810 4770 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 9800 4850 60  0001 C CNN
F 3 "" H 9800 4850 60  0000 C CNN
	1    9800 4850
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR043
U 1 1 553A4898
P 9800 4950
F 0 "#PWR043" H 9800 4700 50  0001 C CNN
F 1 "GND" H 9800 4800 50  0001 C CNN
F 2 "" H 9800 4950 60  0000 C CNN
F 3 "" H 9800 4950 60  0000 C CNN
	1    9800 4950
	1    0    0    -1  
$EndComp
$Comp
L C_Small C9
U 1 1 553A6292
P 9900 1200
F 0 "C9" H 9910 1270 50  0000 L CNN
F 1 "0.1uF" H 9910 1120 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 9900 1200 60  0001 C CNN
F 3 "" H 9900 1200 60  0000 C CNN
	1    9900 1200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR044
U 1 1 553A6298
P 9900 1300
F 0 "#PWR044" H 9900 1050 50  0001 C CNN
F 1 "GND" H 9900 1150 50  0001 C CNN
F 2 "" H 9900 1300 60  0000 C CNN
F 3 "" H 9900 1300 60  0000 C CNN
	1    9900 1300
	1    0    0    -1  
$EndComp
$Comp
L C_Small C6
U 1 1 553A633F
P 7000 1250
F 0 "C6" H 7010 1320 50  0000 L CNN
F 1 "0.1uF" H 7010 1170 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 7000 1250 60  0001 C CNN
F 3 "" H 7000 1250 60  0000 C CNN
	1    7000 1250
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR045
U 1 1 553A6345
P 7000 1350
F 0 "#PWR045" H 7000 1100 50  0001 C CNN
F 1 "GND" H 7000 1200 50  0001 C CNN
F 2 "" H 7000 1350 60  0000 C CNN
F 3 "" H 7000 1350 60  0000 C CNN
	1    7000 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 1150 7000 1100
Connection ~ 7000 1100
$Comp
L C_Small C2
U 1 1 553A8E47
P 3650 9650
F 0 "C2" H 3660 9720 50  0000 L CNN
F 1 "0.1uF" H 3660 9570 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 3650 9650 60  0001 C CNN
F 3 "" H 3650 9650 60  0000 C CNN
	1    3650 9650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR046
U 1 1 553A8E4D
P 3650 9750
F 0 "#PWR046" H 3650 9500 50  0001 C CNN
F 1 "GND" H 3650 9600 50  0001 C CNN
F 2 "" H 3650 9750 60  0000 C CNN
F 3 "" H 3650 9750 60  0000 C CNN
	1    3650 9750
	1    0    0    -1  
$EndComp
$Comp
L C_Small C4
U 1 1 553A8F6E
P 6400 9600
F 0 "C4" H 6410 9670 50  0000 L CNN
F 1 "0.1uF" H 6410 9520 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 6400 9600 60  0001 C CNN
F 3 "" H 6400 9600 60  0000 C CNN
	1    6400 9600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR047
U 1 1 553A8F74
P 6400 9700
F 0 "#PWR047" H 6400 9450 50  0001 C CNN
F 1 "GND" H 6400 9550 50  0001 C CNN
F 2 "" H 6400 9700 60  0000 C CNN
F 3 "" H 6400 9700 60  0000 C CNN
	1    6400 9700
	1    0    0    -1  
$EndComp
$Comp
L C_Small C3
U 1 1 553ACC65
P 6000 1750
F 0 "C3" H 6010 1820 50  0000 L CNN
F 1 "0.1uF" H 6010 1670 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 6000 1750 60  0001 C CNN
F 3 "" H 6000 1750 60  0000 C CNN
	1    6000 1750
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR048
U 1 1 553ADC89
P 6000 1850
F 0 "#PWR048" H 6000 1600 50  0001 C CNN
F 1 "GND" H 6000 1700 50  0001 C CNN
F 2 "" H 6000 1850 60  0000 C CNN
F 3 "" H 6000 1850 60  0000 C CNN
	1    6000 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 1650 6000 1600
Connection ~ 6000 1600
$Comp
L C_Small C1
U 1 1 553AE73B
P 3050 1750
F 0 "C1" H 3060 1820 50  0000 L CNN
F 1 "10uF" H 3060 1670 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 3050 1750 60  0001 C CNN
F 3 "" H 3050 1750 60  0000 C CNN
	1    3050 1750
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR049
U 1 1 553AE741
P 3050 1850
F 0 "#PWR049" H 3050 1600 50  0001 C CNN
F 1 "GND" H 3050 1700 50  0001 C CNN
F 2 "" H 3050 1850 60  0000 C CNN
F 3 "" H 3050 1850 60  0000 C CNN
	1    3050 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	3050 1650 3050 1600
Connection ~ 3050 1600
$Comp
L C_Small C45
U 1 1 553B39D0
P 20900 9200
F 0 "C45" H 20910 9270 50  0000 L CNN
F 1 "0.1uF" H 20910 9120 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 20900 9200 60  0001 C CNN
F 3 "" H 20900 9200 60  0000 C CNN
	1    20900 9200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR050
U 1 1 553B39D6
P 20900 9300
F 0 "#PWR050" H 20900 9050 50  0001 C CNN
F 1 "GND" H 20900 9150 50  0001 C CNN
F 2 "" H 20900 9300 60  0000 C CNN
F 3 "" H 20900 9300 60  0000 C CNN
	1    20900 9300
	1    0    0    -1  
$EndComp
Wire Wire Line
	20900 9100 20900 9050
Connection ~ 20900 9050
$Comp
L C_Small C44
U 1 1 553B3BF9
P 20750 10100
F 0 "C44" H 20760 10170 50  0000 L CNN
F 1 "0.1uF" H 20760 10020 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 20750 10100 60  0001 C CNN
F 3 "" H 20750 10100 60  0000 C CNN
	1    20750 10100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR051
U 1 1 553B3BFF
P 20750 10200
F 0 "#PWR051" H 20750 9950 50  0001 C CNN
F 1 "GND" H 20750 10050 50  0001 C CNN
F 2 "" H 20750 10200 60  0000 C CNN
F 3 "" H 20750 10200 60  0000 C CNN
	1    20750 10200
	1    0    0    -1  
$EndComp
Connection ~ 20750 9950
Wire Wire Line
	12800 2150 12800 1150
$Comp
L C_Small C41
U 1 1 553B4E42
P 12650 1350
F 0 "C41" H 12660 1420 50  0000 L CNN
F 1 "0.1uF" H 12660 1270 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 12650 1350 60  0001 C CNN
F 3 "" H 12650 1350 60  0000 C CNN
	1    12650 1350
	-1   0    0    -1  
$EndComp
$Comp
L GND #PWR052
U 1 1 553B4E48
P 12650 1450
F 0 "#PWR052" H 12650 1200 50  0001 C CNN
F 1 "GND" H 12650 1300 50  0001 C CNN
F 2 "" H 12650 1450 60  0000 C CNN
F 3 "" H 12650 1450 60  0000 C CNN
	1    12650 1450
	-1   0    0    -1  
$EndComp
$Comp
L C_Small C43
U 1 1 553B4EE3
P 12350 1350
F 0 "C43" H 12360 1420 50  0000 L CNN
F 1 "1uF" H 12360 1270 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 12350 1350 60  0001 C CNN
F 3 "" H 12350 1350 60  0000 C CNN
	1    12350 1350
	-1   0    0    -1  
$EndComp
$Comp
L GND #PWR053
U 1 1 553B4EE9
P 12350 1450
F 0 "#PWR053" H 12350 1200 50  0001 C CNN
F 1 "GND" H 12350 1300 50  0001 C CNN
F 2 "" H 12350 1450 60  0000 C CNN
F 3 "" H 12350 1450 60  0000 C CNN
	1    12350 1450
	-1   0    0    -1  
$EndComp
Wire Wire Line
	12650 1150 12650 1250
Connection ~ 12650 1150
Wire Wire Line
	12350 1150 12350 1250
Connection ~ 12350 1150
$Comp
L C_Small C39
U 1 1 553B803A
P 19150 11500
F 0 "C39" H 19160 11570 50  0000 L CNN
F 1 "0.1uF" H 19050 11300 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 19150 11500 60  0001 C CNN
F 3 "" H 19150 11500 60  0000 C CNN
	1    19150 11500
	1    0    0    -1  
$EndComp
$Comp
L C_Small C40
U 1 1 553B8CD5
P 19550 11500
F 0 "C40" H 19560 11570 50  0000 L CNN
F 1 "0.1uF" H 19450 11300 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 19550 11500 60  0001 C CNN
F 3 "" H 19550 11500 60  0000 C CNN
	1    19550 11500
	1    0    0    -1  
$EndComp
$Comp
L C_Small C42
U 1 1 553B8D6D
P 19900 11500
F 0 "C42" H 19910 11570 50  0000 L CNN
F 1 "0.1uF" H 19800 11300 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 19900 11500 60  0001 C CNN
F 3 "" H 19900 11500 60  0000 C CNN
	1    19900 11500
	1    0    0    -1  
$EndComp
$Comp
L C_Small C47
U 1 1 553B8E09
P 21350 11500
F 0 "C47" H 21360 11570 50  0000 L CNN
F 1 "0.1uF" H 21250 11300 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 21350 11500 60  0001 C CNN
F 3 "" H 21350 11500 60  0000 C CNN
	1    21350 11500
	1    0    0    -1  
$EndComp
$Comp
L C_Small C50
U 1 1 553B8FA1
P 22050 11500
F 0 "C50" H 22060 11570 50  0000 L CNN
F 1 "0.1uF" H 21950 11300 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 22050 11500 60  0001 C CNN
F 3 "" H 22050 11500 60  0000 C CNN
	1    22050 11500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR054
U 1 1 553B9A01
P 19150 11600
F 0 "#PWR054" H 19150 11350 50  0001 C CNN
F 1 "GND" H 19150 11450 50  0001 C CNN
F 2 "" H 19150 11600 60  0000 C CNN
F 3 "" H 19150 11600 60  0000 C CNN
	1    19150 11600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR055
U 1 1 553BB064
P 19550 11600
F 0 "#PWR055" H 19550 11350 50  0001 C CNN
F 1 "GND" H 19550 11450 50  0001 C CNN
F 2 "" H 19550 11600 60  0000 C CNN
F 3 "" H 19550 11600 60  0000 C CNN
	1    19550 11600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR056
U 1 1 553BB0F1
P 19900 11600
F 0 "#PWR056" H 19900 11350 50  0001 C CNN
F 1 "GND" H 19900 11450 50  0001 C CNN
F 2 "" H 19900 11600 60  0000 C CNN
F 3 "" H 19900 11600 60  0000 C CNN
	1    19900 11600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR057
U 1 1 553BB1C6
P 21350 11600
F 0 "#PWR057" H 21350 11350 50  0001 C CNN
F 1 "GND" H 21350 11450 50  0001 C CNN
F 2 "" H 21350 11600 60  0000 C CNN
F 3 "" H 21350 11600 60  0000 C CNN
	1    21350 11600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR058
U 1 1 553BB2E0
P 22050 11600
F 0 "#PWR058" H 22050 11350 50  0001 C CNN
F 1 "GND" H 22050 11450 50  0001 C CNN
F 2 "" H 22050 11600 60  0000 C CNN
F 3 "" H 22050 11600 60  0000 C CNN
	1    22050 11600
	1    0    0    -1  
$EndComp
Wire Wire Line
	15600 9900 15800 9900
Wire Wire Line
	15800 9900 16150 9900
Wire Wire Line
	16150 9900 16700 9900
$Comp
L C_Small C31
U 1 1 55419609
P 15800 10100
F 0 "C31" H 15810 10170 50  0000 L CNN
F 1 "0.1uF" H 15700 9850 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 15800 10100 60  0001 C CNN
F 3 "" H 15800 10100 60  0000 C CNN
	1    15800 10100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR059
U 1 1 5541960F
P 15800 10200
F 0 "#PWR059" H 15800 9950 50  0001 C CNN
F 1 "GND" H 15800 10050 50  0001 C CNN
F 2 "" H 15800 10200 60  0000 C CNN
F 3 "" H 15800 10200 60  0000 C CNN
	1    15800 10200
	1    0    0    -1  
$EndComp
$Comp
L C_Small C33
U 1 1 554196B2
P 16150 10100
F 0 "C33" H 16160 10170 50  0000 L CNN
F 1 "10uF" H 16050 9850 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 16150 10100 60  0001 C CNN
F 3 "" H 16150 10100 60  0000 C CNN
	1    16150 10100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR060
U 1 1 554196B8
P 16150 10200
F 0 "#PWR060" H 16150 9950 50  0001 C CNN
F 1 "GND" H 16150 10050 50  0001 C CNN
F 2 "" H 16150 10200 60  0000 C CNN
F 3 "" H 16150 10200 60  0000 C CNN
	1    16150 10200
	1    0    0    -1  
$EndComp
Wire Wire Line
	16150 10000 16150 9900
Connection ~ 16150 9900
Wire Wire Line
	15800 10000 15800 9900
Connection ~ 15800 9900
$Comp
L GND #PWR061
U 1 1 5541A29F
P 15200 10200
F 0 "#PWR061" H 15200 9950 50  0001 C CNN
F 1 "GND" H 15200 10050 50  0001 C CNN
F 2 "" H 15200 10200 60  0000 C CNN
F 3 "" H 15200 10200 60  0000 C CNN
	1    15200 10200
	1    0    0    -1  
$EndComp
Text Label 16300 9900 0    40   ~ 0
+3_3V
Text Label 14700 9700 0    40   ~ 0
+5V
Wire Wire Line
	14600 9700 14800 9700
$Comp
L C_Small C27
U 1 1 5541BCBA
P 14500 10100
F 0 "C27" H 14510 10170 50  0000 L CNN
F 1 "0.1uF" H 14510 10020 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 14500 10100 60  0001 C CNN
F 3 "" H 14500 10100 60  0000 C CNN
	1    14500 10100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR062
U 1 1 5541BCC0
P 14500 10200
F 0 "#PWR062" H 14500 9950 50  0001 C CNN
F 1 "GND" H 14500 10050 50  0001 C CNN
F 2 "" H 14500 10200 60  0000 C CNN
F 3 "" H 14500 10200 60  0000 C CNN
	1    14500 10200
	1    0    0    -1  
$EndComp
$Comp
L C_Small C25
U 1 1 5541CD75
P 14200 10100
F 0 "C25" H 14210 10170 50  0000 L CNN
F 1 "10uF" H 14100 9850 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 14200 10100 60  0001 C CNN
F 3 "" H 14200 10100 60  0000 C CNN
	1    14200 10100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR063
U 1 1 5541CD7B
P 14200 10200
F 0 "#PWR063" H 14200 9950 50  0001 C CNN
F 1 "GND" H 14200 10050 50  0001 C CNN
F 2 "" H 14200 10200 60  0000 C CNN
F 3 "" H 14200 10200 60  0000 C CNN
	1    14200 10200
	1    0    0    -1  
$EndComp
$Comp
L C_Small C13
U 1 1 55407168
P 15100 1950
F 0 "C13" H 15110 2020 50  0000 L CNN
F 1 "0.1uF" H 15110 1870 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 15100 1950 60  0001 C CNN
F 3 "" H 15100 1950 60  0000 C CNN
	1    15100 1950
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR064
U 1 1 5540716E
P 15100 2050
F 0 "#PWR064" H 15100 1800 50  0001 C CNN
F 1 "GND" H 15100 1900 50  0001 C CNN
F 2 "" H 15100 2050 60  0000 C CNN
F 3 "" H 15100 2050 60  0000 C CNN
	1    15100 2050
	1    0    0    -1  
$EndComp
$Comp
L LD1117S33CTR U5
U 1 1 554091AB
P 15200 9950
F 0 "U5" H 15200 10200 40  0000 C CNN
F 1 "LD1117S33CTR" H 15200 10150 40  0000 C CNN
F 2 "SMD_Packages:SOT-223" H 15200 10050 40  0000 C CNN
F 3 "" H 15200 9950 60  0000 C CNN
	1    15200 9950
	1    0    0    -1  
$EndComp
Connection ~ 21750 9550
Text Label 21400 9550 0    40   ~ 0
USB_VBUS
Wire Wire Line
	13200 9700 13800 9700
Text Label 13250 9700 0    40   ~ 0
USB_VBUS
Wire Wire Line
	14200 9900 14200 10000
Wire Wire Line
	14200 9900 14500 9900
Wire Wire Line
	14500 9900 14800 9900
Wire Wire Line
	14500 10000 14500 9900
Connection ~ 14500 9900
$Comp
L USB_OTG CON2
U 1 1 5549E3D1
P 22250 9750
F 0 "CON2" H 22575 9625 50  0000 C CNN
F 1 "USB_OTG" H 22250 9950 50  0000 C CNN
F 2 "Connect:USB_Micro-B" V 22200 9650 60  0001 C CNN
F 3 "" V 22200 9650 60  0000 C CNN
	1    22250 9750
	0    1    1    0   
$EndComp
Wire Wire Line
	8950 6350 9050 6350
Wire Wire Line
	9050 6350 9050 5950
Connection ~ 9050 5950
Wire Wire Line
	8950 6450 9150 6450
Wire Wire Line
	9150 6450 9150 5850
Connection ~ 9150 5850
Wire Wire Line
	8950 6550 9250 6550
Wire Wire Line
	9250 6550 9250 5750
Connection ~ 9250 5750
Wire Wire Line
	8950 6650 9350 6650
Wire Wire Line
	9350 6650 9350 5650
Connection ~ 9350 5650
Wire Wire Line
	8950 6750 9450 6750
Wire Wire Line
	9450 6750 9450 5550
Connection ~ 9450 5550
Wire Wire Line
	8950 6850 9550 6850
Wire Wire Line
	9550 6850 9550 5450
Connection ~ 9550 5450
Wire Wire Line
	8950 6950 9650 6950
Wire Wire Line
	9650 6950 9650 5350
Connection ~ 9650 5350
Wire Wire Line
	8950 7050 9750 7050
Wire Wire Line
	9750 7050 9750 5250
Connection ~ 9750 5250
$Comp
L D_Schottky_x2_KCom D1
U 1 1 555B3540
P 14200 9700
F 0 "D1" H 14350 9575 50  0000 C CNN
F 1 "D_Schottky_x2_KCom" H 14200 9850 50  0000 C CNN
F 2 "Housings_SOT-23_SOT-143_TSOT-6:SOT-23_Handsoldering" H 14250 9950 60  0000 C CNN
F 3 "" H 14200 9700 60  0000 C CNN
	1    14200 9700
	1    0    0    -1  
$EndComp
$Comp
L Thermal_Quad CON3
U 1 1 555C3AAB
P 16800 8100
F 0 "CON3" H 16750 8200 60  0000 C CNN
F 1 "Thermal_Quad" H 16750 8100 60  0000 C CNN
F 2 "" H 16750 8200 60  0000 C CNN
F 3 "" H 16750 8200 60  0000 C CNN
	1    16800 8100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR065
U 1 1 555C3DD3
P 16400 8300
F 0 "#PWR065" H 16400 8050 50  0001 C CNN
F 1 "GND" H 16400 8150 50  0000 C CNN
F 2 "" H 16400 8300 60  0000 C CNN
F 3 "" H 16400 8300 60  0000 C CNN
	1    16400 8300
	1    0    0    -1  
$EndComp
Text Label 19800 1350 0    40   ~ 0
+3_3V
Wire Wire Line
	18750 1350 18800 1350
Wire Wire Line
	18800 1350 18900 1350
Wire Wire Line
	18900 1350 19000 1350
Wire Wire Line
	19000 1350 19100 1350
Wire Wire Line
	19100 1350 19200 1350
Wire Wire Line
	19200 1350 19300 1350
Wire Wire Line
	19300 1350 19400 1350
Wire Wire Line
	19400 1350 19500 1350
Wire Wire Line
	19500 1350 19600 1350
Wire Wire Line
	19600 1350 19700 1350
Wire Wire Line
	19700 1350 20400 1350
Wire Wire Line
	13700 1150 13500 1150
Wire Wire Line
	13500 1150 13300 1150
Wire Wire Line
	13300 1150 13100 1150
Wire Wire Line
	13100 1150 12900 1150
Wire Wire Line
	12900 1150 12800 1150
Wire Wire Line
	12800 1150 12650 1150
Wire Wire Line
	12650 1150 12350 1150
Wire Wire Line
	12350 1150 12200 1150
Wire Wire Line
	21050 2950 20650 2950
Wire Wire Line
	13900 2250 13900 2550
Wire Wire Line
	14000 1950 14000 2650
Wire Wire Line
	14100 1850 14100 2750
Wire Wire Line
	16050 2450 13500 2450
Wire Wire Line
	13500 2450 12600 2450
Wire Wire Line
	13900 2550 16050 2550
Wire Wire Line
	14000 2650 16050 2650
Wire Wire Line
	14100 2750 16050 2750
Wire Wire Line
	19250 9350 18450 9350
Text Label 18650 9350 0    40   ~ 0
USB_SCL
Wire Wire Line
	19250 9450 18450 9450
Text Label 18650 9450 0    40   ~ 0
USB_SDA
Wire Wire Line
	19250 9650 18450 9650
Text Label 18650 9650 0    40   ~ 0
USB_CBUS0
Wire Wire Line
	19250 9750 18450 9750
Text Label 18650 9750 0    40   ~ 0
USB_CBUS1
Wire Wire Line
	21450 7250 20650 7250
Text Label 20850 7250 0    40   ~ 0
USB_SCL
Wire Wire Line
	21450 7150 20650 7150
Text Label 20850 7150 0    40   ~ 0
USB_SDA
Wire Wire Line
	21450 6950 20650 6950
Text Label 20850 6950 0    40   ~ 0
USB_CBUS0
Wire Wire Line
	21450 7050 20650 7050
Text Label 20850 7050 0    40   ~ 0
USB_CBUS1
$EndSCHEMATC
