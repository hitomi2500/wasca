EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A1 33110 23386
encoding utf-8
Sheet 1 1
Title "Wasca"
Date "2020-12-12"
Rev "1.4"
Comp "cafe-alpha & hitomi2500"
Comment1 ""
Comment2 "Distributed under GNU GENERAL PUBLIC LICENSE Version 2"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L power:GND #PWR032
U 1 1 5530B291
P 3900 9550
F 0 "#PWR032" H 3900 9300 50  0001 C CNN
F 1 "GND" H 3900 9400 50  0000 C CNN
F 2 "" H 3900 9550 60  0000 C CNN
F 3 "" H 3900 9550 60  0000 C CNN
	1    3900 9550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR033
U 1 1 5530B2A8
P 5450 9550
F 0 "#PWR033" H 5450 9300 50  0001 C CNN
F 1 "GND" H 5450 9400 50  0000 C CNN
F 2 "" H 5450 9550 60  0000 C CNN
F 3 "" H 5450 9550 60  0000 C CNN
	1    5450 9550
	1    0    0    -1  
$EndComp
$Comp
L 10M08SCE144I7G:CARTRIDGE_EDGE_CONNECTOR CN1
U 1 1 5530C876
P 4650 6300
F 0 "CN1" H 4400 10100 60  0000 C CNN
F 1 "CARTRIDGE_EDGE_CONNECTOR" H 4650 3050 60  0000 C CNN
F 2 "wasca:CARTRIDGE_EDGE_CONNECTOR2" H 4650 6300 60  0001 C CNN
F 3 "" H 4650 6300 60  0000 C CNN
	1    4650 6300
	1    0    0    -1  
$EndComp
Text Label 3450 8200 0    40   ~ 0
ABUS_D0
Entry Wire Line
	3250 8200 3150 8300
Text Label 3450 8300 0    40   ~ 0
ABUS_D1
Text Label 3450 8400 0    40   ~ 0
ABUS_D2
Text Label 3450 8500 0    40   ~ 0
ABUS_D3
Text Label 3450 8700 0    40   ~ 0
ABUS_D8
Text Label 3450 8800 0    40   ~ 0
ABUS_D9
Text Label 3450 8900 0    40   ~ 0
ABUS_D10
Text Label 3450 9000 0    40   ~ 0
ABUS_D11
Text Label 5650 8200 0    40   ~ 0
ABUS_D7
Text Label 5650 8300 0    40   ~ 0
ABUS_D6
Text Label 5650 8400 0    40   ~ 0
ABUS_D5
Text Label 5650 8500 0    40   ~ 0
ABUS_D4
Text Label 5650 8700 0    40   ~ 0
ABUS_D15
Text Label 5650 8800 0    40   ~ 0
ABUS_D14
Text Label 5650 8900 0    40   ~ 0
ABUS_D13
Text Label 5650 9000 0    40   ~ 0
ABUS_D12
Entry Wire Line
	3250 8300 3150 8400
Entry Wire Line
	3250 8400 3150 8500
Entry Wire Line
	3250 8500 3150 8600
Entry Wire Line
	3250 8700 3150 8800
Entry Wire Line
	3250 8800 3150 8900
Entry Wire Line
	3250 8900 3150 9000
Entry Wire Line
	3250 9000 3150 9100
Entry Wire Line
	6100 8200 6200 8300
Entry Wire Line
	6100 8300 6200 8400
Entry Wire Line
	6100 8400 6200 8500
Entry Wire Line
	6100 8500 6200 8600
Entry Wire Line
	6100 8700 6200 8800
Entry Wire Line
	6100 8800 6200 8900
Entry Wire Line
	6100 8900 6200 9000
Entry Wire Line
	6100 9000 6200 9100
Text Label 3450 7400 0    40   ~ 0
ABUS_CS0
Text Label 3450 7500 0    40   ~ 0
ABUS_CS2
Text Label 3450 7600 0    40   ~ 0
ABUS_WR0
Text Label 5600 8000 0    40   ~ 0
ABUS_IRQ
Text Label 5600 7400 0    40   ~ 0
ABUS_RD
Text Label 5600 7500 0    40   ~ 0
ABUS_CS1
Text Label 5600 7600 0    40   ~ 0
ABUS_WR1
Text Label 3450 7200 0    40   ~ 0
ABUS_A1
Text Label 3450 6900 0    40   ~ 0
ABUS_A9
Text Label 3450 7000 0    40   ~ 0
ABUS_A11
Text Label 3450 7100 0    40   ~ 0
ABUS_A10
Text Label 3450 6700 0    40   ~ 0
ABUS_A8
Text Label 3450 6400 0    40   ~ 0
ABUS_A15
Text Label 3450 6500 0    40   ~ 0
ABUS_A12
Text Label 3450 6600 0    40   ~ 0
ABUS_A13
Text Label 5600 6900 0    40   ~ 0
ABUS_A4
Text Label 5600 7000 0    40   ~ 0
ABUS_A3
Text Label 5600 7100 0    40   ~ 0
ABUS_A2
Text Label 5600 6700 0    40   ~ 0
ABUS_A5
Text Label 5600 6400 0    40   ~ 0
ABUS_A14
Text Label 5600 6500 0    40   ~ 0
ABUS_A7
Text Label 5600 6600 0    40   ~ 0
ABUS_A6
Text Label 3450 6050 0    40   ~ 0
ABUS_A17
Text Label 3450 5750 0    40   ~ 0
ABUS_A23
Text Label 3450 5850 0    40   ~ 0
ABUS_A21
Text Label 3450 5950 0    40   ~ 0
ABUS_A19
Text Label 5600 6050 0    40   ~ 0
ABUS_A16
Text Label 5600 5750 0    40   ~ 0
ABUS_A22
Text Label 5600 5850 0    40   ~ 0
ABUS_A20
Text Label 5600 5950 0    40   ~ 0
ABUS_A18
Text Label 5600 5650 0    40   ~ 0
ABUS_A24
Text Label 3450 2850 0    40   ~ 0
RESET
$Comp
L 10M08SCE144I7G:74ALVC164245 U5
U 1 1 55357BE8
P 8500 11100
F 0 "U5" H 8200 12000 60  0000 L BNN
F 1 "74ALVC164245" H 8200 11950 60  0000 L TNN
F 2 "Package_SO:TSSOP-48_6.1x12.5mm_P0.5mm" H 8500 10750 60  0001 C CNN
F 3 "" H 8500 10750 60  0000 C CNN
	1    8500 11100
	-1   0    0    -1  
$EndComp
$Comp
L 10M08SCE144I7G:74ALVC164245 U2
U 1 1 55357CB5
P 8500 6150
F 0 "U2" H 8200 7050 60  0000 L BNN
F 1 "74ALVC164245" H 8200 7000 60  0000 L TNN
F 2 "Package_SO:TSSOP-48_6.1x12.5mm_P0.5mm" H 8500 5800 60  0001 C CNN
F 3 "" H 8500 5800 60  0000 C CNN
	1    8500 6150
	-1   0    0    -1  
$EndComp
Entry Wire Line
	6850 12200 6950 12100
Entry Wire Line
	6850 12300 6950 12200
Entry Wire Line
	6850 12400 6950 12300
Entry Wire Line
	6850 12500 6950 12400
Entry Wire Line
	6850 12600 6950 12500
Entry Wire Line
	6850 12700 6950 12600
Entry Wire Line
	6850 12900 6950 12800
Entry Wire Line
	6850 12800 6950 12700
Text Label 7150 12100 0    40   ~ 0
ABUS_D7
Text Label 7150 12200 0    40   ~ 0
ABUS_D6
Text Label 7150 12300 0    40   ~ 0
ABUS_D5
Text Label 7150 12400 0    40   ~ 0
ABUS_D4
Text Label 7150 12500 0    40   ~ 0
ABUS_D15
Text Label 7150 12600 0    40   ~ 0
ABUS_D14
Text Label 7150 12700 0    40   ~ 0
ABUS_D13
Text Label 7150 12800 0    40   ~ 0
ABUS_D12
Entry Wire Line
	6100 6600 6200 6500
Entry Wire Line
	6100 6500 6200 6400
Entry Wire Line
	6100 6400 6200 6300
Entry Wire Line
	6100 5950 6200 5850
Entry Wire Line
	6100 5850 6200 5750
Entry Wire Line
	6100 5750 6200 5650
Entry Wire Line
	6100 5650 6200 5550
Entry Wire Line
	6850 6650 6950 6750
Entry Wire Line
	6850 6550 6950 6650
Entry Wire Line
	6850 6450 6950 6550
Entry Wire Line
	6850 6350 6950 6450
Entry Wire Line
	6850 6250 6950 6350
Entry Wire Line
	6850 6150 6950 6250
Entry Wire Line
	6850 6050 6950 6150
Entry Bus Bus
	6200 5450 6300 5350
Text Label 10050 11700 2    40   ~ 0
ABUS_3V_D11
Text Label 10050 11600 2    40   ~ 0
ABUS_3V_D10
Text Label 10050 11500 2    40   ~ 0
ABUS_3V_D9
Text Label 10050 11400 2    40   ~ 0
ABUS_3V_D8
Text Label 10050 11300 2    40   ~ 0
ABUS_3V_D3
Text Label 10050 11200 2    40   ~ 0
ABUS_3V_D2
Text Label 10050 11100 2    40   ~ 0
ABUS_3V_D1
Text Label 10050 11000 2    40   ~ 0
ABUS_3V_D0
Text Label 7500 11000 2    40   ~ 0
ABUS_D0
Text Label 7500 11100 2    40   ~ 0
ABUS_D1
Text Label 7500 11200 2    40   ~ 0
ABUS_D2
Text Label 7500 11300 2    40   ~ 0
ABUS_D3
Text Label 7500 11400 2    40   ~ 0
ABUS_D8
Text Label 7500 11500 2    40   ~ 0
ABUS_D9
Text Label 7500 11600 2    40   ~ 0
ABUS_D10
Text Label 7500 11700 2    40   ~ 0
ABUS_D11
Entry Wire Line
	6850 11600 6950 11700
Entry Wire Line
	6850 11500 6950 11600
Entry Wire Line
	6850 11400 6950 11500
Entry Wire Line
	6850 11300 6950 11400
Entry Wire Line
	6850 11200 6950 11300
Entry Wire Line
	6850 11100 6950 11200
Entry Wire Line
	6850 11000 6950 11100
Entry Wire Line
	6850 10900 6950 11000
Text Label 8100 2400 0    40   ~ 0
ABUS_A1
Text Label 8100 2700 0    40   ~ 0
ABUS_A9
Text Label 8100 2600 0    40   ~ 0
ABUS_A11
Text Label 8100 2500 0    40   ~ 0
ABUS_A10
Text Label 8100 2800 0    40   ~ 0
ABUS_A8
Text Label 8100 3400 0    40   ~ 0
ABUS_A15
Text Label 8100 3300 0    40   ~ 0
ABUS_A12
Text Label 8100 3200 0    40   ~ 0
ABUS_A13
Entry Wire Line
	2950 6500 3050 6400
Entry Wire Line
	2950 6600 3050 6500
Entry Wire Line
	2950 6700 3050 6600
Entry Wire Line
	2950 6800 3050 6700
Entry Wire Line
	2950 7000 3050 6900
Entry Wire Line
	2950 7100 3050 7000
Entry Wire Line
	2950 7200 3050 7100
Entry Wire Line
	2950 7300 3050 7200
Entry Wire Line
	6850 7050 6950 7150
Entry Wire Line
	6850 7150 6950 7250
Entry Wire Line
	6850 7250 6950 7350
Entry Wire Line
	6850 7350 6950 7450
Entry Wire Line
	6850 7450 6950 7550
Entry Wire Line
	6850 7550 6950 7650
Entry Wire Line
	6850 7650 6950 7750
Entry Wire Line
	6850 7750 6950 7850
Text Label 10050 6650 0    40   ~ 0
ABUS_3V_A14
Text Label 10050 6750 0    40   ~ 0
ABUS_3V_A7
Text Label 10050 7150 0    40   ~ 0
ABUS_3V_A6
Text Label 10050 7250 0    40   ~ 0
ABUS_3V_A5
Text Label 10050 7350 0    40   ~ 0
ABUS_3V_A4
Text Label 10050 7450 0    40   ~ 0
ABUS_3V_A3
Text Label 10050 7550 0    40   ~ 0
ABUS_3V_A2
$Comp
L power:GND #PWR058
U 1 1 553685DB
P 8450 13550
F 0 "#PWR058" H 8450 13300 50  0001 C CNN
F 1 "GND" H 8450 13400 50  0000 C CNN
F 2 "" H 8450 13550 60  0000 C CNN
F 3 "" H 8450 13550 60  0000 C CNN
	1    8450 13550
	1    0    0    -1  
$EndComp
Text Label 9650 11900 0    40   ~ 0
ABUS_3V_MUX_DATA_DIR
$Comp
L power:GND #PWR029
U 1 1 5536AAA8
P 10800 6950
F 0 "#PWR029" H 10800 6700 50  0001 C CNN
F 1 "GND" H 10800 6800 50  0000 C CNN
F 2 "" H 10800 6950 60  0000 C CNN
F 3 "" H 10800 6950 60  0000 C CNN
	1    10800 6950
	1    0    0    -1  
$EndComp
Text Label 9500 5550 0    40   ~ 0
+3_3V
Text Label 9500 10500 0    40   ~ 0
+3_3V
Text Label 25300 3000 2    40   ~ 0
ABUS_3V_MUX_DATA_DIR
Text Label 2300 14950 0    40   ~ 0
ABUS_IRQ
Text Label 8100 2300 0    40   ~ 0
ABUS_CS0
Text Label 8100 2200 0    40   ~ 0
ABUS_CS2
Text Label 8100 2100 0    40   ~ 0
ABUS_WR0
Text Label 8100 3500 0    40   ~ 0
ABUS_A17
Text Label 9400 7650 0    40   ~ 0
ABUS_3V_RD
Text Label 9400 7750 0    40   ~ 0
ABUS_3V_CS1
Text Label 9400 7850 0    40   ~ 0
ABUS_3V_WR1
Text Label 10350 2300 0    40   ~ 0
ABUS_3V_CS0
Text Label 10350 2200 0    40   ~ 0
ABUS_3V_CS2
Text Label 10350 2100 0    40   ~ 0
ABUS_3V_WR0
Text Label 9400 6550 0    40   ~ 0
ABUS_3V_A16
Text Label 9400 6250 0    40   ~ 0
ABUS_3V_A22
Text Label 9400 6350 0    40   ~ 0
ABUS_3V_A20
Text Label 9400 6450 0    40   ~ 0
ABUS_3V_A18
Text Label 9400 6150 0    40   ~ 0
ABUS_3V_A24
Text Label 10350 3900 0    40   ~ 0
RESET_3V
$Comp
L power:GND #PWR03
U 1 1 55373B0B
P 10850 1900
F 0 "#PWR03" H 10850 1650 50  0001 C CNN
F 1 "GND" H 10850 1750 50  0000 C CNN
F 2 "" H 10850 1900 60  0000 C CNN
F 3 "" H 10850 1900 60  0000 C CNN
	1    10850 1900
	1    0    0    -1  
$EndComp
Text Label 3850 14950 0    40   ~ 0
ABUS_3V_IRQ
Text Label 3700 14300 0    40   ~ 0
+3_3V
Text Label 10450 1600 0    40   ~ 0
+3_3V
$Comp
L power:GND #PWR066
U 1 1 55374C6F
P 3250 15350
F 0 "#PWR066" H 3250 15100 50  0001 C CNN
F 1 "GND" H 3250 15200 50  0000 C CNN
F 2 "" H 3250 15350 60  0000 C CNN
F 3 "" H 3250 15350 60  0000 C CNN
	1    3250 15350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR023
U 1 1 55374E3F
P 9400 4650
F 0 "#PWR023" H 9400 4400 50  0001 C CNN
F 1 "GND" H 9400 4500 50  0000 C CNN
F 2 "" H 9400 4650 60  0000 C CNN
F 3 "" H 9400 4650 60  0000 C CNN
	1    9400 4650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR031
U 1 1 55377281
P 8450 8600
F 0 "#PWR031" H 8450 8350 50  0001 C CNN
F 1 "GND" H 8450 8450 50  0000 C CNN
F 2 "" H 8450 8600 60  0000 C CNN
F 3 "" H 8450 8600 60  0000 C CNN
	1    8450 8600
	1    0    0    -1  
$EndComp
Text Label 24800 6200 0    40   ~ 0
ABUS_3V_A23
Text Label 24800 6000 0    40   ~ 0
ABUS_3V_A21
Text Label 24800 5900 0    40   ~ 0
ABUS_3V_A19
Text Label 22650 5000 0    40   ~ 0
ABUS_3V_RD
Text Label 24750 3200 0    40   ~ 0
ABUS_3V_CS1
Text Label 22650 5200 0    40   ~ 0
ABUS_3V_WR1
Text Label 25150 3800 2    40   ~ 0
ABUS_3V_CS0
Text Label 25200 4800 2    40   ~ 0
ABUS_3V_CS2
Text Label 25200 4700 2    40   ~ 0
ABUS_3V_WR0
Text Label 24800 6100 0    40   ~ 0
ABUS_3V_A17
Text Label 24750 4100 0    40   ~ 0
ABUS_3V_A16
Text Label 25150 4400 2    40   ~ 0
ABUS_3V_A22
Text Label 25150 4300 2    40   ~ 0
ABUS_3V_A20
Text Label 24750 4200 0    40   ~ 0
ABUS_3V_A18
Text Label 25150 4500 2    40   ~ 0
ABUS_3V_A24
Text Label 24800 5700 0    40   ~ 0
RESET_3V
Text Label 22650 5600 0    40   ~ 0
ABUS_3V_IRQ
$Comp
L Device:C_Small C2
U 1 1 55383D80
P 8150 1750
F 0 "C2" H 8160 1820 50  0000 L CNN
F 1 "0.1uF" H 8160 1670 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 8150 1750 60  0001 C CNN
F 3 "" H 8150 1750 60  0000 C CNN
	1    8150 1750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR02
U 1 1 55383D86
P 8150 1850
F 0 "#PWR02" H 8150 1600 50  0001 C CNN
F 1 "GND" H 8150 1700 50  0001 C CNN
F 2 "" H 8150 1850 60  0000 C CNN
F 3 "" H 8150 1850 60  0000 C CNN
	1    8150 1850
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C1
U 1 1 553A373E
P 11050 1700
F 0 "C1" H 11060 1770 50  0000 L CNN
F 1 "0.1uF" H 11060 1620 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 11050 1700 60  0001 C CNN
F 3 "" H 11050 1700 60  0000 C CNN
	1    11050 1700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01
U 1 1 553A3744
P 11050 1800
F 0 "#PWR01" H 11050 1550 50  0001 C CNN
F 1 "GND" H 11050 1650 50  0001 C CNN
F 2 "" H 11050 1800 60  0000 C CNN
F 3 "" H 11050 1800 60  0000 C CNN
	1    11050 1800
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C26
U 1 1 553A47D9
P 7200 10650
F 0 "C26" H 7210 10720 50  0000 L CNN
F 1 "0.1uF" H 7210 10570 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 7200 10650 60  0001 C CNN
F 3 "" H 7200 10650 60  0000 C CNN
	1    7200 10650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR039
U 1 1 553A47DF
P 7200 10750
F 0 "#PWR039" H 7200 10500 50  0001 C CNN
F 1 "GND" H 7200 10600 50  0001 C CNN
F 2 "" H 7200 10750 60  0000 C CNN
F 3 "" H 7200 10750 60  0000 C CNN
	1    7200 10750
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C25
U 1 1 553A4892
P 11050 10600
F 0 "C25" H 11060 10670 50  0000 L CNN
F 1 "0.1uF" H 11060 10520 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 11050 10600 60  0001 C CNN
F 3 "" H 11050 10600 60  0000 C CNN
	1    11050 10600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR038
U 1 1 553A4898
P 11050 10700
F 0 "#PWR038" H 11050 10450 50  0001 C CNN
F 1 "GND" H 11050 10550 50  0001 C CNN
F 2 "" H 11050 10700 60  0000 C CNN
F 3 "" H 11050 10700 60  0000 C CNN
	1    11050 10700
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C42
U 1 1 553A6292
P 4200 14400
F 0 "C42" H 4210 14470 50  0000 L CNN
F 1 "0.1uF" H 4210 14320 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 4200 14400 60  0001 C CNN
F 3 "" H 4200 14400 60  0000 C CNN
	1    4200 14400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR061
U 1 1 553A6298
P 4200 14500
F 0 "#PWR061" H 4200 14250 50  0001 C CNN
F 1 "GND" H 4200 14350 50  0001 C CNN
F 2 "" H 4200 14500 60  0000 C CNN
F 3 "" H 4200 14500 60  0000 C CNN
	1    4200 14500
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C43
U 1 1 553A633F
P 2250 14450
F 0 "C43" H 2260 14520 50  0000 L CNN
F 1 "0.1uF" H 2260 14370 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 2250 14450 60  0001 C CNN
F 3 "" H 2250 14450 60  0000 C CNN
	1    2250 14450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR062
U 1 1 553A6345
P 2250 14550
F 0 "#PWR062" H 2250 14300 50  0001 C CNN
F 1 "GND" H 2250 14400 50  0001 C CNN
F 2 "" H 2250 14550 60  0000 C CNN
F 3 "" H 2250 14550 60  0000 C CNN
	1    2250 14550
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C22
U 1 1 553A8E47
P 7200 5700
F 0 "C22" H 7210 5770 50  0000 L CNN
F 1 "0.1uF" H 7210 5620 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 7200 5700 60  0001 C CNN
F 3 "" H 7200 5700 60  0000 C CNN
	1    7200 5700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR026
U 1 1 553A8E4D
P 7200 5800
F 0 "#PWR026" H 7200 5550 50  0001 C CNN
F 1 "GND" H 7200 5650 50  0001 C CNN
F 2 "" H 7200 5800 60  0000 C CNN
F 3 "" H 7200 5800 60  0000 C CNN
	1    7200 5800
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C21
U 1 1 553A8F6E
P 10050 5650
F 0 "C21" H 10060 5720 50  0000 L CNN
F 1 "0.1uF" H 10060 5570 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 10050 5650 60  0001 C CNN
F 3 "" H 10050 5650 60  0000 C CNN
	1    10050 5650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR025
U 1 1 553A8F74
P 10050 5750
F 0 "#PWR025" H 10050 5500 50  0001 C CNN
F 1 "GND" H 10050 5600 50  0001 C CNN
F 2 "" H 10050 5750 60  0000 C CNN
F 3 "" H 10050 5750 60  0000 C CNN
	1    10050 5750
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C17
U 1 1 553ACC65
P 6450 2800
F 0 "C17" H 6460 2870 50  0000 L CNN
F 1 "4.7uF" H 6460 2720 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 6450 2800 60  0001 C CNN
F 3 "" H 6450 2800 60  0000 C CNN
	1    6450 2800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR018
U 1 1 553ADC89
P 6450 2900
F 0 "#PWR018" H 6450 2650 50  0001 C CNN
F 1 "GND" H 6450 2750 50  0001 C CNN
F 2 "" H 6450 2900 60  0000 C CNN
F 3 "" H 6450 2900 60  0000 C CNN
	1    6450 2900
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C3
U 1 1 553AE73B
P 3000 2250
F 0 "C3" H 3010 2320 50  0000 L CNN
F 1 "4.7uF" H 3010 2170 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 3000 2250 60  0001 C CNN
F 3 "" H 3000 2250 60  0000 C CNN
	1    3000 2250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR04
U 1 1 553AE741
P 3000 2350
F 0 "#PWR04" H 3000 2100 50  0001 C CNN
F 1 "GND" H 3000 2200 50  0001 C CNN
F 2 "" H 3000 2350 60  0000 C CNN
F 3 "" H 3000 2350 60  0000 C CNN
	1    3000 2350
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C24
U 1 1 554196B2
P 18050 9600
F 0 "C24" H 18060 9670 50  0000 L CNN
F 1 "10uF" H 17950 9350 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 18050 9600 60  0001 C CNN
F 3 "" H 18050 9600 60  0000 C CNN
	1    18050 9600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR036
U 1 1 554196B8
P 18050 9700
F 0 "#PWR036" H 18050 9450 50  0001 C CNN
F 1 "GND" H 18050 9550 50  0001 C CNN
F 2 "" H 18050 9700 60  0000 C CNN
F 3 "" H 18050 9700 60  0000 C CNN
	1    18050 9700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR035
U 1 1 5541A29F
P 17100 9700
F 0 "#PWR035" H 17100 9450 50  0001 C CNN
F 1 "GND" H 17100 9550 50  0001 C CNN
F 2 "" H 17100 9700 60  0000 C CNN
F 3 "" H 17100 9700 60  0000 C CNN
	1    17100 9700
	1    0    0    -1  
$EndComp
Text Label 18300 9400 0    40   ~ 0
+3_3V
Text Label 15850 9400 2    40   ~ 0
+5V_SYS
$Comp
L Device:C_Small C23
U 1 1 5541BCBA
P 16350 9600
F 0 "C23" H 16360 9670 50  0000 L CNN
F 1 "0.1uF" H 16360 9520 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 16350 9600 60  0001 C CNN
F 3 "" H 16350 9600 60  0000 C CNN
	1    16350 9600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR034
U 1 1 5541BCC0
P 16350 9700
F 0 "#PWR034" H 16350 9450 50  0001 C CNN
F 1 "GND" H 16350 9550 50  0001 C CNN
F 2 "" H 16350 9700 60  0000 C CNN
F 3 "" H 16350 9700 60  0000 C CNN
	1    16350 9700
	1    0    0    -1  
$EndComp
Text Label 24750 3100 0    40   ~ 0
IRQ_OUT_ENABLE
Text Label 18300 10050 0    40   ~ 0
VCC_SDRAM
Text Label 3850 15150 0    40   ~ 0
IRQ_OUT_ENABLE
$Comp
L power:GND #PWR019
U 1 1 55FADEE3
P 10850 3000
F 0 "#PWR019" H 10850 2750 50  0001 C CNN
F 1 "GND" H 10850 2850 50  0000 C CNN
F 2 "" H 10850 3000 60  0000 C CNN
F 3 "" H 10850 3000 60  0000 C CNN
	1    10850 3000
	1    0    0    -1  
$EndComp
Text Label 3450 2950 0    40   ~ 0
ISD
Text Label 3450 3050 0    40   ~ 0
IBCK
Text Label 3450 3150 0    40   ~ 0
ILRCK
Text Label 5600 2850 0    40   ~ 0
SSEL
Text Label 6650 15100 0    40   ~ 0
ISD
Text Label 6650 16550 0    40   ~ 0
IBCK
Text Label 6650 17950 0    40   ~ 0
ILRCK
Text Label 8200 15100 0    40   ~ 0
ISD_3V
Text Label 8200 16550 0    40   ~ 0
IBCK_3V
NoConn ~ 4000 5550
NoConn ~ 4000 5350
NoConn ~ 4000 5150
NoConn ~ 4000 5050
NoConn ~ 4000 4950
NoConn ~ 4000 4750
NoConn ~ 4000 4650
NoConn ~ 4000 4550
NoConn ~ 4000 4450
NoConn ~ 4000 9300
NoConn ~ 5350 9300
NoConn ~ 4000 8000
NoConn ~ 4000 4250
NoConn ~ 4000 4150
NoConn ~ 4000 4050
NoConn ~ 4000 3950
NoConn ~ 4000 3750
NoConn ~ 4000 3650
NoConn ~ 4000 3550
NoConn ~ 4000 3450
NoConn ~ 5350 3450
NoConn ~ 5350 3550
NoConn ~ 5350 3650
NoConn ~ 5350 3750
NoConn ~ 5350 3950
NoConn ~ 5350 4050
NoConn ~ 5350 4150
NoConn ~ 5350 4250
NoConn ~ 5350 4450
NoConn ~ 5350 4550
NoConn ~ 5350 4650
NoConn ~ 5350 4750
NoConn ~ 5350 4950
NoConn ~ 5350 5050
NoConn ~ 5350 5150
NoConn ~ 5350 5350
NoConn ~ 5350 5550
NoConn ~ 5350 7800
NoConn ~ 4000 7900
$Comp
L Device:R R10
U 1 1 576EADD5
P 22550 10950
F 0 "R10" V 22630 10950 50  0000 C CNN
F 1 "470" V 22700 10950 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" V 22480 10950 30  0001 C CNN
F 3 "" H 22550 10950 30  0000 C CNN
	1    22550 10950
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R11
U 1 1 576EA724
P 22750 11050
F 0 "R11" V 22830 11050 50  0000 C CNN
F 1 "470" V 22850 11250 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" V 22680 11050 30  0001 C CNN
F 3 "" H 22750 11050 30  0000 C CNN
	1    22750 11050
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR070
U 1 1 576EA72A
P 22750 11750
F 0 "#PWR070" H 22750 11500 50  0001 C CNN
F 1 "GND" H 22750 11600 50  0001 C CNN
F 2 "" H 22750 11750 60  0000 C CNN
F 3 "" H 22750 11750 60  0000 C CNN
	1    22750 11750
	1    0    0    -1  
$EndComp
Text Label 23000 10700 0    40   ~ 0
LEDG
Text Label 23000 10600 0    40   ~ 0
LEDR
Text Notes 12650 11700 0    60   ~ 0
External 5V power supply\n+ 3V3 power output/check
Text Label 13700 12150 2    40   ~ 0
+3_3V
$Comp
L power:GND #PWR082
U 1 1 5778318E
P 12850 12300
F 0 "#PWR082" H 12850 12050 50  0001 C CNN
F 1 "GND" H 12850 12150 50  0001 C CNN
F 2 "" H 12850 12300 60  0000 C CNN
F 3 "" H 12850 12300 60  0000 C CNN
	1    12850 12300
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R12
U 1 1 577920F2
P 25250 11800
F 0 "R12" V 25330 11800 50  0000 C CNN
F 1 "470" V 25250 11800 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 25180 11800 30  0001 C CNN
F 3 "" H 25250 11800 30  0000 C CNN
	1    25250 11800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR073
U 1 1 577920F8
P 25250 11950
F 0 "#PWR073" H 25250 11700 50  0001 C CNN
F 1 "GND" H 25250 11800 50  0001 C CNN
F 2 "" H 25250 11950 60  0000 C CNN
F 3 "" H 25250 11950 60  0000 C CNN
	1    25250 11950
	1    0    0    -1  
$EndComp
Text Label 24800 10600 0    40   ~ 0
LED3
Text Notes 17850 10300 0    39   ~ 0
SDRAM : shares 3V3 with MAX10\nDDR : requires 2V5 power supply
Text Notes 28650 21350 0    60   ~ 0
--- Changelog ---\nV1.0 hitomi2500 :\n - Initial version with 10M04SFE, SDRAM, FT201XS\nV1.1 hitomi2500 :\n - Both DDR/SDRAM support\n - Added USB and bluetooth support\n - Sound I/O mapped to MAX10\nV1.2 cafe-alpha :\n - Changed PCB shape and ICs position in order to fit Action Replay case\n - Changed MAX10 chip from 10M04SFE to 10M08SCE\n - Changed SD card footprint to the one used in Gamer's Cartridge\n - Removed DDR and bluetooth support\n - Removed USB and bluetooth modules\n - Added USB dev cart support via separate (optional) mezzanine board\nV1.4 hitomi2500 @ cafe-alpha :\n - Removed unused signals\n - Changed to non-multiplexed mode\n - STM32F446 added as a companion MCU\n - SD card moved to STM32\n - Added ESM32-CAM module for future WiFi connectivity\n - SD to Micro-SD and Mini-B to Type-C connectors change\n
$Comp
L Device:C_Small C53
U 1 1 5B87DA95
P 15600 17700
F 0 "C53" H 15610 17770 50  0000 L CNN
F 1 "0.1uF" H 15610 17620 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 15600 17700 60  0001 C CNN
F 3 "" H 15600 17700 60  0000 C CNN
	1    15600 17700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR084
U 1 1 5B87DA9B
P 15600 18150
F 0 "#PWR084" H 15600 17900 50  0001 C CNN
F 1 "GND" H 15600 18000 50  0001 C CNN
F 2 "" H 15600 18150 60  0000 C CNN
F 3 "" H 15600 18150 60  0000 C CNN
	1    15600 18150
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C52
U 1 1 5B87EC24
P 15300 17700
F 0 "C52" H 15310 17770 50  0000 L CNN
F 1 "0.1uF" H 15310 17620 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 15300 17700 60  0001 C CNN
F 3 "" H 15300 17700 60  0000 C CNN
	1    15300 17700
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C54
U 1 1 5B87ECF0
P 15900 17700
F 0 "C54" H 15910 17770 50  0000 L CNN
F 1 "4.7uF" H 15910 17620 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 15900 17700 60  0001 C CNN
F 3 "" H 15900 17700 60  0000 C CNN
	1    15900 17700
	1    0    0    -1  
$EndComp
$Comp
L Device:R R13
U 1 1 5B887F56
P 12800 17250
F 0 "R13" V 12880 17250 50  0000 C CNN
F 1 "4K7" V 12800 17250 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 12730 17250 30  0001 C CNN
F 3 "" H 12800 17250 30  0000 C CNN
	1    12800 17250
	0    1    -1   0   
$EndComp
$Comp
L Device:R R14
U 1 1 5B887F5C
P 13900 17250
F 0 "R14" V 14000 17250 50  0000 C CNN
F 1 "10K" V 13900 17250 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 13830 17250 30  0001 C CNN
F 3 "" H 13900 17250 30  0000 C CNN
	1    13900 17250
	0    1    -1   0   
$EndComp
$Comp
L power:GND #PWR079
U 1 1 5B88930B
P 14300 17300
F 0 "#PWR079" H 14300 17050 50  0001 C CNN
F 1 "GND" H 14300 17150 50  0001 C CNN
F 2 "" H 14300 17300 60  0000 C CNN
F 3 "" H 14300 17300 60  0000 C CNN
	1    14300 17300
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 15150 4400 15150
Wire Wire Line
	18050 9400 18050 9500
Wire Wire Line
	22550 10600 23200 10600
Wire Wire Line
	22750 10700 23200 10700
Wire Wire Line
	22450 5800 23200 5800
Wire Wire Line
	8000 16550 8750 16550
Wire Wire Line
	8000 15100 8750 15100
Wire Wire Line
	6450 17950 7200 17950
Wire Wire Line
	6450 16550 7200 16550
Wire Wire Line
	6450 15100 7200 15100
Wire Wire Line
	5350 2850 5750 2850
Wire Wire Line
	3250 3150 4000 3150
Wire Wire Line
	3250 3050 4000 3050
Wire Wire Line
	3250 2950 4000 2950
Connection ~ 18050 9400
Connection ~ 3000 2100
Wire Wire Line
	3000 2150 3000 2100
Connection ~ 6450 2650
Wire Wire Line
	6450 2650 6450 2700
Wire Wire Line
	2250 14350 2250 14300
Wire Wire Line
	8150 1650 8150 1600
Wire Wire Line
	7200 5600 7200 5550
Wire Wire Line
	7200 10500 7200 10550
Wire Wire Line
	24600 3300 25350 3300
Wire Wire Line
	24600 2900 25350 2900
Wire Wire Line
	24600 5700 25350 5700
Wire Wire Line
	24600 6100 25350 6100
Wire Wire Line
	25350 4200 24600 4200
Wire Wire Line
	22450 5600 23200 5600
Wire Wire Line
	25350 4300 24600 4300
Wire Wire Line
	25350 3900 24600 3900
Wire Wire Line
	25350 4400 24600 4400
Wire Wire Line
	25350 4800 24600 4800
Wire Wire Line
	25350 4700 24600 4700
Wire Wire Line
	25350 4500 24600 4500
Wire Wire Line
	24600 3800 25350 3800
Wire Wire Line
	22450 5100 23200 5100
Wire Wire Line
	24600 5900 25350 5900
Wire Wire Line
	24600 6000 25350 6000
Wire Wire Line
	24600 6200 25350 6200
Connection ~ 8450 8550
Wire Wire Line
	8450 8550 8450 8600
Connection ~ 8200 8550
Wire Wire Line
	8200 8450 8200 8550
Connection ~ 8300 8550
Wire Wire Line
	8300 8550 8300 8450
Connection ~ 8400 8550
Wire Wire Line
	8400 8550 8400 8450
Connection ~ 8500 8550
Wire Wire Line
	8500 8550 8500 8450
Connection ~ 8600 8550
Wire Wire Line
	8600 8550 8600 8450
Connection ~ 8700 8550
Wire Wire Line
	8700 8550 8700 8450
Wire Wire Line
	8800 8550 8800 8450
Wire Wire Line
	8100 8550 8200 8550
Wire Wire Line
	8100 8450 8100 8550
Connection ~ 9400 4600
Wire Wire Line
	9400 4600 9400 4650
Connection ~ 9150 4600
Wire Wire Line
	9150 4500 9150 4600
Connection ~ 9250 4600
Wire Wire Line
	9250 4600 9250 4500
Connection ~ 9350 4600
Wire Wire Line
	9350 4600 9350 4500
Connection ~ 9450 4600
Wire Wire Line
	9450 4600 9450 4500
Connection ~ 9550 4600
Wire Wire Line
	9550 4600 9550 4500
Connection ~ 9650 4600
Wire Wire Line
	9650 4600 9650 4500
Wire Wire Line
	9750 4600 9750 4500
Wire Wire Line
	9050 4600 9150 4600
Wire Wire Line
	9050 4500 9050 4600
Connection ~ 10250 1600
Wire Wire Line
	10250 1700 10250 1600
Wire Wire Line
	10150 1700 10250 1700
Wire Wire Line
	10150 1600 10250 1600
Connection ~ 8550 1600
Wire Wire Line
	8550 1700 8550 1600
Wire Wire Line
	8650 1700 8550 1700
Wire Wire Line
	8150 1600 8550 1600
Wire Wire Line
	3650 14950 4400 14950
Wire Wire Line
	10150 3900 10900 3900
Wire Wire Line
	9200 6150 9950 6150
Wire Wire Line
	9200 6450 9950 6450
Wire Wire Line
	9200 6350 9950 6350
Wire Wire Line
	9200 6250 9950 6250
Wire Wire Line
	9200 6550 9950 6550
Wire Wire Line
	10150 2300 10900 2300
Wire Wire Line
	10150 2200 10900 2200
Wire Wire Line
	10150 2100 10900 2100
Wire Wire Line
	9200 7850 9950 7850
Wire Wire Line
	9200 7750 9950 7750
Wire Wire Line
	9200 7650 9950 7650
Wire Wire Line
	7900 3500 8650 3500
Wire Wire Line
	7900 2300 8650 2300
Wire Wire Line
	7900 2200 8650 2200
Wire Wire Line
	7900 2100 8650 2100
Wire Wire Line
	2100 14950 2850 14950
Wire Wire Line
	23200 5200 22450 5200
Wire Wire Line
	9300 10600 9300 10500
Wire Wire Line
	9200 10600 9300 10600
Wire Wire Line
	9200 10500 9300 10500
Connection ~ 9300 5550
Wire Wire Line
	9300 5650 9300 5550
Wire Wire Line
	9200 5650 9300 5650
Wire Wire Line
	9200 5550 9300 5550
Connection ~ 7600 5550
Wire Wire Line
	7600 5650 7600 5550
Wire Wire Line
	7700 5650 7600 5650
Wire Wire Line
	7200 5550 7600 5550
Wire Wire Line
	9200 11900 10650 11900
Connection ~ 8450 13500
Wire Wire Line
	8450 13500 8450 13550
Connection ~ 8200 13500
Wire Wire Line
	8200 13400 8200 13500
Connection ~ 8300 13500
Wire Wire Line
	8300 13500 8300 13400
Connection ~ 8400 13500
Wire Wire Line
	8400 13500 8400 13400
Connection ~ 8500 13500
Wire Wire Line
	8500 13500 8500 13400
Connection ~ 8600 13500
Wire Wire Line
	8600 13500 8600 13400
Connection ~ 8700 13500
Wire Wire Line
	8700 13500 8700 13400
Wire Wire Line
	8800 13500 8800 13400
Wire Wire Line
	8100 13500 8200 13500
Wire Wire Line
	8100 13400 8100 13500
Connection ~ 7600 10500
Wire Wire Line
	7600 10600 7600 10500
Wire Wire Line
	7700 10600 7600 10600
Wire Wire Line
	7200 10500 7600 10500
Wire Wire Line
	24600 3200 25350 3200
Wire Wire Line
	24600 4900 25350 4900
Wire Wire Line
	24600 5000 25350 5000
Wire Wire Line
	24600 5100 25350 5100
Wire Wire Line
	24600 5200 25350 5200
Wire Wire Line
	24600 5300 25350 5300
Wire Wire Line
	25350 5800 24600 5800
Wire Wire Line
	25350 5600 24600 5600
Wire Wire Line
	25350 3700 24600 3700
Wire Wire Line
	25350 4100 24600 4100
Wire Wire Line
	25350 4000 24600 4000
Wire Wire Line
	24600 3600 25350 3600
Wire Wire Line
	7700 11700 6950 11700
Wire Wire Line
	7700 11600 6950 11600
Wire Wire Line
	7700 11500 6950 11500
Wire Wire Line
	7700 11400 6950 11400
Wire Wire Line
	7700 11300 6950 11300
Wire Wire Line
	7700 11200 6950 11200
Wire Wire Line
	7700 11100 6950 11100
Wire Wire Line
	7700 11000 6950 11000
Wire Wire Line
	6950 12800 7700 12800
Wire Wire Line
	6950 12700 7700 12700
Wire Wire Line
	6950 12500 7700 12500
Wire Wire Line
	6950 12400 7700 12400
Wire Wire Line
	6950 12300 7700 12300
Wire Wire Line
	6950 12200 7700 12200
Wire Wire Line
	6950 12100 7700 12100
Wire Wire Line
	5350 5650 6100 5650
Wire Wire Line
	5350 5950 6100 5950
Wire Wire Line
	5350 5850 6100 5850
Wire Wire Line
	5350 5750 6100 5750
Wire Wire Line
	5350 6050 6100 6050
Wire Wire Line
	5350 6600 6100 6600
Wire Wire Line
	5350 6500 6100 6500
Wire Wire Line
	5350 6400 6100 6400
Wire Wire Line
	5350 6700 6100 6700
Wire Wire Line
	5350 7100 6100 7100
Wire Wire Line
	5350 7000 6100 7000
Wire Wire Line
	5350 6900 6100 6900
Wire Wire Line
	3050 6600 4000 6600
Wire Wire Line
	3050 6500 4000 6500
Wire Wire Line
	3050 6400 4000 6400
Wire Wire Line
	3050 6700 4000 6700
Wire Wire Line
	3050 7100 4000 7100
Wire Wire Line
	3050 7000 4000 7000
Wire Wire Line
	3050 6900 4000 6900
Wire Wire Line
	3050 7200 4000 7200
Wire Wire Line
	5350 7600 6100 7600
Wire Wire Line
	5350 7500 6100 7500
Wire Wire Line
	5350 7400 6100 7400
Wire Wire Line
	5350 8000 6100 8000
Wire Wire Line
	3050 7600 4000 7600
Wire Wire Line
	3050 7500 4000 7500
Wire Wire Line
	3050 7400 4000 7400
Wire Wire Line
	5350 9000 6100 9000
Wire Wire Line
	5350 8900 6100 8900
Wire Wire Line
	5350 8800 6100 8800
Wire Wire Line
	5350 8700 6100 8700
Wire Wire Line
	5350 8500 6100 8500
Wire Wire Line
	5350 8400 6100 8400
Wire Wire Line
	5350 8300 6100 8300
Wire Wire Line
	5350 8200 6100 8200
Wire Wire Line
	3250 9000 4000 9000
Wire Wire Line
	3250 8900 4000 8900
Wire Wire Line
	3250 8800 4000 8800
Wire Wire Line
	3250 8700 4000 8700
Wire Wire Line
	3250 8500 4000 8500
Wire Wire Line
	3250 8400 4000 8400
Wire Wire Line
	3250 8300 4000 8300
Wire Wire Line
	3250 8200 4000 8200
Connection ~ 5550 2750
Wire Wire Line
	5350 2650 5550 2650
Connection ~ 5550 5250
Wire Wire Line
	5550 2750 5350 2750
Wire Wire Line
	5550 5250 5350 5250
Wire Wire Line
	5550 2650 5550 2750
Wire Wire Line
	5550 9400 5350 9400
Connection ~ 3800 2750
Wire Wire Line
	2550 2100 3000 2100
Connection ~ 3800 5250
Wire Wire Line
	3800 2750 4000 2750
Wire Wire Line
	3800 5250 4000 5250
Wire Wire Line
	3800 2650 3800 2750
Wire Wire Line
	3800 9400 4000 9400
Connection ~ 3900 3850
Wire Wire Line
	4000 3850 3900 3850
Connection ~ 3900 4350
Wire Wire Line
	3900 4350 4000 4350
Connection ~ 3900 4850
Wire Wire Line
	3900 4850 4000 4850
Connection ~ 3900 5450
Wire Wire Line
	3900 5450 4000 5450
Connection ~ 3900 6150
Wire Wire Line
	3900 6150 4000 6150
Connection ~ 3900 6800
Wire Wire Line
	4000 3350 3900 3350
Connection ~ 5450 3350
Wire Wire Line
	5350 3250 5450 3250
Connection ~ 5450 3850
Wire Wire Line
	5350 3350 5450 3350
Connection ~ 5450 4350
Wire Wire Line
	5450 3850 5350 3850
Connection ~ 5450 4850
Wire Wire Line
	5450 4350 5350 4350
Connection ~ 5450 5450
Wire Wire Line
	5450 4850 5350 4850
Connection ~ 5450 6150
Wire Wire Line
	5450 3250 5450 3350
Wire Wire Line
	5450 5450 5350 5450
Connection ~ 5450 6800
Wire Wire Line
	5450 6150 5350 6150
Connection ~ 3900 7300
Wire Wire Line
	3900 7300 4000 7300
Connection ~ 5450 7300
Wire Wire Line
	5450 7300 5350 7300
Connection ~ 5450 8100
Wire Wire Line
	5450 6800 5350 6800
Connection ~ 3900 8100
Wire Wire Line
	3900 6800 4000 6800
Connection ~ 3900 8600
Wire Wire Line
	3900 8100 4000 8100
Connection ~ 5450 8600
Wire Wire Line
	5450 8600 5350 8600
Connection ~ 5450 9100
Wire Wire Line
	5450 8100 5350 8100
Connection ~ 5450 9200
Wire Wire Line
	5450 9100 5350 9100
Wire Wire Line
	5450 9200 5350 9200
Connection ~ 3900 9100
Wire Wire Line
	3900 8600 4000 8600
Connection ~ 3900 9200
Wire Wire Line
	3900 9100 4000 9100
Wire Wire Line
	3900 3350 3900 3850
Wire Wire Line
	3900 9200 4000 9200
Wire Wire Line
	13700 12150 13450 12150
Wire Wire Line
	16350 9500 16350 9400
Connection ~ 16350 9400
Wire Notes Line
	13950 11400 12500 11400
Wire Notes Line
	13950 12850 13950 11400
Wire Notes Line
	12500 12850 13950 12850
Wire Notes Line
	12500 11400 12500 12850
Wire Wire Line
	13700 12250 13450 12250
Wire Wire Line
	12950 12150 12850 12150
Wire Wire Line
	12850 12150 12850 12250
Wire Wire Line
	12950 12250 12850 12250
Connection ~ 12850 12250
Wire Wire Line
	25250 10600 24600 10600
Wire Wire Line
	25250 11450 25250 11650
Wire Wire Line
	18250 9400 18250 10050
Wire Wire Line
	18250 10050 18600 10050
Connection ~ 18250 9400
Wire Notes Line
	17800 9950 17800 10400
Wire Notes Line
	17800 10400 18900 10400
Wire Notes Line
	18900 10400 18900 9950
Wire Notes Line
	18900 9950 17800 9950
Wire Wire Line
	15600 17300 15600 17450
Wire Wire Line
	15000 17300 15600 17300
Wire Wire Line
	15300 17450 15300 17600
Wire Wire Line
	15900 17450 15900 17600
Wire Wire Line
	15300 17450 15600 17450
Connection ~ 15600 17450
Wire Wire Line
	15300 17800 15300 18000
Wire Wire Line
	15300 18000 15600 18000
Wire Wire Line
	15600 17800 15600 18000
Wire Wire Line
	15900 18000 15900 17800
Connection ~ 15600 18000
Wire Wire Line
	14050 17250 14300 17250
Wire Wire Line
	11300 17950 11400 17950
Wire Wire Line
	14300 17250 14300 17300
$Comp
L power:GND #PWR083
U 1 1 5B883F2F
P 10700 18900
F 0 "#PWR083" H 10700 18650 50  0001 C CNN
F 1 "GND" H 10700 18750 50  0001 C CNN
F 2 "" H 10700 18900 60  0000 C CNN
F 3 "" H 10700 18900 60  0000 C CNN
	1    10700 18900
	1    0    0    -1  
$EndComp
Wire Wire Line
	18050 9400 18250 9400
Wire Wire Line
	3000 2100 3800 2100
Wire Wire Line
	6450 2650 6550 2650
Wire Wire Line
	5550 2650 6450 2650
Wire Wire Line
	3800 2650 4000 2650
Wire Wire Line
	8450 8550 8500 8550
Wire Wire Line
	8200 8550 8300 8550
Wire Wire Line
	8300 8550 8400 8550
Wire Wire Line
	8400 8550 8450 8550
Wire Wire Line
	8500 8550 8600 8550
Wire Wire Line
	8600 8550 8700 8550
Wire Wire Line
	8700 8550 8800 8550
Wire Wire Line
	9400 4600 9450 4600
Wire Wire Line
	9150 4600 9250 4600
Wire Wire Line
	9250 4600 9350 4600
Wire Wire Line
	9350 4600 9400 4600
Wire Wire Line
	9450 4600 9550 4600
Wire Wire Line
	9550 4600 9650 4600
Wire Wire Line
	9650 4600 9750 4600
Wire Wire Line
	10250 1600 11050 1600
Wire Wire Line
	3350 14300 4200 14300
Wire Wire Line
	8550 1600 8650 1600
Wire Wire Line
	9300 5550 10050 5550
Wire Wire Line
	7600 5550 7700 5550
Wire Wire Line
	8450 13500 8500 13500
Wire Wire Line
	8200 13500 8300 13500
Wire Wire Line
	8300 13500 8400 13500
Wire Wire Line
	8400 13500 8450 13500
Wire Wire Line
	8500 13500 8600 13500
Wire Wire Line
	8600 13500 8700 13500
Wire Wire Line
	8700 13500 8800 13500
Wire Wire Line
	7600 10500 7700 10500
Wire Wire Line
	5550 2750 5550 5250
Wire Wire Line
	5550 5250 5550 9400
Wire Wire Line
	3800 2750 3800 5250
Wire Wire Line
	3800 5250 3800 9400
Wire Wire Line
	3900 3850 3900 4350
Wire Wire Line
	3900 4350 3900 4850
Wire Wire Line
	3900 4850 3900 5450
Wire Wire Line
	3900 5450 3900 6150
Wire Wire Line
	3900 6150 3900 6800
Wire Wire Line
	3900 6800 3900 7300
Wire Wire Line
	5450 3350 5450 3850
Wire Wire Line
	5450 3850 5450 4350
Wire Wire Line
	5450 4350 5450 4850
Wire Wire Line
	5450 4850 5450 5450
Wire Wire Line
	5450 5450 5450 6150
Wire Wire Line
	5450 6150 5450 6800
Wire Wire Line
	5450 6800 5450 7300
Wire Wire Line
	3900 7300 3900 8100
Wire Wire Line
	5450 7300 5450 8100
Wire Wire Line
	5450 8100 5450 8600
Wire Wire Line
	3900 8100 3900 8600
Wire Wire Line
	3900 8600 3900 9100
Wire Wire Line
	5450 8600 5450 9100
Wire Wire Line
	5450 9100 5450 9200
Wire Wire Line
	5450 9200 5450 9550
Wire Wire Line
	3900 9100 3900 9200
Wire Wire Line
	3900 9200 3900 9550
Wire Wire Line
	12850 12250 12850 12300
Wire Wire Line
	18250 9400 18600 9400
Wire Wire Line
	15600 17450 15600 17600
Wire Wire Line
	15600 17450 15900 17450
Wire Wire Line
	15600 18000 15900 18000
Wire Wire Line
	15600 18000 15600 18150
Wire Wire Line
	17400 9400 18050 9400
Wire Wire Line
	16350 9400 16800 9400
$Comp
L Regulator_Linear:LD1117S33TR_SOT223 U4
U 1 1 60103F31
P 17100 9400
F 0 "U4" H 17100 9642 50  0000 C CNN
F 1 "LD1117S33TR_SOT223" H 17100 9551 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-223-3_TabPin2" H 17100 9600 50  0001 C CNN
F 3 "http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00000544.pdf" H 17200 9150 50  0001 C CNN
	1    17100 9400
	1    0    0    -1  
$EndComp
Wire Bus Line
	6850 5350 6300 5350
Wire Wire Line
	10900 11700 9200 11700
Wire Wire Line
	10900 11600 9200 11600
Wire Wire Line
	10900 11500 9200 11500
Wire Wire Line
	10900 11400 9200 11400
Wire Wire Line
	10900 11300 9200 11300
Wire Wire Line
	10900 11200 9200 11200
Wire Wire Line
	10900 11100 9200 11100
Wire Wire Line
	10900 11000 9200 11000
Text Label 10050 12100 0    40   ~ 0
ABUS_3V_D7
Text Label 10050 12200 0    40   ~ 0
ABUS_3V_D6
Text Label 10050 12300 0    40   ~ 0
ABUS_3V_D5
Text Label 10050 12400 0    40   ~ 0
ABUS_3V_D4
Text Label 10050 12500 0    40   ~ 0
ABUS_3V_D15
Text Label 10050 12600 0    40   ~ 0
ABUS_3V_D14
Text Label 10050 12700 0    40   ~ 0
ABUS_3V_D13
Text Label 10050 12800 0    40   ~ 0
ABUS_3V_D12
Wire Wire Line
	9200 12100 10900 12100
Wire Wire Line
	9200 12200 10900 12200
Wire Wire Line
	9200 12300 10900 12300
Wire Wire Line
	9200 12400 10900 12400
Wire Wire Line
	9200 12500 10900 12500
Wire Wire Line
	9200 12600 10900 12600
Wire Wire Line
	9200 12700 10900 12700
Wire Wire Line
	9200 12800 10900 12800
Text Label 9650 10800 0    40   ~ 0
ABUS_3V_MUX_DATA_DIR
Wire Wire Line
	9200 10800 10650 10800
Wire Wire Line
	9200 7550 10900 7550
Wire Wire Line
	9200 6650 10900 6650
Wire Wire Line
	9200 6750 10900 6750
Wire Wire Line
	9200 7150 10900 7150
Wire Wire Line
	9200 7250 10900 7250
Wire Wire Line
	9200 7350 10900 7350
Wire Wire Line
	9200 7450 10900 7450
$Comp
L power:GND #PWR027
U 1 1 623E9613
P 10800 5850
F 0 "#PWR027" H 10800 5600 50  0001 C CNN
F 1 "GND" H 10800 5700 50  0000 C CNN
F 2 "" H 10800 5850 60  0000 C CNN
F 3 "" H 10800 5850 60  0000 C CNN
	1    10800 5850
	1    0    0    -1  
$EndComp
Text Label 11000 2400 0    40   ~ 0
ABUS_3V_A1
Text Label 11000 2500 0    40   ~ 0
ABUS_3V_A10
Text Label 11000 2600 0    40   ~ 0
ABUS_3V_A11
Text Label 11000 2700 0    40   ~ 0
ABUS_3V_A9
Text Label 11000 2800 0    40   ~ 0
ABUS_3V_A8
Text Label 11000 3200 0    40   ~ 0
ABUS_3V_A13
Text Label 11000 3300 0    40   ~ 0
ABUS_3V_A12
Text Label 11000 3400 0    40   ~ 0
ABUS_3V_A15
Wire Wire Line
	10150 3400 11850 3400
Wire Wire Line
	10150 3300 11850 3300
Wire Wire Line
	10150 2400 11850 2400
Wire Wire Line
	10150 2500 11850 2500
Wire Wire Line
	10150 2600 11850 2600
Wire Wire Line
	10150 2700 11850 2700
Wire Wire Line
	10150 2800 11850 2800
Wire Wire Line
	10150 3200 11850 3200
Wire Wire Line
	9300 10500 11050 10500
Connection ~ 9300 10500
Text Label 24800 4900 0    40   ~ 0
ABUS_3V_A1
Text Label 24800 5000 0    40   ~ 0
ABUS_3V_A10
Text Label 24800 5100 0    40   ~ 0
ABUS_3V_A11
Text Label 24800 5200 0    40   ~ 0
ABUS_3V_A9
Text Label 24800 5300 0    40   ~ 0
ABUS_3V_A8
Text Label 24800 5500 0    40   ~ 0
ABUS_3V_A13
Text Label 24800 5600 0    40   ~ 0
ABUS_3V_A12
Text Label 24800 5800 0    40   ~ 0
ABUS_3V_A15
Wire Wire Line
	25350 5500 24600 5500
Text Label 25150 4000 2    40   ~ 0
ABUS_3V_A14
Text Label 25100 3900 2    40   ~ 0
ABUS_3V_A7
Text Label 25100 3700 2    40   ~ 0
ABUS_3V_A6
Text Label 24750 3600 0    40   ~ 0
ABUS_3V_A5
Text Label 24750 3500 0    40   ~ 0
ABUS_3V_A4
Text Label 24750 3300 0    40   ~ 0
ABUS_3V_A2
Wire Wire Line
	24600 3400 25350 3400
Text Label 22650 3600 0    40   ~ 0
ABUS_3V_D11
Text Label 22650 3500 0    40   ~ 0
ABUS_3V_D10
Text Label 22650 3400 0    40   ~ 0
ABUS_3V_D9
Text Label 22650 3300 0    40   ~ 0
ABUS_3V_D8
Text Label 23000 3200 2    40   ~ 0
ABUS_3V_D3
Text Label 23000 3100 2    40   ~ 0
ABUS_3V_D2
Text Label 23000 3000 2    40   ~ 0
ABUS_3V_D1
Text Label 23000 2900 2    40   ~ 0
ABUS_3V_D0
Wire Wire Line
	22450 3900 23200 3900
Wire Wire Line
	23200 3700 22450 3700
Wire Wire Line
	22450 4300 23200 4300
Wire Wire Line
	22450 4600 23200 4600
Wire Wire Line
	23200 4400 22450 4400
Wire Wire Line
	22450 4500 23200 4500
Wire Wire Line
	22450 4900 23200 4900
Wire Wire Line
	23200 3000 22450 3000
Wire Wire Line
	22450 3500 23200 3500
Wire Wire Line
	23200 3100 22450 3100
Wire Wire Line
	22450 3400 23200 3400
Wire Wire Line
	22450 3300 23200 3300
Wire Wire Line
	23200 3200 22450 3200
Wire Wire Line
	23200 2900 22450 2900
Wire Wire Line
	22450 3600 23200 3600
Wire Wire Line
	24600 3000 25350 3000
Wire Wire Line
	24600 3100 25350 3100
$Comp
L 10M08SCE144I7G:74ALVC164245 U1
U 1 1 5536E7A3
P 9450 2200
F 0 "U1" H 9150 3100 60  0000 L BNN
F 1 "74ALVC164245" H 9150 3050 60  0000 L TNN
F 2 "Package_SO:TSSOP-48_6.1x12.5mm_P0.5mm" H 9450 1850 60  0001 C CNN
F 3 "" H 9450 1850 60  0000 C CNN
	1    9450 2200
	-1   0    0    -1  
$EndComp
Wire Bus Line
	3150 10600 6200 10600
Connection ~ 6200 10600
Wire Bus Line
	6200 10600 6850 10600
Wire Wire Line
	6950 12600 7700 12600
Entry Wire Line
	6100 6050 6200 5950
Entry Wire Line
	6100 6700 6200 6600
Entry Wire Line
	6100 6900 6200 6800
Entry Wire Line
	6100 7000 6200 6900
Entry Wire Line
	6100 7100 6200 7000
Entry Wire Line
	6100 7400 6200 7300
Entry Wire Line
	6100 7500 6200 7400
Entry Wire Line
	6100 7600 6200 7500
Wire Wire Line
	7900 2400 8650 2400
Wire Wire Line
	7900 2500 8650 2500
Wire Wire Line
	7900 2600 8650 2600
Wire Wire Line
	7900 2700 8650 2700
Wire Wire Line
	7900 2800 8650 2800
Wire Wire Line
	7900 3200 8650 3200
Wire Wire Line
	7900 3300 8650 3300
Wire Wire Line
	7900 3400 8650 3400
Entry Wire Line
	7800 2500 7900 2600
Entry Wire Line
	7800 2400 7900 2500
Entry Wire Line
	7800 2300 7900 2400
Entry Wire Line
	7800 2200 7900 2300
Entry Wire Line
	7800 2100 7900 2200
Entry Wire Line
	7800 2000 7900 2100
Entry Wire Line
	7800 3100 7900 3200
Entry Wire Line
	7800 3200 7900 3300
Entry Wire Line
	7800 3300 7900 3400
Entry Wire Line
	7800 3400 7900 3500
Entry Wire Line
	7800 3500 7900 3600
Entry Wire Line
	7800 3600 7900 3700
Entry Wire Line
	2950 7500 3050 7400
Entry Wire Line
	2950 7600 3050 7500
Entry Wire Line
	2950 7700 3050 7600
Entry Wire Line
	2950 5850 3050 5750
Entry Wire Line
	2950 5950 3050 5850
Entry Wire Line
	2950 6050 3050 5950
Entry Wire Line
	2950 6150 3050 6050
Wire Wire Line
	3050 5950 4000 5950
Wire Wire Line
	3050 5850 4000 5850
Wire Wire Line
	3050 5750 4000 5750
Wire Wire Line
	3050 6050 4000 6050
Wire Bus Line
	2150 5850 2950 5850
Wire Bus Line
	2150 1400 7800 1400
Entry Wire Line
	7800 2600 7900 2700
Entry Wire Line
	7800 2700 7900 2800
Text Label 8100 3600 0    40   ~ 0
ABUS_A19
Wire Wire Line
	7900 3600 8650 3600
Text Label 8100 3700 0    40   ~ 0
ABUS_A21
Wire Wire Line
	7900 3700 8650 3700
Text Label 8100 3800 0    40   ~ 0
ABUS_A23
Wire Wire Line
	7900 3800 8650 3800
Entry Wire Line
	7800 3700 7900 3800
Text Label 7200 7650 0    40   ~ 0
ABUS_RD
Text Label 7200 7750 0    40   ~ 0
ABUS_CS1
Text Label 7200 7850 0    40   ~ 0
ABUS_WR1
Wire Wire Line
	6950 7850 7700 7850
Wire Wire Line
	6950 7750 7700 7750
Wire Wire Line
	6950 7650 7700 7650
Text Label 7200 7350 0    40   ~ 0
ABUS_A4
Text Label 7200 7450 0    40   ~ 0
ABUS_A3
Text Label 7200 7550 0    40   ~ 0
ABUS_A2
Wire Wire Line
	6950 7550 7700 7550
Wire Wire Line
	6950 7450 7700 7450
Wire Wire Line
	6950 7350 7700 7350
Text Label 7200 7250 0    40   ~ 0
ABUS_A5
Text Label 7200 6650 0    40   ~ 0
ABUS_A14
Text Label 7200 6750 0    40   ~ 0
ABUS_A7
Text Label 7200 7150 0    40   ~ 0
ABUS_A6
Wire Wire Line
	6950 7150 7700 7150
Wire Wire Line
	6950 6750 7700 6750
Wire Wire Line
	6950 6650 7700 6650
Wire Wire Line
	6950 7250 7700 7250
Text Label 7200 6550 0    40   ~ 0
ABUS_A16
Text Label 7200 6250 0    40   ~ 0
ABUS_A22
Text Label 7200 6350 0    40   ~ 0
ABUS_A20
Text Label 7200 6450 0    40   ~ 0
ABUS_A18
Text Label 7200 6150 0    40   ~ 0
ABUS_A24
Wire Wire Line
	6950 6150 7700 6150
Wire Wire Line
	6950 6450 7700 6450
Wire Wire Line
	6950 6350 7700 6350
Wire Wire Line
	6950 6250 7700 6250
Wire Wire Line
	6950 6550 7700 6550
$Comp
L Logic_LevelTranslator:SN74LVC1T45DBV U8
U 1 1 69C1D651
P 3250 14950
F 0 "U8" H 3650 14400 50  0000 L CNN
F 1 "SN74LVC1T45DBV" H 3300 14300 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23-6" H 3250 14500 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/sn74lvc1t45.pdf" H 2350 14300 50  0001 C CNN
	1    3250 14950
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3150 14550 3150 14300
Wire Wire Line
	2250 14300 3150 14300
Wire Wire Line
	3350 14300 3350 14550
Text Label 10350 3800 0    40   ~ 0
ABUS_3V_A23
Text Label 10350 3700 0    40   ~ 0
ABUS_3V_A21
Text Label 10350 3600 0    40   ~ 0
ABUS_3V_A19
Text Label 10350 3500 0    40   ~ 0
ABUS_3V_A17
Wire Wire Line
	10150 3500 10900 3500
Wire Wire Line
	10150 3600 10900 3600
Wire Wire Line
	10150 3700 10900 3700
Wire Wire Line
	10150 3800 10900 3800
Wire Wire Line
	3800 2650 3800 2100
Connection ~ 3800 2650
Entry Wire Line
	2150 2950 2250 2850
Wire Wire Line
	2250 2850 4000 2850
Text Label 8100 3900 0    40   ~ 0
RESET
Wire Wire Line
	7900 3900 8650 3900
Entry Wire Line
	7800 3800 7900 3900
Text Label 8200 17950 0    40   ~ 0
ILRCK_3V
Wire Wire Line
	8000 17950 8750 17950
Text Label 22650 3700 0    40   ~ 0
ABUS_3V_D7
Text Label 22650 3900 0    40   ~ 0
ABUS_3V_D6
Text Label 22650 4300 0    40   ~ 0
ABUS_3V_D5
Text Label 22650 4400 0    40   ~ 0
ABUS_3V_D4
Text Label 22650 4500 0    40   ~ 0
ABUS_3V_D15
Text Label 22650 4600 0    40   ~ 0
ABUS_3V_D14
Text Label 22650 4800 0    40   ~ 0
ABUS_3V_D13
Text Label 22650 4900 0    40   ~ 0
ABUS_3V_D12
Text Label 8050 14450 0    40   ~ 0
+3_3V
$Comp
L power:GND #PWR068
U 1 1 6E6715F2
P 7600 15500
F 0 "#PWR068" H 7600 15250 50  0001 C CNN
F 1 "GND" H 7600 15350 50  0000 C CNN
F 2 "" H 7600 15500 60  0000 C CNN
F 3 "" H 7600 15500 60  0000 C CNN
	1    7600 15500
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C44
U 1 1 6E6715F8
P 8550 14550
F 0 "C44" H 8560 14620 50  0000 L CNN
F 1 "0.1uF" H 8560 14470 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 8550 14550 60  0001 C CNN
F 3 "" H 8550 14550 60  0000 C CNN
	1    8550 14550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR063
U 1 1 6E6715FF
P 8550 14650
F 0 "#PWR063" H 8550 14400 50  0001 C CNN
F 1 "GND" H 8550 14500 50  0001 C CNN
F 2 "" H 8550 14650 60  0000 C CNN
F 3 "" H 8550 14650 60  0000 C CNN
	1    8550 14650
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C45
U 1 1 6E671605
P 6600 14600
F 0 "C45" H 6610 14670 50  0000 L CNN
F 1 "0.1uF" H 6610 14520 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 6600 14600 60  0001 C CNN
F 3 "" H 6600 14600 60  0000 C CNN
	1    6600 14600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR064
U 1 1 6E67160C
P 6600 14700
F 0 "#PWR064" H 6600 14450 50  0001 C CNN
F 1 "GND" H 6600 14550 50  0001 C CNN
F 2 "" H 6600 14700 60  0000 C CNN
F 3 "" H 6600 14700 60  0000 C CNN
	1    6600 14700
	1    0    0    -1  
$EndComp
Wire Wire Line
	6600 14500 6600 14450
Wire Wire Line
	7700 14450 8100 14450
$Comp
L Logic_LevelTranslator:SN74LVC1T45DBV U9
U 1 1 6E671614
P 7600 15100
F 0 "U9" H 8300 14800 50  0000 L CNN
F 1 "SN74LVC1T45DBV" H 8200 14700 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23-6" H 7600 14650 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/sn74lvc1t45.pdf" H 6700 14450 50  0001 C CNN
	1    7600 15100
	-1   0    0    -1  
$EndComp
Wire Wire Line
	7500 14700 7500 14450
Wire Wire Line
	6600 14450 7500 14450
Wire Wire Line
	7700 14450 7700 14700
$Comp
L power:GND #PWR077
U 1 1 6CAAC4CD
P 3700 17050
F 0 "#PWR077" H 3700 16800 50  0001 C CNN
F 1 "GND" H 3700 16900 50  0000 C CNN
F 2 "" H 3700 17050 60  0000 C CNN
F 3 "" H 3700 17050 60  0000 C CNN
	1    3700 17050
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 16200 3400 16450
Wire Wire Line
	2300 16200 3200 16200
Wire Wire Line
	3200 16450 3200 16200
$Comp
L Logic_LevelTranslator:SN74LVC1T45DBV U11
U 1 1 6C5F1457
P 3300 16850
F 0 "U11" H 4000 16550 50  0000 L CNN
F 1 "SN74LVC1T45DBV" H 3900 16450 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23-6" H 3300 16400 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/sn74lvc1t45.pdf" H 2400 16200 50  0001 C CNN
	1    3300 16850
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3400 16200 4250 16200
Wire Wire Line
	2300 16250 2300 16200
$Comp
L power:GND #PWR075
U 1 1 6C5F144B
P 2300 16450
F 0 "#PWR075" H 2300 16200 50  0001 C CNN
F 1 "GND" H 2300 16300 50  0001 C CNN
F 2 "" H 2300 16450 60  0000 C CNN
F 3 "" H 2300 16450 60  0000 C CNN
	1    2300 16450
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C49
U 1 1 6C5F1444
P 2300 16350
F 0 "C49" H 2310 16420 50  0000 L CNN
F 1 "0.1uF" H 2310 16270 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 2300 16350 60  0001 C CNN
F 3 "" H 2300 16350 60  0000 C CNN
	1    2300 16350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR074
U 1 1 6C5F143E
P 4250 16400
F 0 "#PWR074" H 4250 16150 50  0001 C CNN
F 1 "GND" H 4250 16250 50  0001 C CNN
F 2 "" H 4250 16400 60  0000 C CNN
F 3 "" H 4250 16400 60  0000 C CNN
	1    4250 16400
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C48
U 1 1 6C5F1437
P 4250 16300
F 0 "C48" H 4260 16370 50  0000 L CNN
F 1 "0.1uF" H 4260 16220 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 4250 16300 60  0001 C CNN
F 3 "" H 4250 16300 60  0000 C CNN
	1    4250 16300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR078
U 1 1 6C5F1431
P 3300 17250
F 0 "#PWR078" H 3300 17000 50  0001 C CNN
F 1 "GND" H 3300 17100 50  0000 C CNN
F 2 "" H 3300 17250 60  0000 C CNN
F 3 "" H 3300 17250 60  0000 C CNN
	1    3300 17250
	1    0    0    -1  
$EndComp
Text Label 3750 16200 0    40   ~ 0
+3_3V
Wire Wire Line
	2150 16850 2900 16850
Text Label 4650 16850 0    40   ~ 0
SSEL_3V
Text Label 2350 16850 0    40   ~ 0
SSEL
Wire Wire Line
	8000 15300 8100 15300
Wire Wire Line
	8100 15300 8100 14450
Connection ~ 8100 14450
Wire Wire Line
	8100 14450 8550 14450
Text Label 8050 15900 0    40   ~ 0
+3_3V
$Comp
L power:GND #PWR076
U 1 1 6EA1ABFA
P 7600 16950
F 0 "#PWR076" H 7600 16700 50  0001 C CNN
F 1 "GND" H 7600 16800 50  0000 C CNN
F 2 "" H 7600 16950 60  0000 C CNN
F 3 "" H 7600 16950 60  0000 C CNN
	1    7600 16950
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C46
U 1 1 6EA1AC00
P 8550 16000
F 0 "C46" H 8560 16070 50  0000 L CNN
F 1 "0.1uF" H 8560 15920 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 8550 16000 60  0001 C CNN
F 3 "" H 8550 16000 60  0000 C CNN
	1    8550 16000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR071
U 1 1 6EA1AC07
P 8550 16100
F 0 "#PWR071" H 8550 15850 50  0001 C CNN
F 1 "GND" H 8550 15950 50  0001 C CNN
F 2 "" H 8550 16100 60  0000 C CNN
F 3 "" H 8550 16100 60  0000 C CNN
	1    8550 16100
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C47
U 1 1 6EA1AC0D
P 6600 16050
F 0 "C47" H 6610 16120 50  0000 L CNN
F 1 "0.1uF" H 6610 15970 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 6600 16050 60  0001 C CNN
F 3 "" H 6600 16050 60  0000 C CNN
	1    6600 16050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR072
U 1 1 6EA1AC14
P 6600 16150
F 0 "#PWR072" H 6600 15900 50  0001 C CNN
F 1 "GND" H 6600 16000 50  0001 C CNN
F 2 "" H 6600 16150 60  0000 C CNN
F 3 "" H 6600 16150 60  0000 C CNN
	1    6600 16150
	1    0    0    -1  
$EndComp
Wire Wire Line
	6600 15950 6600 15900
Wire Wire Line
	7700 15900 8100 15900
$Comp
L Logic_LevelTranslator:SN74LVC1T45DBV U10
U 1 1 6EA1AC1C
P 7600 16550
F 0 "U10" H 8300 16250 50  0000 L CNN
F 1 "SN74LVC1T45DBV" H 8200 16150 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23-6" H 7600 16100 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/sn74lvc1t45.pdf" H 6700 15900 50  0001 C CNN
	1    7600 16550
	-1   0    0    -1  
$EndComp
Wire Wire Line
	7500 16150 7500 15900
Wire Wire Line
	6600 15900 7500 15900
Wire Wire Line
	7700 15900 7700 16150
Wire Wire Line
	8000 16750 8100 16750
Wire Wire Line
	8100 16750 8100 15900
Connection ~ 8100 15900
Wire Wire Line
	8100 15900 8550 15900
Text Label 8050 17300 0    40   ~ 0
+3_3V
$Comp
L power:GND #PWR085
U 1 1 6EADAB78
P 7600 18350
F 0 "#PWR085" H 7600 18100 50  0001 C CNN
F 1 "GND" H 7600 18200 50  0000 C CNN
F 2 "" H 7600 18350 60  0000 C CNN
F 3 "" H 7600 18350 60  0000 C CNN
	1    7600 18350
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C50
U 1 1 6EADAB7E
P 8550 17400
F 0 "C50" H 8560 17470 50  0000 L CNN
F 1 "0.1uF" H 8560 17320 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 8550 17400 60  0001 C CNN
F 3 "" H 8550 17400 60  0000 C CNN
	1    8550 17400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR080
U 1 1 6EADAB85
P 8550 17500
F 0 "#PWR080" H 8550 17250 50  0001 C CNN
F 1 "GND" H 8550 17350 50  0001 C CNN
F 2 "" H 8550 17500 60  0000 C CNN
F 3 "" H 8550 17500 60  0000 C CNN
	1    8550 17500
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C51
U 1 1 6EADAB8B
P 6600 17450
F 0 "C51" H 6610 17520 50  0000 L CNN
F 1 "0.1uF" H 6610 17370 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 6600 17450 60  0001 C CNN
F 3 "" H 6600 17450 60  0000 C CNN
	1    6600 17450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR081
U 1 1 6EADAB92
P 6600 17550
F 0 "#PWR081" H 6600 17300 50  0001 C CNN
F 1 "GND" H 6600 17400 50  0001 C CNN
F 2 "" H 6600 17550 60  0000 C CNN
F 3 "" H 6600 17550 60  0000 C CNN
	1    6600 17550
	1    0    0    -1  
$EndComp
Wire Wire Line
	6600 17350 6600 17300
Wire Wire Line
	7700 17300 8100 17300
$Comp
L Logic_LevelTranslator:SN74LVC1T45DBV U12
U 1 1 6EADAB9A
P 7600 17950
F 0 "U12" H 8300 17650 50  0000 L CNN
F 1 "SN74LVC1T45DBV" H 8200 17550 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23-6" H 7600 17500 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/sn74lvc1t45.pdf" H 6700 17300 50  0001 C CNN
	1    7600 17950
	-1   0    0    -1  
$EndComp
Wire Wire Line
	7500 17550 7500 17300
Wire Wire Line
	6600 17300 7500 17300
Wire Wire Line
	7700 17300 7700 17550
Wire Wire Line
	8000 18150 8100 18150
Wire Wire Line
	8100 18150 8100 17300
Connection ~ 8100 17300
Wire Wire Line
	8100 17300 8550 17300
Connection ~ 5550 2650
Wire Wire Line
	12950 17250 13750 17250
Text Label 12950 17850 2    40   ~ 0
USB_DM
Text Label 12950 17950 2    40   ~ 0
USB_DP
Wire Wire Line
	24600 8800 25600 8800
Wire Wire Line
	24600 8900 25600 8900
Text Label 25300 8800 2    40   ~ 0
USB_DM
Text Label 25300 8900 2    40   ~ 0
USB_DP
Wire Wire Line
	11300 17850 11400 17850
Text Label 22650 9400 0    40   ~ 0
ISD_3V
Text Label 22650 10300 0    40   ~ 0
IBCK_3V
Wire Wire Line
	22450 10300 23200 10300
Wire Wire Line
	22450 9400 23200 9400
Text Label 24800 9200 0    40   ~ 0
ILRCK_3V
Wire Wire Line
	24600 9200 25350 9200
Wire Wire Line
	22450 5300 23200 5300
Wire Wire Line
	22450 5400 23200 5400
Text Label 22650 5300 0    40   ~ 0
BUFFSPI_MISO
Text Label 22650 5400 0    40   ~ 0
BUFFSPI_MOSI
Wire Wire Line
	22450 5700 23200 5700
Wire Wire Line
	22450 6000 23200 6000
Text Label 22650 5700 0    40   ~ 0
BUFFSPI_CS
Text Label 22650 6000 0    40   ~ 0
BUFFSPI_SCK
Wire Wire Line
	24600 8300 25350 8300
Wire Wire Line
	24600 8400 25350 8400
Text Label 24800 8300 0    40   ~ 0
BUFFSPI_MISO
Text Label 24800 8400 0    40   ~ 0
BUFFSPI_MOSI
Wire Wire Line
	24600 8200 25350 8200
Text Label 24800 8200 0    40   ~ 0
BUFFSPI_SCK
Wire Wire Line
	24600 8100 25350 8100
Text Label 24800 8100 0    40   ~ 0
BUFFSPI_CS
Wire Wire Line
	28700 17200 29250 17200
Text Label 29400 17200 2    40   ~ 0
SD_DAT2
Text Label 29400 17300 2    40   ~ 0
SD_DAT3
Wire Wire Line
	28700 17400 28850 17400
Text Label 29400 17400 2    40   ~ 0
SD_CMD
Wire Wire Line
	28700 17600 29700 17600
Text Label 29400 17600 2    40   ~ 0
SD_CLK
Text Label 29400 17800 2    40   ~ 0
SD_DAT0
Text Label 29400 17900 2    40   ~ 0
SD_DAT1
Wire Wire Line
	28700 18000 29700 18000
Wire Wire Line
	28650 18100 29650 18100
Text Label 29400 18000 2    40   ~ 0
SD_DET_A
Text Label 29400 18100 2    40   ~ 0
SD_DET_B
Text Label 29250 17500 0    40   ~ 0
+3_3V
$Comp
L power:GND #PWR060
U 1 1 726C698B
P 29600 18350
F 0 "#PWR060" H 29600 18100 50  0001 C CNN
F 1 "GND" H 29600 18200 50  0001 C CNN
F 2 "" H 29600 18350 60  0000 C CNN
F 3 "" H 29600 18350 60  0000 C CNN
	1    29600 18350
	1    0    0    -1  
$EndComp
Wire Wire Line
	29700 17700 29600 17700
Wire Wire Line
	29600 17700 29600 18350
$Comp
L power:GND #PWR059
U 1 1 728584E4
P 31550 18350
F 0 "#PWR059" H 31550 18100 50  0001 C CNN
F 1 "GND" H 31550 18200 50  0001 C CNN
F 2 "" H 31550 18350 60  0000 C CNN
F 3 "" H 31550 18350 60  0000 C CNN
	1    31550 18350
	1    0    0    -1  
$EndComp
Wire Wire Line
	24600 9500 25600 9500
Wire Wire Line
	22200 10400 23200 10400
Text Label 25300 9500 2    40   ~ 0
SD_DAT2
Text Label 22900 10400 2    40   ~ 0
SD_DAT3
Wire Wire Line
	22200 9100 23200 9100
Text Label 22900 9100 2    40   ~ 0
SD_CMD
Wire Wire Line
	24600 9600 25600 9600
Text Label 25300 9600 2    40   ~ 0
SD_CLK
Wire Wire Line
	22200 10100 23200 10100
Wire Wire Line
	24600 9400 25600 9400
Text Label 22900 10100 2    40   ~ 0
SD_DAT0
Text Label 25300 9400 2    40   ~ 0
SD_DAT1
Wire Wire Line
	22200 9800 23200 9800
Wire Wire Line
	22200 9900 23200 9900
Text Label 22900 9800 2    40   ~ 0
SD_DET_A
Text Label 22900 9900 2    40   ~ 0
SD_DET_B
Text Label 24750 2900 0    40   ~ 0
BUFFSPI_SYNC
Wire Wire Line
	24600 10000 25350 10000
Text Label 24850 10000 0    40   ~ 0
BUFFSPI_SYNC
$Comp
L Device:C_Small C39
U 1 1 75C6A6DB
P 28000 17650
F 0 "C39" H 28010 17720 50  0000 L CNN
F 1 "0.1uF" H 27900 17450 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 28000 17650 60  0001 C CNN
F 3 "" H 28000 17650 60  0000 C CNN
	1    28000 17650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR055
U 1 1 75C6A6E2
P 28000 17750
F 0 "#PWR055" H 28000 17500 50  0001 C CNN
F 1 "GND" H 28000 17600 50  0001 C CNN
F 2 "" H 28000 17750 60  0000 C CNN
F 3 "" H 28000 17750 60  0000 C CNN
	1    28000 17750
	1    0    0    -1  
$EndComp
Wire Wire Line
	28000 17500 28000 17550
Wire Wire Line
	28000 17500 29700 17500
$Comp
L Device:C_Small C55
U 1 1 607C6AC6
P 20450 18950
F 0 "C55" H 20460 19020 50  0000 L CNN
F 1 "0.1uF" H 20460 18870 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 20450 18950 60  0001 C CNN
F 3 "" H 20450 18950 60  0000 C CNN
	1    20450 18950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR086
U 1 1 607C6C74
P 20450 19050
F 0 "#PWR086" H 20450 18800 50  0001 C CNN
F 1 "GND" H 20450 18900 50  0001 C CNN
F 2 "" H 20450 19050 60  0000 C CNN
F 3 "" H 20450 19050 60  0000 C CNN
	1    20450 19050
	1    0    0    -1  
$EndComp
Wire Wire Line
	20050 18650 20450 18650
Wire Wire Line
	20450 18850 20450 18650
Connection ~ 20450 18650
Wire Wire Line
	20450 18650 22150 18650
$Comp
L power:GND #PWR087
U 1 1 60A4CDDE
P 22050 19500
F 0 "#PWR087" H 22050 19250 50  0001 C CNN
F 1 "GND" H 22050 19350 50  0001 C CNN
F 2 "" H 22050 19500 60  0000 C CNN
F 3 "" H 22050 19500 60  0000 C CNN
	1    22050 19500
	1    0    0    -1  
$EndComp
Text Label 3450 3250 0    40   ~ 0
SCSPCLK
Wire Wire Line
	3250 3250 4000 3250
Wire Wire Line
	24600 8500 25350 8500
Text Label 24800 8500 0    40   ~ 0
FPGA_60MHZ
Text Label 22650 5100 0    40   ~ 0
FPGA_60MHZ
$Comp
L Device:C_Small C38
U 1 1 61E255AC
P 22900 8200
F 0 "C38" H 22910 8270 50  0000 L CNN
F 1 "0.1uF" H 22800 8000 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 22900 8200 60  0001 C CNN
F 3 "" H 22900 8200 60  0000 C CNN
	1    22900 8200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR054
U 1 1 61E255B3
P 22900 8300
F 0 "#PWR054" H 22900 8050 50  0001 C CNN
F 1 "GND" H 22900 8150 50  0001 C CNN
F 2 "" H 22900 8300 60  0000 C CNN
F 3 "" H 22900 8300 60  0000 C CNN
	1    22900 8300
	1    0    0    -1  
$EndComp
Wire Wire Line
	22450 5000 23200 5000
Wire Wire Line
	23200 8100 22900 8100
Wire Wire Line
	22450 10200 23200 10200
Text Label 22650 10200 0    40   ~ 0
SCSPCLK
Wire Wire Line
	24600 10500 25350 10500
Wire Wire Line
	24600 10400 25350 10400
Wire Wire Line
	22450 9600 23200 9600
Text Label 22650 9600 0    40   ~ 0
ESP32_MOSI
Text Label 24700 10500 0    40   ~ 0
ESP32_CS
Text Label 24700 10400 0    40   ~ 0
ESP32_SCK
Wire Wire Line
	22450 9500 23200 9500
Text Label 22650 9500 0    40   ~ 0
ESP32_MISO
Wire Wire Line
	21400 18950 22150 18950
Text Label 21600 18950 0    40   ~ 0
ESP32_MOSI
Wire Wire Line
	21400 18850 22150 18850
Text Label 21600 18850 0    40   ~ 0
ESP32_MISO
Wire Wire Line
	21400 19050 22150 19050
Wire Wire Line
	21400 19150 22150 19150
Text Label 21600 19050 0    40   ~ 0
ESP32_CS
Text Label 21600 19150 0    40   ~ 0
ESP32_SCK
$Bitmap
Pos 23050 20950
Scale 1.000000
Data
89 50 4E 47 0D 0A 1A 0A 00 00 00 0D 49 48 44 52 00 00 03 E8 00 00 01 BD 08 03 00 00 00 B1 A1 AC 
BB 00 00 00 03 73 42 49 54 08 08 08 DB E1 4F E0 00 00 02 F7 50 4C 54 45 FF FF FF F7 F7 F7 F2 F1 
F1 F0 F0 EF ED ED ED FE FD FD D7 D8 D8 BA B9 B9 B5 B4 B4 B7 B6 B6 A7 A7 A7 A1 A1 A1 AB AA AA C8 
C7 C7 DC DC DD F5 F5 F5 FB FD FD F9 F8 F8 D4 D4 D4 BD BC BC B0 AF AF AC AB AB AE AE AD C2 C1 C1 
E6 E6 E5 E9 EA E9 EB EB EB 93 92 92 88 88 88 82 82 81 7C 7C 7C 53 53 52 1C 1C 1D 00 00 00 5F 5F 
5F 9D 9C 9B 2A 2A 2A 07 06 06 CF D0 D0 5A 59 59 0B 0A 0A 03 03 03 6E 6D 6D 30 30 30 0F 0E 0D 13 
13 13 FA FA FA 64 64 64 B2 B1 B1 3F 3F 3F 17 17 18 E2 E1 E0 68 68 67 97 97 97 20 20 20 72 72 71 
CC CC CB 3C 3C 3C 42 42 42 4C 4B 4C 77 77 76 2E 2E 2E EC EC EC 8D 8D 8D 44 45 45 FC FA FB 43 43 
44 FB EB E8 EA AA AA DE 79 79 E4 8E 8D E9 C3 C3 1B 17 10 2E 2B 1F 36 33 25 2F 25 18 24 1D 14 FB 
E5 D9 E8 93 93 E2 B3 B3 F3 F3 F3 C0 00 00 BD 00 00 BB 00 00 BF 00 00 CA 2B 2B 70 6A 4F 93 89 63 
9C 93 6D 8D 84 61 63 5D 45 53 4E 3A 99 90 6B 7C 75 57 F9 DB C6 9F 96 70 A3 9A 72 96 8D 67 B9 00 
00 FD F6 F1 85 7D 5D FE FF FF C5 14 14 D7 5C 5C A7 9D 77 47 47 47 D1 45 45 2C 2C 2C 35 35 34 AD 
A5 87 CA C4 B3 D7 D3 C6 C3 BE A9 48 41 30 B6 AF 94 3F 3B 2C D1 CC BC BC B6 A0 EE EA E3 24 24 24 
38 38 38 98 4E 4E A9 6A 6A DD D8 D2 CD A0 A0 32 32 32 69 08 08 52 02 02 80 5C 44 28 28 28 7F 00 
00 BF 80 80 B6 93 93 99 91 7E 7B 2E 2E 26 26 26 D5 E5 F4 EB F2 F7 F0 F6 FC B8 D4 ED A3 C7 E7 92 
BC E3 9D C3 E6 A7 CA E9 E3 B9 E6 DB A5 DF D7 9D DB DA A2 DE E0 B2 E3 F7 DB F3 96 BF E4 9A C1 E5 
9C C2 E5 E7 C5 E9 AC CD EA DE EB F7 EB CC ED 9F C6 EA A5 CD F2 AD D8 FE A2 CA EE A9 D2 F7 E5 AD 
EA EE B3 F3 DF A9 E3 90 B3 D4 5B 72 86 64 7C 93 47 59 69 51 65 77 6F 8A A2 77 94 AF 88 A9 C8 37 
44 51 C4 94 C8 94 6F 97 B2 86 B6 34 26 35 A3 7A A6 7A 5C 7C 22 29 30 80 A0 BD 5A 44 5C 1C 21 27 
96 BB DC 3F 4E 5D 57 42 2C 2E 39 44 FC F9 F2 CB E0 F2 E9 EE F3 8D 89 86 FF FD F8 B4 D8 F8 F7 C9 
A9 F5 BA 91 F4 AC 7B F2 A8 75 F4 B5 8A F6 BD 96 F3 AF 80 F3 B0 82 F4 B1 83 F9 D4 BA FE FA F2 F2 
A8 74 FF BA 89 FF C3 90 F7 B3 84 FB B5 86 FE B8 88 FF BE 8C 27 31 3A 6B 4F 38 93 6A 4F B2 80 5F 
A4 77 58 C1 8C 67 3D 2C 20 D2 98 71 4A 36 27 E0 A2 78 EC AB 7E FF C9 95 F5 B8 8D E6 EA EE FF F3 
C1 FD EB B0 FF DA 66 FE D5 5C FE DF 80 FB D8 4C F7 DE 77 A8 A5 97 A4 79 2C C7 9E 5D D7 9A 2B FF 
E6 6C D2 97 2B D2 96 2A 97 82 3C 82 5D 19 E1 A1 2C 72 53 15 DC BB 57 A9 94 4C 88 6C 2C F4 E2 93 
61 4D 00 82 67 01 7A 5F 00 FF D4 2A FF D2 1E C2 10 08 7C 00 00 00 09 70 48 59 73 00 00 0E 74 00 
00 0E 74 01 6B 24 B3 D6 00 00 20 00 49 44 41 54 78 9C EC BD 7F 40 93 E7 BD FF 7D 91 1F 80 40 48 
02 48 00 51 72 21 81 04 12 90 80 40 F8 25 A1 BF 40 E8 9A AA 83 08 C1 84 56 3A 52 D0 FA A3 4A 3A 
87 CA BA D5 6E ED D8 69 7B A6 7E BB 6F 42 62 45 45 A1 EB 5A 9D 02 A7 FB F6 BB B5 9B BA 73 F8 29 
2A 88 6E E7 9C F6 3C CF BE 9D E7 F4 79 4E B7 E7 DF E7 BA EE 3B 81 24 24 E1 0E F7 0D D2 2C 6F 5B 
48 EE DC DC B9 93 FB 7A DD 9F EB E7 E7 0D 40 50 41 05 15 54 50 41 05 15 54 50 2B A2 10 16 9B C5 
E6 78 14 9B 15 C2 7D D4 A7 17 54 50 41 31 A1 D0 B0 F0 35 E1 11 91 1E 14 11 15 CE 8B E6 F0 1F F5 
09 06 15 54 50 0B 25 10 FA A7 98 D8 B0 D8 D8 B8 A8 B5 6B E3 DD FE AD 8D 8A 8A 8A 88 58 2B 0A 4D 
48 4C 62 F1 FD 3C EA A3 50 B0 F6 11 D4 DF 89 12 43 45 11 EB 92 FD 53 04 E2 9C 00 7D A1 08 D2 23 
22 A2 D6 46 AC 5B BF C1 CF C3 3E 02 AD 8B 12 C5 70 1E F5 25 08 2A A8 65 56 22 2F 32 45 0C FD 56 
6A B8 C8 1B E8 24 ED 11 51 51 1B 53 D3 24 FE 1F F9 11 48 9C BA 31 3D F1 51 5F 88 A0 82 5A 3E B1 
C3 33 A4 B2 25 A0 21 4B 5D E3 1B 74 3B ED 99 59 72 C6 B1 5C 0E C9 14 29 22 F6 A3 BE 18 41 05 B5 
3C CA 16 E5 2C 35 E4 E6 2C 0E 7A D4 DA F8 4D 71 6B 37 E4 2A 18 45 72 D9 A4 C8 49 17 3C EA 0B 12 
54 50 CB 20 CE 7A E9 92 B1 A0 00 3A 6A AC 23 D4 37 C5 AD 4B 11 7F 33 6A F0 CA F5 AC 47 7D 49 82 
0A 8A 71 E5 E5 D3 E0 8F 0A E8 44 BF DC DA B8 B8 B5 9B 33 0A BE 11 A8 4B 0A 13 1E F5 45 09 2A 28 
86 55 94 4B 87 09 6A A0 93 61 7D 53 78 5C 64 A1 4A 21 97 2E BB E4 48 4B E9 72 98 53 71 CC A3 BE 
2C 41 05 C5 A8 F2 4A E8 00 41 1D 74 02 F5 B8 4D 6B 23 36 AF CF 5C 76 95 AE 5F 5F BA 84 21 04 27 
95 04 7B DF 83 0A 24 B1 53 68 F1 E0 0F E8 44 0D 3E 7E 53 38 6A AE 6F 5A 56 C5 C5 C5 8A 78 B1 65 
F4 3E 58 6A F9 A3 BE 34 41 05 C5 98 04 C9 F4 70 F0 0F 74 92 75 3C 8B 6E 39 85 8E 1E 16 2B 5A 43 
13 74 E9 96 47 7D 6D 82 0A 8A 31 6D A4 3B E6 E5 2F E8 04 EA CB AE 35 B1 A2 70 9A A0 43 29 EF 51 
5F 9C A0 82 62 48 02 7A 0D F4 25 81 8E 59 F7 6F 77 7F 45 80 4E 37 A2 A3 8F 16 9C 39 13 54 80 68 
23 ED D1 AE 25 81 BE CC 8A 60 06 74 79 D4 A3 BE 3C 41 05 C5 88 12 68 07 F4 55 09 3A 43 11 1D 56 
04 43 7A 50 01 A1 48 65 40 82 CE 50 44 87 30 FD 51 5F A0 A0 82 62 42 39 F4 59 58 8D A0 33 15 D1 
E1 66 F5 A3 BE 42 41 05 45 5F 21 2A FA 2C 60 D0 C3 E2 57 17 E8 8C 45 F4 94 E0 4C D8 A0 02 40 E1 
05 81 09 3A 63 11 5D 19 1C 61 0B 2A 00 94 CC C0 1A F1 D5 58 75 67 2C A2 4B 22 1E F5 25 0A 2A 28 
FA 4A A5 B5 EE 63 F5 82 CE 58 44 97 24 3F EA 4B 14 54 50 F4 45 7F 70 6D 75 82 CE 5C 44 2F 0C 66 
8C 0C EA 9B AF 4A FA 28 AC 4A D0 19 8B E8 B2 7C E1 A3 BE 46 41 05 45 5B C5 F4 51 58 95 A0 33 16 
D1 65 39 21 8F FA 1A 05 15 14 6D 31 05 7A D8 2A 03 9D B9 88 1E 04 3D A8 00 10 63 A0 AF B2 E1 B5 
60 44 0F 2A 28 27 31 05 FA 9A 55 06 7A 30 A2 07 15 94 93 02 15 F4 60 44 0F 2A 28 27 05 2A E8 C1 
88 1E 54 50 4E 0A 54 D0 83 11 3D A8 A0 9C 14 A8 A0 07 23 7A 50 41 39 29 50 41 0F 46 F4 A0 82 72 
52 A0 82 1E 8C E8 41 05 E5 A4 40 05 3D 18 D1 83 0A CA 49 81 0A 7A 30 A2 07 15 94 93 02 15 F4 60 
44 0F 2A 28 27 05 2A E8 C1 88 1E 54 50 4E 0A 54 D0 83 11 3D A8 A0 9C 14 A8 A0 07 23 7A 50 41 39 
29 50 41 0F 46 F4 A0 82 72 52 A0 82 1E 8C E8 41 05 E5 A4 40 05 3D 18 D1 BF 81 52 0B F9 B4 14 12 
38 66 1B 8F 3D FE 04 3D 3D F9 94 EB 01 17 82 2E AF AA DE BA B5 A6 4A FA CD 06 DD EF 88 2E 93 57 
D5 D6 56 C9 17 24 C5 75 07 FD E9 6F D1 BC 00 CF AC 60 71 59 66 D1 E4 92 2F 74 C9 BB C9 D5 94 97 
27 D1 52 79 39 2B 40 32 79 3E FE EC B6 ED F4 B4 6D C7 B7 9F 76 3E A2 3B E8 F2 AD 75 F5 5A A4 9D 
0D D5 94 5D 56 57 23 E8 7E 46 74 59 6D 63 5D BD 4E 57 DF D4 58 EB 86 BA 2B E8 DC 27 E8 5E 81 6D 
CF 7E 7B D7 0A 97 9A 65 92 9A 43 1B 4C 0E DF E9 78 2C 04 2A 87 96 D0 F9 04 86 27 E6 33 DB B6 ED 
D8 F1 2C 2D ED D8 B1 ED 59 E7 43 BA 81 5E DB A4 D5 DB A5 6D A8 FA 06 83 EE 5F 44 97 36 EE 44 9F 
D8 80 3F 76 73 A3 C2 07 E8 4F 3E B7 83 E6 15 D8 B1 63 FB B3 CF AF 70 B9 59 16 71 CB CB 69 82 89 
FE 3E 69 9E F4 6C BA 98 93 87 CC 7E 84 5F 09 63 FA F6 36 7A 94 93 7A EE 5B 4E 87 74 05 7D EB 6E 
04 B8 AE 19 49 A7 D5 6B 9B 28 92 BE 1A 41 F7 2B A2 2B 1A F4 E4 E7 D6 E1 8F 5D 87 49 97 11 4D 17 
89 2B E8 2D 4F BF C0 C4 15 D8 FE C4 CA 17 1D E6 A5 49 A2 CF 25 A7 9C 33 57 D7 E6 33 01 3A 27 89 
EF EB 9C BF 21 12 D2 0D E7 F6 72 F6 1D A7 63 62 D0 25 8E DA 6A 6D BD 01 17 77 14 D4 71 A1 D7 1B 
28 92 BE 1A 41 F7 27 A2 4B EB 0C 7A 2D BE B7 69 75 F5 E8 63 B7 62 D2 95 19 52 04 BB 51 E1 1A D1 
9F DA C6 C4 15 D8 F6 ED 15 2F 3A CB 20 36 13 5C 96 27 09 1C C7 63 E4 C6 C1 29 D7 3C CA EF 84 21 
3D FF 1C 23 A0 6F 7B D1 E9 98 18 F4 B6 76 05 81 BA BC 01 73 AE DB B3 F7 A5 97 F6 B5 62 D2 B5 8D 
94 0C 9B 56 23 E8 7E 44 74 D9 7E E2 C6 A6 3F B0 6F EF 01 03 F1 B1 1B 20 14 67 CA 14 29 05 39 62 
17 D0 B9 8F 33 72 05 02 03 74 46 02 30 C7 09 74 46 8E 17 20 A0 33 50 CA 3C 80 2E CE 4C 36 2A 50 
2D F5 20 2E F0 FA 97 71 C1 E6 6A 0E 69 51 91 D7 D5 7E 53 41 F7 23 A2 57 EF 36 20 CE 0F 1D 16 B4 
B4 70 0F 1F 42 77 3A 43 73 01 54 64 B4 67 24 E7 E4 B8 45 F4 C7 19 B9 02 81 01 7A D2 0A 80 AE E1 
F3 F9 1A E2 11 1B 3D 62 A1 DF 2C 3E F9 8C 3D F7 33 F0 40 6F F1 05 FA 8E 6D 58 3B D0 2F B2 2C F9 
A8 63 2E 00 1D CA 15 25 C9 29 50 82 02 7A B3 76 9F BD D1 C4 3E 84 EB F0 FB A9 84 F4 D5 08 BA 1F 
11 BD 11 35 CF EB 0F B0 1C 1F BB 1E B5 D3 51 4D A6 A0 34 B5 23 B7 C0 AD 33 EE F1 ED DE BE FA 1D 
CE 4F E6 BE FF 1D 1E 2F 43 60 80 EE 29 A2 63 1C ED F4 69 EC 88 92 4F 35 AC F9 9F D4 41 67 89 22 
22 22 62 F1 5F F1 13 C2 23 D6 C6 64 73 58 45 51 E8 78 EC D0 88 04 36 87 9D 17 11 BD 80 F4 40 00 
DD 57 44 DF F1 EC 8B 58 2F 3C FB 22 D1 61 B7 ED DB 2F 3E EB 95 F4 85 A0 CB A4 A6 75 F9 B0 76 A7 
1E 15 78 3E 78 FE C9 57 BE 9B 87 8A BC BE 5E AB AF A3 E2 AA BC 1A 41 A7 1E D1 51 0B 5D D7 DC 7A 
04 80 5D 4F 7C 8F 0F C0 61 D4 68 69 6D 42 1F 5B 2A 91 76 E6 4A 17 07 7D C7 B6 17 D0 37 FF AC FD 
06 8B AF C3 0B DB D1 F7 8F 11 47 AF 78 BA 0C 01 0B 3A 3B 34 2A 22 72 53 02 02 9C A5 11 45 45 85 
09 59 9C 84 88 50 04 63 62 5C 3A A2 35 29 5C B4 80 74 9F A0 0B 3A A1 58 0E 33 92 D8 DC 30 25 2E 
A6 A5 20 64 23 8C 61 71 D4 F9 30 56 C3 E1 47 40 DE 82 E3 05 02 E8 3E 23 3A 39 66 F6 9D 1D 4F 3F 
BD 7D 07 2A 7B BB 7C 74 1B 2D 00 5D 9A 92 9C 53 20 87 D5 3A D4 42 DF DB 02 78 47 8F 1D 3B 5E 0E 
B8 07 74 3A FD 4E 2A DD 71 AB 11 74 EA 11 BD B6 C9 A0 AB 3F C4 07 BB 5E 39 76 EC 95 5D 40 78 08 
D5 DD 77 A3 26 8B CC B4 BE B0 8C 42 44 DF F6 22 1E 2D 7B FC 05 FC 7D EF 78 E1 29 C0 05 CF 7F FB 
B9 6F 81 6D F8 32 3C 09 FE AE 40 E7 AF 83 4A 31 54 C4 68 34 89 15 F8 AB 4D C9 D3 B0 60 29 9F A3 
09 87 19 6A 0E 2B 14 26 0B FD 02 9D 6B 2A 01 20 06 16 82 30 98 11 22 00 C9 70 8B 20 4F B1 41 CD 
11 76 C1 7C 2E 47 5D D2 99 BD E0 4F 02 01 74 DF 11 1D BC F0 DC F6 ED DB B6 7F 07 8F C1 A1 92 F4 
9D ED D4 41 CF CD E8 C0 BD 71 5B 71 CD FD 25 F0 D8 2B C7 BE 7F F4 D8 AB 00 EC D3 36 EB 9B A9 34 
D2 57 23 E8 D4 23 7A F5 6E BD 6E E7 CB 00 FC E0 D8 F7 8F E1 8F FD 72 73 B3 61 67 35 CC 4D CE 28 
20 C6 D9 16 07 FD 89 ED CF BD 08 5E 24 6A 52 2F 3C F9 EC 73 2F 08 1F DF 8E 2F 00 BA 28 8F 7D CB 
D3 65 08 5C D0 37 43 C0 65 B7 8B 59 89 05 8A 68 2E 08 85 1D 00 64 74 B0 D9 21 1B 60 57 1E 9B 1F 
0F CB 17 54 B5 17 01 DD 28 64 83 2E A3 B0 44 89 1A E8 6C 6E 49 01 87 5F DC 2E 60 85 2A 2B C5 80 
9D D8 51 BA E0 BE 11 10 A0 2F 12 D1 11 E8 A8 8D FE 02 78 62 FB 8E ED 4F 78 8C 24 DE 40 EF 10 C3 
CE 9C 0E 58 8D 40 D7 BD 3C 0F FA 21 5D B3 BE 3E F0 23 BA 03 F4 1F 1E FB FE F7 8F CE 83 5E B2 31 
85 98 1A B8 78 1B 7D 1B BA BF 3E 0B BE 43 D4 DD 77 6C DF B6 6D FB D3 68 B7 A7 9F DA BE 03 01 FD 
A2 A7 71 F7 40 06 5D C8 16 AC 93 44 47 40 11 0A B6 82 08 18 2A D8 08 F3 58 1A 63 0A E4 69 D4 A5 
4A FE 82 3F 59 34 A2 67 03 58 98 20 2F E5 E2 C3 AF 81 B1 DC 2D 8A BC EC 8D E2 30 18 2A 8C 85 A1 
0B DB FC E5 81 30 8E EE 3B A2 3F BD EB 5B 2F 6C DB B1 7D D7 AE 67 B7 6D 7B DA 63 24 F1 06 BA A9 
23 2B 23 23 45 5A DB AC 45 75 58 2E 78 EA 35 54 87 3D 0C D4 7B 9A B5 FA DD DF 54 D0 A9 47 F4 DA 
DD A8 EA BE 8F 0F 9E 41 2D 96 D7 9E C1 55 F7 66 5C 75 97 8A 8D A5 F9 62 4A 9D 71 CF BE F0 C2 E3 
F6 A9 34 F8 F1 13 EA 17 B7 6D 7F 42 FD ED 6D DB BF B5 CB E3 FD 36 90 41 07 42 90 A1 54 A7 9C C0 
B1 9B 15 AD 28 45 35 EF 4D C2 3C 49 AC 72 7D 36 50 78 88 C0 BE 41 57 95 C5 6F AC 84 E9 A1 70 33 
FE 4B 4D 11 8C 15 46 C3 08 90 53 22 54 6E 06 5B 64 82 05 7F C1 E1 24 16 89 62 80 46 24 CA 03 09 
22 5E 39 08 15 F1 F8 DC 74 51 3A 08 E1 89 42 01 5B 24 4A 00 79 22 1E 1B 6D 2F 12 AA F1 76 3E 4F 
14 0D CA 45 A2 44 10 2D E2 B1 40 8C A8 48 2D 2C 42 DB 89 43 24 8A 44 49 78 BB 86 1B 23 E2 09 04 
78 BB 50 84 F6 4F B4 EF AF 41 FB F3 80 9A E7 FE 96 21 E8 2D 8B F0 AE AE 6F C9 CB E6 16 91 DB ED 
6F 99 20 12 E1 ED 22 2E C0 DB B9 78 7F 0E DA EE 33 A2 3F F1 C4 13 BB 50 58 41 75 F7 17 50 C5 D1 
D7 1C BA 05 A0 A7 54 96 18 25 C6 2C 79 93 5E 57 BF 27 0F B4 3C F5 EA AB 87 01 38 82 2A F2 FA 86 
6F 6A 67 1C F5 88 2E A9 6B 25 3A E3 D4 DF 7B E5 95 EF 3D 8F 3B E3 74 44 67 1C 94 77 55 52 EB 8C 
7B 12 BD 62 6F 2A ED C0 0C 3F 83 C2 FA 0B B8 EE DE F2 84 C7 FB ED B6 6F BF 2E 2A 12 08 9D 4A A4 
88 5E 89 8C 9E 2B 91 2C 7C 1C C6 4B 64 9E A7 12 E9 01 F4 90 CD 30 2A 3E 15 6E 01 ED B9 C4 F0 57 
82 B8 90 CB 56 A5 00 91 3C 31 BF 13 70 E0 26 7F 23 7A 31 54 28 52 F2 42 42 E1 3A 0C 3A 3F 0C 8A 
34 40 5A AA 11 47 02 55 09 28 49 59 D8 44 E7 94 B3 F8 2C 3E E0 B2 58 42 90 CD D2 A8 41 08 4B C3 
05 C4 26 0D 2B 04 08 58 AC 6C 20 64 69 04 68 93 86 CB 9D DB AE 76 DD AE F1 74 08 BC 5D 33 BF 9D 
D8 9F D8 0E 3C EE AF D1 38 DE 52 23 9C 3F 34 D0 E0 ED 78 57 B5 FD 10 02 BC 3F 20 B6 03 96 06 9F 
8A 46 E0 73 78 0D D5 1F B7 EF 12 A2 12 26 7C E2 B9 6F 3D FD 82 8F 89 1D 0B 40 6F CF CC 39 21 CB 
6D 83 8D 78 BE 0C 1E 67 7A 5E 0D 40 DE 9E 66 9D 5E 7F 90 02 29 AB 12 74 3F C6 D1 F1 F0 5A F3 01 
54 E5 7B FA 31 74 81 0E 35 13 C3 6B D2 76 54 71 97 98 E4 14 40 DF F1 02 8A E8 98 EB 67 ED 11 1D 
3C BE 6D C7 73 BB 9E 22 FB 4B 3C 82 2E F0 5A 9C 16 94 C8 10 BF 4A A4 80 89 12 19 E2 56 22 59 42 
4F 25 D2 53 44 DF 08 15 F2 F6 70 3E 30 A9 30 E8 38 A2 67 0B 33 95 20 BF 42 BD 11 72 D7 48 A3 FD 
1C 5E 23 3A E3 B8 2C 74 C3 C8 01 F8 69 B2 34 94 25 28 EC 48 97 87 0A 22 15 89 B2 88 85 F7 8D 80 
A8 BA FB 1E 47 DF F1 2C 6E 9A EF D8 B1 ED F1 A7 9F F3 DC 07 E4 15 74 49 81 58 26 93 4B 60 F5 4E 
3C 73 E4 C0 11 21 BA 92 2F ED C1 05 7E B7 62 51 4C 56 29 E8 D4 23 BA AC 86 9C 30 83 AA 32 00 D8 
27 CC D4 42 65 8E 44 72 42 9E A2 A4 02 FA 8E 6D DB 9E 7B FA 31 BC DC 85 7C FC 04 02 1C 51 8E AE 
84 E7 CB 10 D0 55 77 00 F8 1C 41 BE 22 09 91 CE 2F 82 51 7C 8D 08 F2 4C C9 DC 50 89 28 A3 C4 43 
55 7B D1 CE 38 FC 5B 93 21 4D 14 84 70 A3 95 19 7C 8E 46 24 49 6E 4B D2 84 C2 8D 0A 0F F7 8D 80 
E8 8C F3 DD 46 DF 86 4A D8 2E 54 B2 B6 7D 87 FB A4 DA 63 1F 90 57 D0 1D 92 EC 6F C5 53 DD 5B 0F 
20 19 F0 AC 6F 1D A5 80 BE 2A 41 F7 67 AE 7B A3 41 8F F0 6E 3D B4 77 EF A1 3D 3A C7 14 D8 7C 69 
57 69 67 A6 78 51 D0 77 90 5F FD D3 CF 3F B7 0D 5F 06 54 B3 22 40 DF F6 02 F7 C9 C7 9E F0 D4 A4 
0F 6C D0 43 88 DF 9B 60 3C 10 0A B9 19 50 C3 E6 08 14 A5 4A 1E 9F D5 96 5F 10 EE 21 02 FB 1E 47 
77 80 1E 2A 91 26 47 6D 91 C3 04 16 87 1D 2D 86 F9 7C 76 48 16 AC D0 2C 3C 5C 40 80 EE 2B A2 6F 
7B EA F1 17 5F FC 16 6A A3 A3 72 F7 3C D8 E5 73 4A B6 57 D0 51 73 D5 80 67 89 ED 44 AA D7 69 0D 
06 6A 53 DD 57 25 E8 FE AC 5E 93 D6 19 F0 7A 16 BC 1E 1D DD DE B4 06 BC A8 45 92 BB 61 43 46 7E 
B1 6C 71 D0 B7 EF 42 5F FD 13 E0 89 ED DB C0 53 DB 9F D8 F5 9D 17 BF 03 9E C1 F8 3F 03 9E 7F D6 
F3 FD 36 E0 41 E7 B0 53 60 61 E4 C6 12 A2 0F 0D E1 2E 66 B3 85 C9 D0 C3 E0 DA 22 A0 AB DB 8B C9 
7B 43 48 7A 0A BA 4E 19 31 F8 19 2B 05 C6 F3 39 21 99 64 07 5D 20 82 EE 2B A2 6F 7B F1 69 00 D4 
78 3A D6 8E ED DF 02 5E 22 C9 A2 A0 C3 AA 06 03 6A A7 EB B4 3A AD 56 6B D0 35 52 4C 3D B1 1A 41 
F7 6B 3D 7A 15 71 83 D3 E9 88 65 AA F6 35 7B D2 E2 76 79 97 94 CA 38 FA B7 71 D2 9E EF E0 FE B7 
C7 B7 3D 8B 3B E6 1E 47 80 A3 9A 15 78 C6 CB 6A C3 C0 05 7D 1D 24 C1 64 25 22 AE 61 41 2C 8E B9 
FC B5 30 95 8B 7B CC 3B 81 07 30 7D CF 75 07 5C FB 03 0D 9E 98 CD 25 AB EA 5C 80 DF 44 0D 42 3C 
1C 2E 20 40 F7 15 D1 77 6C 7B 0E 89 98 0D B7 63 FB 73 3E 39 F7 05 3A 94 ED 6F 22 F3 2F 18 B4 75 
D5 D4 E2 F9 EA 04 DD BF 0C 33 D2 C6 9D 08 75 AD 16 7D EE FA 46 D7 11 45 0A C3 6B F8 AB C7 F3 11 
D1 0F F4 E5 13 8F 89 2B E2 AD A3 24 60 41 E7 84 38 58 66 0B F1 2E 24 F5 7C 02 57 04 A0 27 30 83 
AB D7 3C 68 B9 56 AF B9 A8 76 7F 43 D3 EE DD 75 0D 07 A9 E6 97 59 9D A0 FB 99 33 4E 52 DD D8 44 
A6 92 DA EA 56 8D 09 AE 5E F3 A2 95 58 BD E6 BF 02 01 F4 96 E5 5A 8F EE 26 99 A2 AA 8A CA F0 F9 
AA 06 DD EF 2C B0 32 79 6D 4D 4D ED C2 CF ED 16 D1 83 EB D1 1D 62 7A 3D 3A 9F 91 C4 13 01 91 61 
E6 79 46 F2 9B 2C 0A BA DF 5A 8D A0 2F 31 AF FB C2 D6 8A 0B E8 CF 04 33 CC CC 89 C3 08 E8 89 73 
A0 33 94 33 4E F8 28 BF 13 A6 C4 50 CE B8 27 9D 0E 19 A8 A0 2F 4F 5E F7 60 CE B8 79 31 9D 33 0E 
B0 69 67 81 E5 04 4A 16 D8 6F 6D A7 1F 51 76 6C DB E6 9C FB 7A 65 40 8F 5A 1E F9 7C C7 E5 00 BD 
E5 3B CF D1 CE DB 87 2E C0 63 2B 5E 72 96 41 D9 74 93 C0 12 E9 99 9D 6A DA 5C 36 CD EC D1 49 49 
E5 6C 81 F7 13 FE 26 E9 89 1D 34 D3 BA 6F DF BE ED 05 17 0B 87 15 01 7D B9 82 BD 8F E3 2E 97 53 
CB 8B CF D2 BF 00 01 62 E1 20 E4 D0 06 93 E3 D2 75 C6 15 86 D0 93 9B 23 C4 37 59 BB BE 45 53 4F 
3E EE 9A 54 7C 25 40 8F 5A 1B BF 3C F2 41 FA B2 79 AF 3D F5 24 4D 3D 1E 10 F1 1C 4B 40 17 CC 05 
16 4A 5C 9A 7A 24 5F C3 72 A8 A5 45 F0 23 7A FA B1 5B DD C6 13 E8 52 B9 9C B2 4B 0B 05 D0 D1 0B 
11 CB A2 28 1F 31 7D F9 BC D7 5A 04 F4 E4 5F 69 E4 AA D5 C2 15 FB A7 F6 97 14 66 B9 14 B2 39 89 
74 EA 07 89 1C 76 A0 F8 E4 F1 53 C5 74 CB ED 89 CD 2E 47 5C 00 BA 7C 6B 63 03 D2 FE 6A EA E6 6B 
BE 41 47 F1 3C 22 33 35 67 71 E5 A3 7F 8E DF F9 14 F6 CF 29 8C 8C F3 7E 77 F1 17 F4 DA AD FB 1B 
1B F7 1F 74 77 64 72 07 FD C7 6F BC F9 13 5A EA FE E9 EB 7E 5C 70 D6 3F BC F5 F6 CA E9 9D 7F FC 
99 5F A5 91 6E A3 9A C3 72 0E 3B 21 B4 1B FD AE 6D FE 6F B0 38 5D D4 0B AE 77 A5 3A 1F D2 7D 66 
DC D6 86 E6 56 03 D6 CE 06 4A A9 9E B1 30 E8 61 3E 40 8F DB 68 12 77 9D 38 D1 75 A2 CB EB 7F E8 
E5 8E 8E 8E 82 82 02 FC 3F FA 89 74 C2 C7 EE F8 BF 13 05 95 9B 37 31 15 D1 6B F7 37 E9 D0 E7 6E 
D5 36 35 92 1F 5B 96 56 82 94 25 71 03 FD C7 27 4F 9E 3A DD 4D 47 A7 4F 9D 7C 83 EA F5 6E F9 D9 
3B EF BC F3 16 F1 6F 85 FE 7B FB 7F 50 2F 8D B4 BD D2 30 D8 F3 95 77 2E 23 C3 6B 9C 80 E8 8D 4B 
A5 5A 6E 7D 2B DD E9 90 04 E8 59 19 29 B9 C4 54 11 69 A3 AE 55 AB C5 D3 BE B5 FA D6 9D FB 29 1E 
0F 83 1E EB 35 B8 62 D0 73 4F 64 95 F9 50 5B 5A 5A 5A 5B 59 56 56 27 52 3B FE D1 89 B7 75 A1 6D 
BE 94 56 E2 03 74 FF 22 7A F5 6E 83 41 4B C8 D0 BA 9B 58 B2 27 31 A5 66 64 A4 16 BB 81 2E 78 F7 
24 3D CC 09 D4 7F F2 73 8A D7 5B 8D 10 5F 61 BD CD A2 5A 18 85 0C 4C 8D 2B 4F 9A B7 3F 0D 61 66 
1C 3D 10 2A EF D9 94 56 87 2F AE 42 A7 63 62 D0 0B 32 0B 33 37 10 C4 37 68 71 12 86 FA 7A 62 15 
17 D5 55 AA 8B 83 1E 89 40 F7 2A 84 34 82 BC DD A4 2A 2E AE 70 A8 38 57 65 6A B7 BF E2 F5 EF 7C 
82 EE 57 44 DF BA BB 15 DD DC 9A F1 A7 D6 69 0D CD 5B 89 8D 6D C5 C5 F8 CF 5D 40 FF 51 37 7D CE 
BB BB 4F 51 0C E9 28 A0 AF 34 E7 EF BC 43 39 A4 B3 18 B1 64 9A 1F 47 67 C6 92 29 29 00 A6 C0 02 
D6 12 A0 F6 A4 5C A7 63 92 A9 A4 50 B1 4E 41 21 FD 20 5E 98 5D AF DD 73 E0 C0 1E 1D 5E A7 5A BF 
95 D2 F1 68 80 8E 59 CE EA 54 E5 56 18 2B DC 65 AC C8 35 B5 13 AF 2F 05 74 7F 22 3A 4E B8 81 D7 
E1 EF D9 D3 DA 5C AF D3 19 76 A2 8F 2D 6B 2B 2D 2D 2D 6C 77 5B A6 FA 73 06 02 3A 02 FD 5D 8A 17 
FC 7F AE 38 E8 6F BD F3 0F 54 4B 23 33 53 60 13 83 73 DD 17 8A 29 D0 2B 9C 8E 89 41 2F E9 44 3F 
54 65 38 C3 B9 B6 B9 7E CF DE 3C 16 FB C8 3E 3D 8E E9 4D 94 E6 BC 2F 19 74 02 63 53 AE 1D F2 CA 
79 C8 1D 0F 8D B9 A6 2C 6F A8 33 16 D1 A5 0D 28 9E D7 EB 0F BC 94 97 F7 D2 21 3D BE C1 35 49 A0 
22 E7 84 4C 56 90 AF 74 07 9D 01 CE 29 83 DE B2 AA 41 5F BC E6 CE F2 94 19 C2 4D C1 45 2D 1E A4 
A1 43 B7 93 2A 9C 8E 49 80 9E 6F 52 95 A4 14 90 39 E3 F6 1C 26 5F 38 82 73 C6 19 28 85 F4 A5 82 
DE 96 56 D6 4E C4 F2 4A 42 CE E1 7C 6E 8B B1 42 D5 59 D6 E6 09 75 C6 22 FA FE 66 3D E2 FC 25 F2 
63 BF D4 5A AF D3 6B 0F 42 65 26 7A 45 92 2F 7E 94 A0 7F C3 23 3A 8B 17 47 17 74 E2 05 22 DB 04 
B1 1B BA 71 08 01 5E 94 2E 04 C4 4A 77 B0 F0 4E 12 04 DD 49 15 4E C7 C4 A0 67 E5 E7 E7 67 16 43 
79 9D 5E 5B 8F BD 89 1E 3B 92 F7 3C E0 BE A4 C3 59 60 A9 0C B2 2D 0D F4 B2 B4 B4 2C 95 7B 28 77 
17 7A C9 58 A9 C2 B7 84 E5 8B E8 0D A8 E2 AE DB 87 BE 8B C7 D4 00 7D EC E6 66 9D A1 4E 26 CF 29 
C3 5F 8C F7 88 6E B6 F4 20 59 BB BB 89 DF 96 EE 6E 6B 8F B9 DB FE CC 3A B7 97 B5 C7 66 FF DD 63 
7F C4 78 44 3F F3 1E FE 79 F6 BD B3 6F 9D 3D F3 DE 7B E8 17 7A FC 1E F9 E0 BD F7 88 D7 CF BC 45 
6C 38 B3 52 A0 6B 08 18 39 42 53 0A 9F 9C FA 96 ED 21 B5 0C 15 D0 05 ED E8 F2 48 A2 58 1C 4D 5E 
3E 7A A4 12 09 85 C9 30 8F C5 11 AE 87 22 0D 87 1F 0E D7 2C 20 3D 90 41 17 6F 44 AF F1 53 20 8C 
04 5B F0 D7 01 D0 C3 22 BC FF DA 0E 6A A0 2B DA DA 3A B2 D2 60 4D 3D 99 D7 FD F0 77 5F 7B ED D5 
6C A0 6E 45 21 9D 72 5E 77 7F 41 47 B5 F6 32 95 3D 76 7B E7 1C BF 8C 7F 22 D4 17 04 75 A6 22 BA 
02 5B 32 1D 38 8C D3 3D 7F F7 E5 E7 01 EB 40 B3 AE 75 B7 02 A6 95 96 18 0B 3B A1 37 D0 CD BD E7 
D0 DF 4A CF 9F B6 5C C0 07 E9 33 5B 2E C2 93 66 B3 F9 3C 1E 87 BF E4 D8 CB D2 2F 11 63 BE AD 17 
25 10 0E 9C F6 13 74 4A 11 FD 4C A5 02 11 7C F6 7D F8 8B 33 EF 1B D1 A7 F9 E0 2C 7A 8C F4 CB F7 
CF 9E 85 B9 67 DE 3A FB 21 7A 05 6F 90 7F F4 F6 D9 15 01 5D 13 0B B1 D3 9A 26 0C 86 6A 34 B1 05 
E8 AD 93 13 3D A4 71 A4 00 3A 57 65 E2 89 0A 61 44 76 C2 09 C9 96 F0 C8 34 98 9E 5D 04 37 86 70 
40 2E CE FF AC CE 14 B3 03 D3 64 D1 33 E8 5D 40 53 58 92 92 1C AA 80 6B 01 40 6D 6A 13 28 81 50 
54 64 52 A5 24 82 76 4A A0 9B 36 E4 AF 8F 2D 85 D5 7A C2 A9 85 BB F6 D8 D1 63 47 5F F2 D3 A9 C5 
4F D0 51 38 6F 2F 9E E3 D8 A7 88 5D 8A DB 17 04 75 86 22 BA 0C 1B 38 EC DC 2B 00 4F 91 06 0E 82 
BD CD CD 86 DD D5 10 A6 15 16 9E 80 DE 40 37 77 CB E1 B9 8B 17 CF 5D EE B7 F5 49 AE 5C 39 07 FB 
6C 97 E0 29 B3 F9 02 BC 70 F1 E2 05 F4 8C DC AB 0F CA 2F A3 87 96 F3 B0 EF CA A5 F3 A7 96 23 A2 
9F F9 55 01 01 BA E4 C3 F7 7E A5 FA C5 87 12 D9 DB 18 FA 0F 3E 54 4A CE 9C F9 08 7E 70 E6 CC 2F 
4F 9C 39 0B 3F FA E0 83 8F E0 2F DF 59 9C 74 26 40 17 61 23 44 8E B0 14 02 F5 66 98 11 11 BF 1E 
A6 2C 24 92 12 E8 26 23 E0 83 02 23 37 1F 46 73 F9 D9 AC AE 76 3E CB 54 C2 65 E7 29 0A D2 00 87 
D5 9E 11 A0 DE 6B 9E 41 07 45 8E 47 71 BC 74 9E 1D 74 DE 1A F4 5C 12 1A 4A 09 74 08 95 39 19 0A 
67 EF B5 EF 1F 7B 95 EB 9F F7 9A 7F A0 97 A1 5A BB 91 12 E6 0E D4 2B 55 EE A4 33 15 D1 9D BC D7 
BE 7F F4 BB 76 4B 26 B2 6F 42 EA 15 74 CB 55 F1 35 8B D5 6A 31 77 5B FA A4 36 6B CF 05 E5 29 04 
BA E5 12 BC 68 B3 5A 6C 7D D0 8C AB F1 E6 FE CB D7 06 AF 62 D0 11 F9 56 EB 5C 85 9E D9 88 3E 07 
FA 99 B7 CE 9C 79 EF 43 C4 F6 FB E8 7F F4 00 85 74 53 D7 7B BF 80 EF 23 D0 7F F1 DE 59 B4 F9 A3 
C5 6B EF 8C 81 CE 66 2B D7 A9 F9 30 07 08 F9 20 0C C6 79 48 00 4B 09 74 35 0B 48 33 92 C4 19 38 
0F 95 70 23 2C 12 64 2A 59 FC 70 C5 3A 09 9B 5F 04 C3 16 1E 35 10 F2 BA 7B 06 DD 08 2A 1C 0F 37 
89 8A 11 B8 ED 04 E8 61 78 43 26 30 51 02 5D 99 91 8B 4B 3C 1E 43 DF 0B 9E 7F 15 47 F4 EF 01 E0 
97 9B AA 5F A0 B7 75 65 15 53 C6 9C 40 1D FD 9F 9B E5 DA FD CE 54 1B BD 06 83 BE 97 8B 40 3F 7A 
F4 E8 AB A0 05 47 F4 9D D5 50 AE 54 16 64 76 79 01 DD DC 0F CF 5B BA 51 4D 9D 00 DD 62 EE 19 B8 
6A 46 A0 DB 06 E5 A7 10 E1 56 F4 2A 49 B5 D5 82 41 47 7B F7 A3 26 FA F2 83 8E 9E FD 62 1E F4 77 
DE 3A FB 01 FC 48 F9 2B 54 7D 47 B5 77 D4 62 FF 65 DA E2 87 63 0C 74 FE 1A 98 2E 88 C0 6D 69 C4 
FC 89 12 AE 97 9D 17 A9 BA 57 72 12 22 60 54 B4 DD 92 29 16 C6 AA 79 92 58 50 9A 9B 28 8D 02 91 
D0 93 81 03 8B C5 61 01 01 4E 5F 27 E4 B0 B3 81 86 C3 16 70 F1 26 2E 9B A3 01 6A DC 8F 17 62 DF 
CE 25 B6 0B D8 1C 3E C8 C6 DB F9 1C B6 1A 6D 67 71 D1 AE C4 21 F8 E8 10 E4 76 01 C0 1E 8F C4 76 
2E B9 9D 3D BF 9D 3C B4 CB 5B 72 E7 B7 3B DE 52 3D FF 96 C4 21 B2 C9 ED 1C BC 9D C3 05 6C BC 3F 
EE DE C0 9E 75 1E 41 4F E6 17 40 49 41 41 81 12 81 5E 04 43 13 9C 41 57 81 0C 2A A0 9F 48 CE E9 
E8 10 C3 DA 9D 5A C2 1F FD B1 EF 0E BD F6 AA 1A B0 0C CD 5A 7D 13 95 39 3A FE 82 DE 46 54 DB A9 
63 6E 0F EA C5 9D 2E 0D 75 66 DB E8 49 E0 08 B6 9C 7B 0A 68 88 36 7A 95 CC 94 9A 9A 93 9C 21 F1 
0C BA F5 3C EC B7 9E EA 47 C2 A0 9F 3E 79 89 AC BA DB 2E 0F 13 91 BC 57 DE 67 B1 EF 88 41 B7 9E 
97 5C 50 40 F1 15 EB 1C E8 FF E4 54 9C 70 F1 E0 78 2C 91 D9 FF C3 6F D0 DF FB 65 17 6E A3 FF E2 
FD 0F E4 95 EF A1 A7 BF 82 0A 54 5F 27 41 3F F3 91 E4 ED C5 41 FF 47 C1 C2 12 19 E2 A9 44 2E 02 
BA 20 25 97 AD 2E 25 4D 16 58 C5 59 1E 33 43 2E 0A 7A 31 AA 54 49 D6 85 C4 CC 7B AF F1 D5 30 59 
D8 B6 1E A4 E5 83 9C 32 4F DE 6B 49 E9 BC 18 A0 E1 F1 12 40 02 8F C7 01 D1 BC 22 3E 37 86 97 0E 
84 45 BC 50 C0 22 B7 17 B1 41 28 2F 5D A8 8E 41 BB F2 79 BC 68 C0 E1 F1 12 41 1E AF 48 83 B7 AB 
B3 D3 C9 ED 79 20 91 C7 2B 77 1C A2 48 20 C0 DB 85 22 B4 3D 89 C7 4B C2 FB F3 01 DA 0E D4 F8 D0 
7C E7 B7 14 12 6F 99 CD 9B 7F 4B 6C 96 C5 2B 52 73 D3 F1 A9 CC BD A5 7D 3B 8F 0B F0 76 AE 08 6D 
67 A3 B7 E4 7B 2A A7 9B 13 A4 B0 93 0B 40 A2 1C 83 9E 05 52 3B FC 06 DD B8 6E 43 61 69 8A 0C A7 
37 6F D6 BF 8C 27 37 A2 0B 2A 44 91 4D 6B A0 94 F1 D9 4F D0 11 E7 95 7E 72 4E A0 6E 44 0D 75 A7 
99 72 8C F5 BA D7 19 74 CD 5A F4 B1 77 BD FA EA 53 00 1C C1 5E 0E 75 12 A8 EC 28 28 38 21 5E 30 
61 C6 5E 73 3F 07 4F 59 7B AF A2 DB 40 2F AA A7 4B 64 70 D0 6C 71 02 FD 9A C2 0D 74 38 70 F1 E2 
30 EC 37 DB 41 FF E9 11 5E BA 40 68 2F 91 79 DE 4B 24 95 19 B0 2E A0 A3 80 FE E1 19 04 3A 3A A3 
4A 82 FB 8F 20 02 7F 0E 74 D9 E2 A0 BF F5 96 87 12 99 E0 A9 44 FA 06 9D 15 2A 5F 1B 22 2C 55 E4 
E1 C6 B9 A6 A4 6C 69 A0 AB 54 A1 31 79 42 6C ED 84 99 CE DE 0C D3 59 C0 68 CC 53 14 81 0D 05 7C 
E5 16 0F 09 9F 1F 61 D5 BD A5 85 A9 23 79 8C E8 EB 41 16 84 72 B8 39 8F 00 1D 6E E6 18 B3 E7 40 
CF F0 BC DC BC C2 E9 98 78 07 B9 5C 22 4E 13 43 B8 1F BB 37 B4 BE 44 66 EA DD AB C7 9E 25 35 54 
48 F1 0F F4 B6 34 93 9F 8C DB 49 47 FF 99 9C 6A EF 8C 8E A3 37 B7 1E 21 4B 1C 31 7D 40 BB 5F 86 
EA EC E4 C8 A2 E7 88 7E 11 5E B2 76 5F EB 3E 2F 45 A0 4B 7B FB AF 59 CD 56 0C FA C0 D5 6E 97 AA 
BB 03 74 E9 35 8B E5 1A BC 68 5D D6 CE B8 B3 6F 9D F9 10 37 C3 11 E8 1F BE 85 FB DA F1 A3 8F 24 
1F CD 55 DD 8D 05 8B 1F 8F A9 AA BB 30 19 F2 D9 21 EB 64 B8 FF 9D CD 2E 48 59 5A D5 DD 64 E4 B2 
F0 9D 22 37 0D B0 D8 AC 10 63 56 39 9B 1F 27 89 54 26 F0 D3 A1 48 92 1E A8 96 4C 1E 41 57 82 8D 
F8 D7 16 3B E8 0A 10 C1 9A 03 7D 4D 92 C7 92 5D E1 74 4C 0C BA 2A 0D 56 6E C9 54 C2 AA 3A 62 8A 
D8 A1 23 87 0F BF 74 40 87 67 C6 35 50 5A 97 EE 0F E8 65 65 98 73 7F C3 B9 23 A6 57 B6 CF 93 4E 
21 A2 87 B7 51 39 7D 39 FE D8 CD 86 7D 87 59 AC A4 BD 86 66 9D CE B0 1B 31 2E CF 4D 2D 11 7B 03 
DD 7C 52 3A 60 B1 9A 6D 17 09 D0 6D 56 4C 37 EE 8C 3B 0F 7B 51 D3 DD 76 0E 5E 33 CF 81 DE 83 5F 
BA 62 B5 2E 17 E8 1F C9 DF 26 10 7F FF EC 19 D4 24 C7 C3 E9 44 1B FD 97 CA F7 DE 3A A3 2A 40 31 
1D 8F B3 21 D0 CF 9C 85 A9 2B D6 19 A7 D1 98 52 01 87 15 03 23 B9 6C B6 9A 07 23 3D BA 2D 50 00 
9D 70 63 E1 47 C2 54 0E 5F 93 0A D7 F0 D1 31 A5 5D 25 2C 36 5B 51 D6 96 E4 A1 2B 3F 70 41 87 5B 
C0 3A 84 63 64 02 09 3A DC 00 88 E1 35 04 BA 24 C2 73 CD 7D E1 CC 38 15 94 2A 8D 26 08 AB 75 78 
6E 9C 0E 1B 38 60 CE B1 4D 38 D3 A0 13 F5 F6 25 71 4E C6 F4 CE B9 BE 77 0A 11 9D 1A E8 70 6B 3D 
9E EB AE 33 EC D9 83 DA 2E 88 F3 FA FD 88 F3 8C 94 92 CD C9 EE FE E8 F3 BD EE 17 E1 C0 29 AB E5 
BC 04 83 4E 54 D3 31 E8 D6 5E A9 B2 D7 8A C2 FD 80 7D 72 8C D9 82 40 37 9B 2D F0 82 0D D1 DF 6B 
F6 0F 74 4A 9D 71 08 EB 5F 9D 3D F3 BE E2 C4 19 DC F5 76 E6 EC 59 DC 46 FF E0 2C 26 9F E8 82 7F 
1B 35 D6 31 E8 67 DE EF 92 BE BF 62 C3 6B C2 22 C8 43 4D 7A D0 06 45 42 7E 91 34 2D 71 49 C3 6B 
82 36 13 79 83 00 5B F0 5C 6C C5 66 DC 00 60 E7 E2 A1 74 61 06 DC E0 C1 35 39 90 41 97 E5 E3 CF 
C6 DD 22 81 A2 68 F4 54 92 07 8C F6 09 33 A1 29 9E 0B 76 85 D3 31 11 E8 B2 14 3C D1 A2 24 0D BD 
72 70 27 5E D6 D2 4C 2E 5E D3 EF A4 B8 22 DD 0F D0 CB D2 DA 97 18 CF ED 31 BD 78 8E 74 0A 11 3D 
B6 93 D2 F9 CB F6 D7 1B E6 17 ED 19 74 B8 E2 AE CC 57 8A 73 72 53 14 DE 26 CC 58 2E 5E C5 7F 3A 
78 CD 72 01 5A ED B5 F9 93 66 EB 95 CB 78 EB 05 33 89 F4 B5 AB A8 7C 2A AE DA D0 6D 41 0A E5 97 
E6 3B E3 A8 5D 6F 4A 11 FD 9D F7 7E 81 AB 5D A6 B7 CF 9E 51 42 E2 D1 7B A8 EA 7E F6 AD 77 94 AA 
B3 F0 57 67 70 AC FF 90 98 30 03 7F F9 36 85 B9 71 0C 4D 98 01 99 27 30 DB AC 3C A2 08 56 E4 79 
9D F5 EE 13 74 96 88 67 BF 41 08 A3 D7 6C 8A 8D 26 A8 67 A7 87 27 B0 39 EC 98 B8 3C 4F 37 8F 00 
06 1D 15 4A 93 CA 84 27 20 75 11 4D 52 B1 0A 55 3C D3 54 2A 55 BB B7 7A 77 85 D3 31 71 44 AF CC 
3C A1 C8 CF 21 8A FC D6 9D FA 39 35 55 53 C2 C4 1F D0 CB D2 B2 72 8D 4B E6 9C B8 45 E4 B6 A5 51 
8E E8 3C CF 13 86 16 48 72 B0 D9 A0 C7 96 4C A4 27 13 9E DC 26 CF 48 CD 37 2E B0 4D 76 9A 02 6B 
39 75 E5 D2 A5 7E AB D9 DC 7F 89 A0 DA DC 8B E7 C3 59 ED 5B ED 44 5F 22 64 46 AD F6 4B 97 7A 97 
67 78 0D 55 DE DF FF F0 C3 0F 70 97 DB 07 1F 62 7D 70 F6 9D 0F DF C6 91 FE 83 B7 3F C4 73 E1 DE 
F9 F0 FD B3 78 FB FB 67 28 4C 8C 63 02 74 76 5E 5C 62 48 C1 7A 82 4A 96 86 B7 29 9C C7 F6 BE BA 
C5 F7 5C 77 D6 5C 2B 9C A5 E1 6B D8 8E 87 84 F9 3A DF 63 25 21 A0 41 F7 57 15 4E C7 C4 A0 CB DA 
37 24 A7 D8 D7 A9 55 ED DF DD DC 8C 17 6D 36 ED A7 9C 37 8E 3A E8 6D 65 B4 38 27 62 7A AE BD EB 
9D 0A E8 1E A7 11 78 52 6D 43 BD 4E 87 33 6E D4 3B 12 EB 48 55 26 29 8E 90 DE 17 B5 58 AD 04 D0 
66 3B C0 F6 DF F6 AD 8E 6D 56 72 A2 8C D9 79 2B D3 AB D7 70 75 9D FC 7D 06 FD C3 93 DD C9 CD 6F 
D9 B7 9E 25 5E A1 82 39 33 73 DD D9 1A 7E 3C 9E 92 4E 48 C3 E7 FB 5A C4 16 5C BD E6 41 CB 05 3A 
94 29 0B E6 A8 96 28 AA 71 F2 B4 6A 39 55 8B 45 08 57 FE 11 00 00 20 00 49 44 41 54 3F 40 2F EB 
5A 6A 47 9C 73 4C 37 A1 CA 7B 19 C3 A0 43 49 C1 FE 86 BA BA 86 FD 05 73 AB 78 64 E4 17 40 7B F5 
DA C2 15 EC 81 B1 7A CD D7 32 55 76 FA 5A 0A 4B 54 83 A0 7B 11 53 EB D1 2B 9D 8E E9 C9 7B 4D 46 
9D 71 42 54 41 A7 D7 40 77 84 F4 8A CA 2C 82 74 66 41 47 1F 5B 82 E4 61 F3 A3 4C 3C 41 65 DC FB 
51 81 EE 73 99 AA 8F CA BA 37 D0 83 DE 6B 73 F2 38 61 66 09 2A 71 3A 26 53 79 DD 29 81 DE A6 A2 
57 71 B7 87 74 55 5B 1B 05 D0 C3 63 45 22 8A 6D 74 5F 72 05 9D 66 66 48 7F 41 5F CD 11 9D 11 EF 
B5 F2 79 D0 83 DE 6B F3 62 A0 DC 62 39 27 7C 5E 41 D0 97 3E 82 EE AE F6 B4 45 AB EE 11 04 E8 59 
F4 3F 9C 0B E8 3F 7E F3 D4 E2 1C 2F AA 93 1F 53 BC DE 9A 47 00 FA FF A4 5A 18 57 A1 F7 5A 79 79 
12 3B 20 4C 1C 22 E8 97 5B 2C E7 43 AE 20 E8 69 74 7B E2 E6 94 5B D6 46 A9 8D 2E A2 36 BC E6 53 
AE E9 9E 3F FE C9 69 9A 31 FD F4 E9 53 A7 B3 A9 5E F0 7F 58 E9 BA FB 3B 6F 51 06 45 C0 59 8D DE 
6B 01 C1 39 00 C9 F4 0B 2E 2C 28 72 3E E2 CA 81 CE 5C 40 27 43 3A 85 71 74 E6 41 07 6F 9C 3E 49 
57 3F FD 35 E5 EB AD FE 87 77 56 D0 BF 01 E9 1F FD E8 CB A2 EF BD 56 EE D6 75 96 2D A4 A9 EC 00 
E1 1C 80 98 CD FF 8B A6 22 5D 1B 31 2B 08 3A 63 01 1D 0F A6 B7 3D 9A 88 0E C0 8F 5E 7F FD E7 F4 
FE F9 65 31 F0 B3 95 95 5F A0 70 85 21 34 C1 74 F5 5E E3 86 B0 D8 B4 C4 0A F1 D3 EF EA 93 15 94 
5F A7 D6 F2 E3 D7 FF 37 3D 7D FC BA 6B 39 F3 00 BA A2 7A EB D6 0E 4A E9 5F FD 01 9D C9 80 5E 51 
D1 99 C6 7C 44 97 D7 D6 7A F8 D4 EE A0 FF FC 8D 77 DF FD E9 D2 FF FB E9 1B 1F FF D8 9F 0B FE FA 
1B EF FE 74 C5 F4 C6 C7 94 1B 15 58 5C 3E 4D 30 35 2E 41 47 C0 41 21 9E 9E 92 38 7E 7C 80 4F 7E 
F3 DB 4F 3F 5B 39 FD EE 37 CF 2F 7E 4E 0E 7D FC 93 93 A7 68 EA 64 B7 8B 4F 08 01 3A 1E 56 92 92 
43 4B 92 AD 0D 4D BB 77 EE DC DD D4 40 75 5E 1C 65 D0 99 0B E8 15 15 AA B2 B2 2C 46 23 BA A2 B1 
AE 69 F7 EE A6 BA 46 F7 69 BF 6E A0 BF 4B FB 0A 9C 3C 45 D5 A8 05 80 1F FF F4 24 F9 76 A7 57 E0 
7F 7C 6E A7 A9 9F 1B 08 29 A7 0F 26 CB 29 CE B1 19 E8 DD F3 A3 91 FE 4F BF FF F4 FA 8D 9B 2B A6 
1B D7 3F FD 1D 65 1F DD D7 99 18 C6 3D 75 CA F9 90 18 F4 F6 D2 CC 02 58 86 27 D1 C2 AA 86 9D 06 
83 5E AF 37 B4 EA 77 37 52 8D EA 54 40 2F 6B CB 2A 66 2E A0 57 54 76 B6 F9 06 DD BF 88 2E DB DF 
A4 43 9F DB 60 30 E8 9A F6 BB 26 BE 75 B5 64 FA F8 27 F4 AF C0 A9 93 94 C3 0E 13 0E 50 7E 9E 1B 
E5 86 85 9A 81 E1 30 E7 CE 38 E1 0A 0F AF FD E1 D3 15 C4 9C 40 FD D3 DF 53 BC 0B 71 7F CA C4 E0 
8E EB E8 0E 06 3D 23 B3 38 C3 64 C2 2B BD AA 9B 5A 71 EE 63 1D 61 4D A4 AF A3 68 01 45 09 F4 34 
06 C6 D0 9D 64 4A 63 B0 8D AE 68 D0 63 4F 26 2C 6D AB BE CE E5 06 E7 3A BC C6 88 25 13 E5 E1 35 
66 86 ED 97 E7 DC 00 8B E1 E1 35 3E 33 A0 53 9D 30 D3 F2 BB EB 2B CB 39 22 FD E6 3F 53 3B 37 01 
33 D7 DD C5 CD 93 B0 64 52 41 D5 FA D2 0E 54 E0 77 1B 08 0F B2 9D 3B B1 0B 99 DE 40 29 AB 3B D5 
88 CE 64 CD 9D 18 61 63 2C A2 CB 1A B4 7A 9D 63 F5 9A FB C7 7E 94 13 66 3E 5E E9 80 EE 56 38 7C 
8A E9 09 33 2B ED BD F6 D9 0A 07 74 A4 7F A1 D8 4A 17 FC 84 91 6B 79 CA 1D F4 0E 31 94 B5 17 CB 
A1 1C 7B 13 35 EB F6 EC 7D E9 A5 7D 7B EA F1 BA F4 46 4A 93 61 A9 80 DE D6 C9 68 CD BD C2 98 95 
C6 58 44 DF 6F 40 9C D7 EB 0F ED DD 7B C8 50 8F 48 D7 37 40 28 C9 CD 44 32 BA E7 8C 63 E4 0A F8 
01 3A 13 6F B7 3C E7 46 C1 92 89 12 98 D4 E7 BA B3 81 B7 EC 15 4E A2 3E D7 FD 5F 56 9C F3 9B 9F 
51 03 BD 85 21 D0 17 44 74 87 B6 62 6F 22 DD BE 3C 54 9B 12 E6 1D 68 6E A6 98 04 96 0A E8 1D 6D 
A6 25 E7 9B F0 48 FA 62 A0 53 8F E8 B2 AA A6 56 C4 F9 9E 97 D8 D9 D9 EC 23 07 08 97 C5 2A 28 2B 
33 E6 E6 1A 3B BD E4 8C A3 27 AA 30 09 1E 01 E8 A7 29 83 BE 78 4D 9B EB 2D 7F 94 9F A0 F3 D5 04 
E7 2C B8 25 84 C3 52 E3 01 FC C0 06 DD 35 A2 9B 6D 36 1B 4E 6D 62 C5 BF 71 2A 23 22 A9 89 D9 42 
6E 75 C8 62 71 6C 75 5A 25 E9 0E BA B2 DD 64 52 9D 80 92 06 9C D8 7D 9F E3 7B 3F 84 93 43 EE A7 
12 D2 A9 44 F4 B4 5C 26 39 47 32 B5 75 31 14 D1 1B 71 AA BC 3D F6 B6 1D EB 50 BD 4E AB C7 39 31 
0B 32 32 B0 D3 8D 4F D0 89 AF DB 4C 5E 04 9C CE D9 4C 7E CD 68 AB D3 F7 6D B1 CD 67 7A 26 2F 00 
13 11 DD 4A BE A3 FD E8 66 A7 F7 43 9B AC 2E 0F CC E4 AE 56 CB 7C 91 B0 58 BA 3D 8B 7A 44 F7 0E 
3A 8B 4B 2C 15 CF 2E E9 C4 3E 0E 00 70 BD FA B4 50 02 9D BF 2E 07 2F 91 09 89 94 47 B3 04 79 F9 
B9 C5 EB 05 DE B2 C4 D3 05 7D 64 D4 F1 73 6C 64 74 74 74 FC E6 CD 09 F4 6B D2 69 0F FC 7C 74 72 
9C 7C 32 89 F6 18 1B 25 35 89 9F 4E E0 AD E3 93 F3 7B 2C 09 74 E7 88 6E B6 F5 0E DE 1A E8 33 9B 
AD E7 87 6F DD 1A BC 66 B1 5E 1A C6 3E 60 D7 2E 0C 0F F7 CD 95 2B AB F5 02 4E 47 6A C5 FB F6 CE 
5D DA 05 A0 1B 4B 53 52 52 73 61 D5 6E 14 D0 F7 1C 06 2D 4F FD E0 07 4F 01 90 A0 AD D7 BA 75 4C 
2D 1D F4 0E 6A 4D F4 CA 85 76 8B DE A4 CA F2 09 3A F5 88 2E A9 6B D5 35 1B 5E 02 E0 F9 67 9E 79 
0C 80 3C 7D B3 AE B5 49 0A 4F 64 E6 A4 E6 97 F9 06 DD 66 BE 70 6B B8 AF D7 8A BE FC 5B B7 06 FA 
6D E6 FE E1 5E 33 02 AA 6F 78 78 D0 6C FF BE D1 15 BA 75 EB 92 CD F9 CF 98 88 E8 B6 FE 81 5B 83 
97 CC DD 3D E7 6E 0D 5F B4 9A AF 0D F7 CF 91 6E 3D 77 EB 12 F1 E6 96 73 B7 70 9A 3A 5B 3F BA FC 
17 D1 79 0C E2 72 61 ED EB B3 76 F7 F4 0D 7A 39 2E 03 11 9D 95 5E 1C 8D B3 CB 84 4A D7 86 F0 41 
72 45 71 46 B4 F7 D0 4E 01 F4 EC 54 05 AE B3 67 A7 A5 A8 35 1B A1 32 45 25 95 89 BC 2E 8E A3 05 
FA C8 94 14 A1 3A 71 1B 4E 8C DD 38 0E 61 D5 9D F1 B1 3B 08 80 A1 89 B1 39 CE EF E2 22 53 33 3D 
86 B7 8C CC C0 E9 91 7B F6 62 34 34 39 39 0B EF A0 3F 1F BB 37 8B F6 B8 E7 89 74 FF 23 BA D9 3C 
0C 95 03 B7 14 57 7B 6D 83 B2 BE BE AB F0 92 ED 3C B4 98 AD 17 A1 62 E0 96 14 DA 33 88 9B AF 28 
E0 B0 0D FD 82 E2 01 28 BB E2 28 09 0B DB E8 29 9D 0A A5 1C 56 6B 51 0B 7D 1F E0 3E F3 DA D1 A3 
AF 21 D2 F7 50 AD BB 53 01 9D D2 E0 1A B6 54 34 1A A9 CD AB 29 EE 3C C1 4C 44 C7 96 4C F5 FB F8 
E0 F0 77 8F 1E 7D E5 08 10 A2 9A 8C 61 77 95 3C 27 0B C2 B2 7C AF A9 A4 08 D8 2E 40 E5 F0 B0 52 
D2 6F 39 07 FB FA 6E C1 F3 B6 2B B0 1F 51 0F E5 C3 C3 8A 39 0F 87 CB B2 BE 01 78 CE 39 A6 33 10 
D1 2D 83 F0 EA E0 55 78 D1 36 2C BB 30 08 CF 5B 7A E1 5C A2 AA 6E 9B 12 12 4E 31 D6 7E 08 D1 7D 
DE D2 07 C5 83 97 E1 B9 9E 41 39 DE C5 76 F9 96 C5 72 71 2E 51 A5 BB 18 88 E8 9A 58 C2 92 29 64 
0B E4 F2 79 52 69 65 89 18 26 2F 2D 95 94 1D F4 7C 31 AA AC 6B 62 24 B1 02 1E 2C 44 FB 47 8B 0B 
BC 65 8F A6 0B 7A 15 22 75 04 81 3E 79 1C DE B9 37 35 73 F3 7E CD F1 3B 53 70 6A C2 09 F4 E9 E9 
3B 43 F0 38 E2 78 EC 86 04 E1 FD E0 CE 9D 3B 92 A1 3B 77 A7 C7 47 24 70 16 07 FF A1 A1 BB B7 A1 
7C 72 E1 E1 97 10 D1 6D 03 08 6D 54 6B BC 74 12 67 1F B4 59 AE DE B2 20 D0 D1 95 BD 60 B1 F5 5C 
53 2A C9 6A FC 15 19 BA DD A3 87 BD 57 6C 3D E8 A5 B9 94 65 0B DA E8 52 A2 82 EE B0 64 FA 2E 61 
C9 04 18 B5 64 EA A0 92 12 B2 12 61 AE 32 A9 8C 25 94 48 EF EC 60 26 A2 3B 2C 99 BE 77 EC E8 51 
FC B1 09 4B A6 5A 25 B6 EF F4 6D 9B 8C BE F2 73 B8 92 7E E5 1A 7A D4 63 B3 0D CA 4F F7 23 D0 CD 
B2 CB A8 5A 6D 19 86 A7 F1 9D 15 DD 7B AF F4 F4 5C 90 9A 97 00 93 F7 88 8E DE F0 7C 0F BA A8 BD 
57 E0 A5 1E 5B 7F BF D5 05 74 F1 B0 F4 22 0A E9 96 0B 57 AF F6 A1 AA 1E 3C 67 B3 F5 F4 F6 DB 2E 
28 D1 2E A7 6D B7 86 7B AE A0 4D 5E 8E CC 40 44 77 78 AF A9 32 00 50 8A 13 51 D5 3D 13 A6 7B 23 
9D 32 E8 FC 42 25 E0 A6 C8 D4 F8 C8 A4 01 CC B2 80 3E 42 46 F4 51 F9 D0 E8 C4 04 EE 97 1F 19 99 
9C A9 BD E1 08 E9 08 F4 C9 09 7C 1B 40 11 7B E4 6E ED 6D C9 FD F1 F1 91 11 F9 ED C9 89 F1 89 3B 
55 77 D1 D3 9B 37 6F 4C 8C 8C DE 86 F7 C7 16 1E DF EF 88 6E EE 45 D1 83 78 80 6E ED 57 2D DD B6 
E1 CB 56 04 3A C2 1F 27 2C 42 F7 6B 32 A4 5F EB B5 0D 63 D0 D1 6E 66 AB 2F D0 0B 32 72 4C 24 E8 
BA 97 09 D0 8F 62 EF B5 43 5A E6 4C 16 3B 4C 14 E2 B9 B1 22 4B AC 90 2B C4 9D 15 14 AA F9 C6 76 
9F A0 53 8F E8 1E BD D7 6A E4 A9 69 10 76 F9 B0 4D C6 36 0D 83 44 CB D8 8C 1D 1A D0 45 E8 93 5E 
43 A0 DB B0 89 CB 7C 6E 77 CB C0 2D F4 FA 15 78 C5 29 82 D2 8F E8 A7 2F 93 D7 15 BD CB 39 9B D5 
6C 36 BB 46 F4 0B 83 E8 4D CD BD 92 8B 08 74 F3 30 E1 E7 6A 36 5B 08 D0 BB 6D B7 06 2C 70 D0 1B 
E7 8C 44 74 02 74 4D 3A 14 A9 C3 60 3C 62 94 95 24 2D 54 D3 04 9D CD 12 17 0A B8 E2 12 6C E4 C0 
8A 91 6D F1 D6 21 47 DD C0 C1 33 E8 7F 1C 9D FC E3 5D 14 D1 87 E0 83 D1 71 82 D5 B1 F1 9A DA 39 
68 47 D0 6B A8 15 7E 1F 1E 1F B9 39 5E 33 35 09 6F 4F DC 1C 1B 93 1F C7 1B 67 86 46 E1 71 32 F6 
8F 1C 87 D7 97 0E FA 7C 44 B7 9E 97 A1 C8 61 EB E9 B1 11 F9 84 7B AC 92 41 5C 75 47 B7 72 A2 7B 
AE 5F 72 8E 6C 20 A2 1A FE B0 DD 9F FB CA 7C 65 6D 01 E8 05 A9 99 99 85 2A 58 DD AC 45 75 D8 B9 
AA 7B CB 1E 06 6D 93 3B 54 8B 73 5E 61 4C 23 A7 E1 4A DB A8 D4 DE DB 7D 56 DD A9 47 74 B2 EA 2E 
04 CF 1C 3D 86 2D E7 B2 F7 21 D0 77 D7 C2 AC FC 8C 8C 7C 93 17 4B 26 E2 CB BD 82 E1 42 17 A1 07 
35 7F 71 44 BF 7C D9 82 41 1F BC 8A 93 BA 9B AF 5D 25 72 3E 5B AF A2 6B 62 EE 77 E2 90 3A 4C 5C 
6F A0 5B 09 EB 37 E2 D1 20 1C E8 B5 2D 00 1D DF 58 2C E7 25 DD 57 FB 6C D7 A4 76 6B 57 8B 23 A2 
DF BA 3C 6C 36 7B 3E B0 3F E3 E8 8B 80 AE 2E 2D 48 50 AF 97 87 12 96 4C B9 6D 4B 72 6A 71 02 5D 
C3 93 A5 6B B8 72 C2 3F 95 95 27 5D E7 15 74 96 86 C5 07 02 16 4B 08 84 2C 96 1A F0 59 1A 2E 57 
C3 D2 00 AE EB F6 10 CD 67 9E 40 87 35 48 55 70 62 FC 5E 15 1C BA 4F 90 3E 7E 0F DE 75 AE BA E3 
66 F8 F5 9A D9 C9 F1 69 78 7F 74 A8 66 D2 0E 3A DA ED FE E8 54 0D B1 E7 D8 48 ED 8C E7 AA 7B 0B 
71 2A 2C 56 08 50 B3 58 D9 F8 54 04 E8 14 59 E8 D3 A3 ED 80 85 4E 11 6F 9F 03 DD 72 41 7A CA DA 
2F 96 4A 6E 5D 43 6D F4 81 61 89 A2 17 57 DD 6D F2 01 7C F9 CD D7 A4 E7 1C 3D 41 76 D0 CD DD 57 
2F CF 27 21 75 07 3D 23 05 C2 F6 54 79 55 13 D9 19 C7 7D E6 87 D8 9B 28 8F C9 CE B8 82 45 E7 C5 
A1 97 CB 1C 99 9C 24 ED C6 C5 49 37 9D 30 32 12 D1 A5 4D AD E8 63 E7 81 E7 7F 70 FC F8 0F 1E 03 
87 5B 71 67 1C FA D8 59 99 99 38 D1 87 57 D0 51 A5 FC 9A F5 DA 2D 89 54 D1 8F BE FC 81 41 29 EC 
27 40 1F B8 7C 8A C0 E8 32 01 BA F9 EA A0 85 08 AE 2E A0 7F 42 16 BF 45 4A E4 27 6F 78 99 09 89 
6E 1C F6 E3 99 AD E7 A4 70 E0 B4 6B D5 5D 39 88 58 B7 D9 14 7D 66 31 02 1D DA 0B C3 5C 44 17 4B 
FA BC 06 74 74 6E 5C A7 53 B1 97 48 A1 A7 12 E9 1B 74 36 BB 20 59 38 67 C9 94 B2 34 EF 35 27 D0 
81 51 C5 62 A3 88 8E 6B 06 7C 91 77 43 08 4E 62 91 28 06 68 44 A2 3C 90 20 E2 71 40 A8 A8 88 CF 
4D 17 A5 83 10 9E 28 14 B0 44 A2 04 90 27 E2 61 EF B5 4F 3D 81 2E 9B 42 9A 41 30 8F 8F DD AE 82 
B7 71 4B 7C B2 56 3E 3A BF C7 3C E8 13 C7 6B FE 38 8A 60 1F 23 41 1F 39 5E FB C7 D1 7B 90 E8 84 
23 AB F6 1E 41 2F 12 15 01 A1 48 14 0D CA 45 A2 44 7C 8A E8 54 44 3C 2E C0 DB B9 22 74 8A 1C 74 
8A 2D 73 A0 9F 93 F4 5A AF 5D BC 34 A8 44 A0 4B 2E 0C 9E B7 98 AD 4E 11 FD 8A CC E1 08 E4 00 BD 
67 18 15 4A AF A0 97 A8 D0 8F 5C 13 C4 C3 6B BA 03 B8 EE D3 82 38 3F 80 67 CC 1C A4 40 0A 43 A0 
1B 8B E7 6F 2A E2 E2 C5 2B EF BE 41 F7 63 66 5C 03 76 91 3D 90 0D C0 63 4F 03 14 D0 EB 75 5A 43 
83 04 2A 2A 8C C6 0A A5 2F D0 B1 FF CA E9 4B 17 FB 64 B8 BA 7E 61 F0 DC 69 AB D9 39 A2 2B 2E 10 
17 E3 32 11 D1 65 2E 11 FD A7 47 44 45 02 E1 E2 25 D2 5B 3E 1B 6B BF EC BC 63 10 05 9B 34 0F DB 
DC 41 3F 07 6D E8 5C 4E 89 3D 45 F4 81 8B 2E F5 0B 17 9D 3E FD 26 0B 97 BC 6C AE 73 89 CC F3 54 
22 7D 83 1E 12 09 F3 58 C2 F5 52 22 A2 B3 CB 2A 69 82 CE 4A 94 A2 DA 3A 37 45 01 D0 8D 43 1D 09 
8B BC 8D D8 D1 AD BA 8F 4E 4E 8E 92 30 8F 8C 4D 21 5C C7 26 87 24 4E D0 DA 23 FA 03 C5 D4 24 AA 
D1 4F 4D 0D C1 E3 93 76 D0 6B AA F0 D3 29 3C CC 76 D7 A9 0E B0 84 AA FB 7C 1B 1D 55 C4 CF DB CC 
56 DB 39 05 02 FD 2A 61 C8 4B B6 D1 E5 36 B2 8D EE 18 6B B1 83 6E E9 73 6E 23 2E 8C E8 25 B8 99 
5E 00 AB EB B1 7B C3 A1 3C 74 3F 67 1F 39 D0 DC AC 65 6E C2 4C C1 A2 A3 6B 95 46 D3 7C 6A 46 69 
3B 5D D0 FD 18 47 AF 46 75 F7 66 DD BE C3 F8 EB 38 BC 0F DD EB 0C CD D5 50 5A 92 99 91 91 99 22 
F5 51 75 EF 95 0E E2 8B 70 49 82 41 EF C1 E3 E9 56 B2 8D DE 4B B6 D1 2F 92 01 94 6C A3 F7 3A 55 
96 69 B7 D1 51 BB 80 6C A3 63 DF E6 EE 9E 0B 92 D3 EE A0 F7 4B CE 0F 0F 58 AE 89 FB 2C DD B7 AE 
BA B5 D1 87 D1 6D BF DB 1B E9 A7 98 A9 BA 6B F8 19 5D 80 A3 09 83 22 DC 61 9E 28 F1 E8 AA E2 07 
E8 21 9B E5 1A 36 87 1F 07 93 B9 00 F0 64 C6 65 EB 75 1F 21 7B DD 11 E6 37 47 EE C3 3B 23 88 F3 
FB 23 4E 7B DC 85 23 63 63 93 77 E0 BD C9 69 38 84 54 5B 45 56 DD 51 CD 1D 3F AD 91 DF C4 AF DE 
1E F5 D0 42 5F CA F0 9A 6D 18 F7 BA F7 90 A0 93 8E 40 B8 D7 1D BB F7 DA 7A FA 25 F6 86 B9 D9 62 
1B 1E EE 41 ED C8 0B 92 93 3D 36 EF E3 E8 ED 39 25 25 99 08 76 49 23 9E 02 5B 6F 38 B4 77 DF 01 
2D 9E 0B AA DB 4F 05 14 66 40 AF A8 C8 9A 07 5D 52 56 B2 D8 EE 46 C6 22 3A 6C 24 EC 69 F0 CC DF 
BD E4 CC DF 3A 08 C5 85 52 74 BF 29 F4 D9 EB 7E 8E E8 CF BE 44 44 74 72 62 12 EE 75 BF 06 87 2D 
B6 1E F3 55 05 C1 12 B6 63 B3 F5 0C 28 96 D2 EB EE B5 8D DE 6D ED 23 7B DD FB FB AF F4 D8 6C C3 
0A B7 36 FA A0 C5 32 20 C5 A7 82 40 B7 92 67 D9 7B C5 76 41 8C F6 B5 20 D0 2D 66 F1 E5 6E 2F AD 
74 86 3A E3 F8 D1 92 70 3E 8A BD B0 8C 83 10 36 CA A2 BD 45 60 6A E3 E8 42 96 8A B0 69 D4 E4 43 
71 8A 09 2A 43 BD 4E C1 61 A6 D7 7D E4 C1 D0 83 C9 51 14 D1 27 A7 A4 F7 46 47 5C C6 D1 27 47 46 
A6 E1 EC D8 E4 54 CD 08 8A FE D3 70 7A 02 81 3E 32 39 55 3B 41 3C BD 83 38 BF 3B 3A 32 C2 D0 38 
FA B5 CB 50 3C 7C 55 82 AA EE 03 4A AB 03 74 B3 F5 02 1E 47 87 8A 5E BB 77 48 DF 05 85 B2 EF 1C 
2A 86 57 07 07 06 06 1C 0B 24 16 F6 BA B7 65 16 16 E3 11 36 45 13 9E F5 DD DC 5C DF DC CC F0 A2 
16 0A A0 1B 9D 41 CF 5A 14 74 E6 22 3A AC 6A 22 D7 F2 E0 45 2D CD 3A 6D 6B 53 2D 84 F2 94 94 E2 
DC 94 0C B9 AF 71 74 CB 00 54 0E 5F 96 43 3C 8E 4E 5E 04 62 1C FD 3C 54 0C 0F 4B ED E4 99 CD 0A 
49 DF B0 EB B0 35 FD 5E 77 73 F7 30 BC 3A 70 15 9E 3F 87 7E 29 E1 45 D7 71 74 C5 A0 05 9D 89 B4 
C7 7C 4D D9 67 31 9B 07 A1 72 E0 B2 EC 42 CF 20 44 85 E0 42 CF E5 5B 56 AB D3 60 EB 32 80 1E 0B 
63 B8 9B A5 78 D2 8C 30 0A CA 8B 8D 0A 18 41 67 1C 9D BF 39 47 18 03 63 89 43 00 51 46 71 CA 66 
B5 F7 64 D2 B4 40 9F 98 92 38 26 CC E0 61 65 D9 5D 04 2D A1 3B 0E 6C C9 09 33 B2 A9 91 F1 07 F0 
36 8E F4 A3 92 99 89 31 78 7C E4 81 E4 38 F1 B4 6A E6 01 E1 FB 01 A7 46 16 1E 7F 29 33 E3 7A AE 
0C 0C 0F 9C B7 9A AD E7 C8 4B 66 26 66 C6 D9 88 AD 16 FB 45 EC 1D B8 35 3C 7C 6B D0 76 71 98 D0 
35 6F A0 8B 4D 59 59 ED 27 30 E9 B5 0D 5A 83 7D BD A6 DE 50 4F CD 4B 95 B1 AA BB 6A FE B6 A2 A0 
B0 A6 95 B9 88 0E 6B EB 0C 78 75 2E BE BB E9 0C FA 26 62 EE 80 2C 65 C3 06 54 73 F7 05 3A 9E 9E 
38 3C 7C EE A4 95 9C 96 88 23 3A 9E 19 67 BB 36 38 3C D0 37 37 33 AE FB C2 AD 81 5E A6 67 C6 99 
F1 45 1D BC 84 DF 79 78 A0 D7 E2 32 33 CE 32 78 DE DA 6D 1D 46 E4 9F BC 80 6E 30 66 DB 25 54 28 
2E A2 1B 10 2E 04 83 36 3C 33 0E FD F5 35 CF 07 66 64 66 5C 65 34 37 2B 87 98 A6 2A 64 15 16 1B 
4B F3 BC 0D AE 51 9D EB 2E DC 22 B6 DB 34 6A B8 80 EB 6B 6D 0B 2D D0 C7 EE 4D A3 D8 3D 76 FF CE 
D8 D8 8D E9 3B 77 EE 8F 8C E1 E9 30 48 73 83 E2 E8 B5 3B C4 0B 37 1F DC 79 40 F4 C9 4F 4F 8F 8D 
DD B9 87 76 BC 4F 76 D1 4F E3 BF 44 BA C7 C4 38 3A 96 63 AE B3 7D 06 B3 7D AE BB D5 E6 3C D7 1D 
CF C0 46 4F 89 99 D8 B6 B9 B2 B6 00 74 D5 86 D2 52 A2 50 A3 40 D6 B0 53 DF DA 6A 30 B4 B6 6A 77 
EF A7 16 CF 29 0E AF 2D 0E 7A 85 78 EE 88 27 28 8C AF 31 17 D1 51 4C AF 6B 46 9F 1A E7 DB 30 E8 
EA EC 9E F0 32 89 04 DF FB 28 CE 75 77 F0 67 76 DA 3A BF 8F 6B 3D 99 C9 B9 EE 56 72 5A 3D 7A 63 
D2 FE 09 3B 40 11 37 7A 72 22 BC D5 6D 57 54 1A 2C 96 EE F9 13 5E 20 66 E6 BA 6B 62 64 22 72 3E 
3A 5B 0D B8 D9 F4 E6 BA 23 85 E4 6F F1 3E BD 9D 39 D0 6F 8E 8D 3B 7E 8E 8D 4F E0 0A 3B FE 35 31 
31 3E 36 69 D7 F8 18 F1 14 EF 45 FE BC 39 3E 4E 3E B4 3F 45 7F 6B FF 93 A5 57 DD 7D AF 5E A3 BE 
72 79 61 D5 DD A5 CC E3 9C 4A 4D 4D 75 FB 29 66 9D A0 0A FA 62 DC 62 FF 44 A5 FD 80 62 2A 13 E3 
99 1A 47 27 55 ED C8 A0 B5 D5 ED 85 6F CA EA 35 73 FF 79 52 17 BD 8E 91 53 11 33 AB D7 34 51 25 
BE 96 98 F9 0D 3A 47 48 61 85 2A 03 A0 7B D3 C8 4C 0D A1 DA 69 8F 8B 55 A8 6A 49 11 7D E9 F2 0D 
3A 8A 64 55 B5 B5 0A CA 0E 8B 14 41 37 2D 0A 6E 65 85 51 A5 44 41 54 26 11 AB 28 0C A3 33 36 33 
CE F1 B1 AB B6 1E 3C B8 B5 6A C1 6A BD 47 08 BA 5F EB D1 CD FD E7 48 9D A7 05 3A 43 EB D1 35 02 
8A 60 32 6E C9 44 19 74 BF 32 49 8D 8D 93 F2 D8 99 4E 55 37 28 83 CE 4C C2 11 AF EB D1 E7 CA B6 
9F E6 6B 14 E7 BA 53 88 E9 46 53 57 47 9A C9 68 AC A4 30 D9 9D A9 B9 EE CE 9F DB D3 C6 47 E7 BD 
D6 E2 4F 86 99 D3 A8 EA 6E 41 FF AC DE 06 CE A8 E9 D1 65 98 61 28 67 5C 88 AF 73 76 FE 72 FF B4 
E2 A9 A4 AE DF F8 27 6A E7 B6 5C 39 E3 E8 8A 0A E8 9D C5 8B A3 8B 17 B5 10 C1 9A CA A2 16 C6 56 
AF 2D 22 17 D0 7F C4 4C CE 38 AA 30 AD EE 9C 71 8C 80 3E 9F 33 8E CB C4 9D A3 9C 43 39 B9 E5 23 
48 0E F9 9B 16 8A E7 C6 48 0E B1 D3 27 9D 13 8B AF 14 E8 65 94 96 A9 56 3A FF F2 AD 5C A6 D6 A3 
2F 22 D7 74 CF 6F 30 50 77 3F 7D F2 47 14 AF B7 80 11 AB 37 FF CE 8D 72 D6 79 21 03 B9 A4 CA CB 
59 4E 07 64 20 7D 74 12 75 8F C5 4F 7E FF D9 F5 15 D5 67 7F A2 9C D8 9D FB C6 4F 68 26 15 3F 75 
EA A4 EB 3D 7B A5 40 A7 98 D5 9D 72 DE 89 0A 55 19 53 19 66 7C CB 15 F4 EC 6E FA 89 F5 A9 07 4D 
F0 EB 53 B4 DF 6E D9 CE 0D 68 68 73 59 9E C4 71 4E 80 2C D0 B0 E9 DD 37 D8 1A BF 0C 28 FE F0 FB 
3F AD A0 7E FB 87 4F 28 9F 59 0B F7 F5 77 DF A4 E5 C5 F1 E6 9B 6F B8 86 93 95 B2 64 4A 53 31 E8 
D3 82 D5 CE 54 CE B8 45 E4 0A 7A 4B F6 C7 3F A5 75 05 DE 7C F3 5D 3F 3C 12 C0 8F DF A0 F7 76 FE 
9E 1B D5 BA 06 21 21 4D 2E 39 6C 7E C0 78 A5 AD 42 B9 B6 13 3C 81 2E 91 4A FD E9 74 A7 96 05 D6 
C4 64 16 D8 C5 93 43 2E 25 A2 2F DE 19 87 BE 3D AA CD AC A0 FC 16 97 CF E2 D0 71 78 E2 F8 E9 BD 
F6 D8 1F 7E FF DB 15 D3 EF 7F F3 B4 3F E7 F6 F3 8F 69 5A 71 BD EB 66 AF 85 41 97 29 A4 52 B1 63 
76 8C A4 F6 60 63 43 43 E3 41 3F 06 D8 28 81 9E C5 64 76 C8 CA 8A 62 06 F3 BA 13 92 D7 1E DC BF 
FF A0 B3 FB 9A 54 EA 01 74 6E 54 49 81 98 8E DA 0B 13 FC B9 E0 AB 59 B8 AA CD A0 F7 9A 7A 65 BD 
D7 5A FE F0 D9 A7 2B D9 44 FF F4 B3 DF 7C 42 F9 E4 68 7B AF 9D 76 B7 D7 C2 A0 97 6D C8 CF DF 98 
41 96 EE EA 86 66 9D 56 AF D5 6A 77 36 50 9E 31 83 41 0F 5B 69 A7 96 36 DF A0 FB 19 D1 E5 07 77 
A3 CF AD D5 E9 E6 8D A8 CA 52 73 CA 64 EE A0 AB 4F 50 3D A2 0F AD A3 7C BD 57 B5 F8 49 CC 7A AF 
31 D3 EB 4E 39 A6 EF 5A E9 5E F7 EB 9F FE 81 62 75 B0 85 19 EF 35 17 7B 2D 72 99 6A 4E 8E B8 24 
0D 3D 92 1C DC A9 D5 63 CC F1 CF 26 F7 49 62 DE 44 80 1E BF 18 E8 4C 9A A9 12 76 AA 0C 46 F4 DA 
26 9D 1E 7F 6E F4 43 57 47 BA 4B 76 6E 30 1A 37 98 DC 41 CF 58 02 D7 0B 15 4A B5 30 AE 66 A9 99 
E8 75 77 9A DF B2 C2 DE 6B 2D BF 5F F9 71 F4 DF 51 B4 64 5A AE 71 F4 92 4E A5 18 27 9E 80 B0 11 
AF 69 69 26 A4 D3 1A 74 14 49 A7 02 7A 56 59 1B 85 64 12 94 95 9B B5 88 C9 A2 5F 11 7D EB 6E 62 
D5 1E B1 68 4F 6F A8 C7 1F 5B 99 2F 86 B0 C3 3D 67 5C BA 5F 7D 17 5E 95 4A B1 30 AE 6A 31 3D 8E 
CE 88 F7 1A 27 89 B2 F7 DA 4A 5A A9 92 A2 3E 33 6E 99 BC D7 0A 50 99 96 A7 29 51 BD 9D F0 20 C3 
2B B2 75 04 E9 BB A9 E4 80 A5 0A 7A 9A 8A DA 00 39 15 19 DB DB 16 B1 4D F6 27 A2 D7 36 91 B7 37 
1D F9 A3 B5 09 C5 74 71 3E 6A A1 CB 33 DD D6 A3 87 D3 A0 DB 49 65 14 0B E3 AA D6 CA 7B AF 09 BC 
AF 4E 9D 3F 60 C0 39 B5 2C 5D 5E E7 BA D7 EE 6E D5 EA EA 5B 5F 2E E7 F3 13 F6 6A 31 E9 4D 94 9C 
93 29 46 74 06 DD D7 2A CB D2 B2 18 8B E8 12 C2 72 4E 7B E0 C8 E1 C3 47 0E 91 1F 5B 02 15 99 85 
29 32 69 86 5B 44 8F 5A 12 D7 0B D4 45 B5 30 AE 66 AD 9C F7 1A 8B 04 9C 9F 12 A9 E1 B0 35 7C BE 
8F C5 70 01 01 BA DB EA 35 AB D5 4A AC 89 B4 92 D3 9B CD 56 E7 AD 73 3B 99 1D 5B 7D 44 74 99 84 
5C 92 B9 1F 7B 13 B5 1E 21 BE 7A E1 CB 7A 14 D9 B5 D5 54 CA 2D 25 D0 B3 98 EC 8E 33 B5 B5 65 F9 
B6 4D F6 23 A2 6F DD 89 53 49 ED 25 E6 68 69 88 8F 8D DB 2C 05 ED 69 08 77 59 10 74 6F F2 54 D3 
66 F3 F9 7C FB AC 17 04 24 C1 27 F9 54 C3 9A FF E9 2F E8 EC A2 30 22 C3 24 0F 16 B1 34 6C 51 DC 
A6 22 1F 03 F8 F4 40 9F 20 B2 45 8C 4F 12 3F 26 47 F0 3A D5 91 49 17 7B A5 71 BC 58 D5 91 10 6E 
64 72 EC A6 63 05 2B CE 58 31 49 AE 79 99 40 7F 4A 07 74 97 88 6E 39 7D E5 D2 A5 7E AB D9 DC 7F 
E9 D2 C5 2B 38 B3 F7 25 BC 2C D9 8C B6 5E 99 5F 0B 6D BD 82 FD 59 CC A7 AF 5C BC 34 9F 3B 68 61 
CE B8 C8 0D A5 EB 53 64 F2 3A 83 16 71 0E C0 F3 8F 3F A3 06 E0 25 14 E5 F4 94 72 CC 50 03 3D 2B 
8D B1 90 5E 8C 5A E8 8B 80 EE 47 44 6F C0 49 27 B0 E5 1C 1F B7 EF 5E 46 B5 77 43 9D 44 96 5B 5A 
5A BA C1 48 0D 74 89 29 57 55 86 7E 8B 73 F1 48 85 54 85 5A 41 1D B9 B9 C5 26 A5 E7 DD 03 16 74 
76 E8 A6 F8 F8 B0 04 0D 0E C2 BC 4D 9B 44 42 16 27 21 0E 67 9A 49 5C 13 83 7E 26 C5 F2 16 90 4E 
25 95 54 86 14 2F 52 05 29 9D AC 90 BC 2C FC FD E5 73 BC 92 4E 0B F4 F1 BB 53 78 29 FA F4 EC F8 
CD 91 7B 43 B3 C7 AF 8F 8D 8D 1D 9F 1D BA 33 9F BA 79 7C 7A 68 76 76 E8 36 89 FA F8 ED D9 FB E3 
F7 F1 06 F4 FF ED 91 89 BB B3 F7 89 5B C3 5D F4 8C 4E 72 48 E7 88 6E B9 78 15 7F E2 C1 6B 96 01 
A8 90 C3 E1 53 44 36 23 EB B5 CB 78 EB 85 D3 24 D4 66 DB 05 78 CB D6 6D EE 15 43 B4 CB 5C 7A C2 
05 A0 9F C8 2C 29 38 21 86 B5 3B F5 BA FA 43 42 F0 D8 77 8F 1E 7D 55 0D F8 AD F5 5A 7D 13 95 31 
36 8A A0 33 17 D2 4D A8 85 CE 58 44 97 37 19 74 F5 7B 12 00 D8 FB CA 2B CF A0 A6 E7 1E 04 3A FA 
D8 CA B4 8E DC CD 25 90 0A E8 25 44 2F 7A 94 1C AE 03 E9 10 B7 C0 F3 21 8C 03 6A 2E 10 96 FE 7D 
81 CE 5F 07 95 62 28 8E D1 68 12 4B F0 E7 CC C8 D3 B0 61 29 9F A3 59 03 33 D4 1C 56 28 5C BF 60 
95 3A 65 A7 16 56 9E 7C 33 37 54 9E 16 1D 92 1D 0F 53 BC 9A B9 31 E4 BD 36 72 17 CE 1E 97 CE 8C 
3D A8 95 CF 4A 09 4B 35 7B C8 BF 0B A7 8E A3 2D D3 44 6E 0A 39 3C 3E 89 41 87 55 43 08 F4 49 39 
91 03 76 6C 48 3A 35 04 BD E4 75 A7 76 6A F3 A0 5B CE C3 C1 93 56 EB B5 BE 6B 96 C1 AB 36 4B AF 
6C 80 F0 5E EB 95 5F ED B5 5A 2E C1 01 32 99 7B AF F2 EA 55 C2 7B AD AF DB D6 EF F0 02 F3 D4 46 
27 A7 84 55 EB 09 A7 96 E7 5F 3D 76 F4 E8 D1 EF 01 70 40 A7 A3 EE D4 42 09 74 4A 06 6C 8B AB B8 
0C 55 DC 19 8B E8 05 BB 0D BA 9D 7B D5 E0 65 D2 C0 81 BB B7 B9 D9 B0 1B 37 59 94 39 38 2F ED E2 
A0 67 80 38 39 BA 5F 6C 56 C2 CD 6C CC 78 57 76 2A 84 11 31 E8 95 0D 60 DD DF 17 E8 9B 21 57 98 
58 56 A0 49 3A 21 8F 11 0A D3 61 1B 00 29 27 58 EC 90 F5 30 2D 8F CD 8F 83 89 0B 22 31 75 4B A6 
CD 12 BE 60 03 4C E0 73 D8 DC F5 30 C1 5B 48 67 28 0B EC 64 ED CC 1F 27 1F DC B9 F9 E0 CE C8 E8 
F5 DA 5A E7 E4 90 A3 93 93 63 35 D2 EB 63 28 BA CB 87 6A C7 70 5D 5E 7E 7B 74 72 62 FC 9E 74 A8 
EA 26 DA 73 FA C1 E4 E8 71 E8 A9 F2 EE 7F 44 37 43 C2 0D C8 6C C1 4E 2D 16 73 CF C0 55 9C 1C D2 
D2 87 B3 B7 9B 6D E7 E0 35 A2 F5 DE 7F 8E B4 64 32 5B AC 56 DB BC CF DF 42 D0 E5 95 29 05 F3 DE 
6B AF 60 EF B5 EF 72 FD F3 5E A3 00 7A 16 23 63 E9 95 78 9A 7B D9 A2 A0 FB ED BD D6 E2 62 C9 84 
1A E9 A6 42 3C E0 48 01 74 10 EF 78 B4 39 66 73 B6 D4 09 74 B8 11 78 AC 11 05 30 E8 42 36 77 9D 
24 3A 02 8A D4 08 C8 48 18 2A D8 08 F3 58 1A 63 09 E4 69 D4 A5 CA 85 F9 A0 A8 47 74 53 0A E0 B6 
99 88 5C B0 E9 B2 75 DE 32 CE D0 05 7D 74 64 04 E7 75 9F 9C A9 19 19 C1 29 A5 B0 73 B2 AB F7 1A 
8E F9 F7 70 66 C8 91 A1 D9 07 38 D8 DB 2D 99 46 A6 66 AE 13 F9 DC C7 27 26 10 E8 8C 44 74 EC DC 
67 35 5B 90 BA 89 88 DE A3 1C 26 9C 5A 2E DF 22 2D 99 64 A4 39 87 D9 6A CF EB 7E EA DA B5 3E 45 
BF D7 AA 7B 47 7E 6A 49 A9 11 45 74 BD 4E F7 72 0B F8 DE 31 14 DA 5E 26 23 3A 65 37 55 2A A0 67 
B5 B5 E5 52 5A 6B EE 9B F3 5C 22 A0 33 16 D1 AB 89 88 DE E2 30 59 6C 21 22 7A 0D 4C 11 45 64 66 
96 48 16 07 3D 05 18 E7 40 CF 93 83 64 67 D0 2B 3D CF B0 09 60 D0 81 10 A4 2A B3 53 3A CA B1 71 
72 B4 A2 14 35 66 C2 85 09 D2 30 65 72 36 50 14 2E CC 2F 45 15 74 56 1E 0C E7 73 E5 A9 84 25 53 
B4 C4 BB 25 13 3D 03 07 C9 ED DB B7 EF 0E A1 AA FB 1D 38 73 87 EC 85 1B 7B 20 9F CF E8 6A 77 6A 
79 50 3B 34 39 76 5F 36 FD C7 9A A1 11 3B E8 E8 E9 9D 3F CE CC E2 57 A7 EF 1C 97 DF A5 11 D1 E7 
41 B7 F4 49 AE 59 7B 2F 5C B8 70 EE A4 65 50 71 E9 E2 00 69 9B EC B0 64 EA 75 B3 64 B2 9E 47 55 
F3 F3 5E 93 43 CA 4A 52 E5 92 E2 0C 39 D1 46 3F 20 04 21 3F 78 ED B5 4D 02 10 D2 5A AF A3 D4 46 
97 A5 86 8B 62 D7 AC A5 00 7A 59 5A 27 CD 59 33 95 95 B8 27 AE 8C 3C 18 33 11 BD 0A B7 D1 0F B1 
01 FB F6 B1 63 AF 1C 06 FC 03 A8 8D BE BB 0A 76 54 A6 95 B5 17 50 E8 8C DB 00 0A A0 72 FD 96 E4 
42 29 DC 9C 00 D7 03 45 C1 3C E8 65 A0 D0 D3 5B A6 51 2D 8C AB 59 1E 40 0F D9 0C E3 C2 F3 61 32 
68 CF C5 55 6B 76 82 B8 90 CB 56 65 00 91 34 31 A7 1D B0 E1 A6 A5 47 74 41 69 47 22 9B AB 20 BD 
D7 50 44 F7 9A 92 2E 21 2C 4E 04 D8 F1 F1 A1 20 3A 7E 53 02 28 8A 0F D3 08 44 F1 B1 80 BF 26 BE 
08 94 AF 8D 8F 06 A1 F1 E1 89 80 B7 C9 A3 25 13 CE AE 84 60 99 18 1B 9F AE 85 B5 A4 BF D2 14 1C 
73 AE BA CF 59 32 DD 96 8F 4E DE 86 E3 76 4B A6 89 BB 92 D1 C9 BB 10 A7 86 AD 91 40 E9 1D CF A0 
0B 62 E3 62 41 48 7C 7C 3A 48 58 1B 97 87 4E 31 2E 11 9D 22 A2 2D 2C 2E 0C 08 D6 C6 15 81 44 B4 
DD C9 92 49 8E 40 1F 1C B8 8A 0D 1C A0 54 72 0B 5B EA 21 D0 15 24 E8 73 26 8B 0E A7 96 6B FD FD 
17 7C 54 DD 53 B0 25 53 71 A7 B4 4E AF AD 37 BC 04 80 FA A9 23 2D 40 F0 32 B6 6A 69 A4 32 15 AC 
22 8A 17 1B 15 E1 35 B6 CE 83 4E BB F2 8E FE B4 12 57 DC 17 07 9D 7A 44 97 D5 B5 EA 9A F5 E8 63 
1F DE BB F7 30 00 47 B4 CD BA D6 3A 29 2C A8 34 96 18 4F 50 A8 BA 17 66 2B A1 32 5C 94 A0 11 63 
D0 25 EC 58 C5 3C E8 59 20 D3 D3 5B 76 84 C6 C7 AA 43 C2 E2 17 2D 91 9B 70 31 08 E3 67 C7 A2 5D 
59 E1 44 F1 88 CF 03 31 F1 E1 1C C0 8B 8F CD 16 12 87 88 8B 8F 01 79 F1 71 09 20 3D 3E BC 1C 6D 
5F A3 56 87 A1 E2 C4 5F 4B 6C DF 44 EC CF 06 A2 F8 30 90 1D 1E C7 03 AC B5 8E B7 4C 8F 5F C3 E7 
8A 50 09 13 6E 22 DE 32 6E EE 2D D7 08 9D 4A 64 7C 5C A8 A7 12 E9 29 A2 6F 84 72 49 D9 5A 0D 30 
A9 08 D0 51 44 57 0B 33 95 20 B3 38 1B B5 DE C3 A4 1E 6C 1C 28 82 CE E6 2B 32 B3 39 DC DC 2E 6C 
D1 12 B2 C9 9E E5 DD 83 E8 BB A9 8E FE 91 74 4C 1D 45 A8 DF 1F 23 FC 95 E6 A1 75 8A E8 13 B3 33 
D3 D3 77 51 1D DE 6E C9 34 3B 73 8F 78 8A 6E 0D A3 23 43 F0 BE 87 34 92 FE BB A9 5E 84 17 51 F3 
BC E7 3C 69 C9 84 3D 99 08 4B A6 61 C2 7D C7 72 69 2E 9B BF 1D 74 B3 D9 DA 33 AC F0 E6 C2 71 1A 
00 00 20 00 49 44 41 54 5A 75 CF 40 75 CF 02 D4 4A DF 8F 27 88 E1 F1 35 24 2E 31 A0 AC A7 34 8E 
DE 1E C1 8B 8D 88 F4 56 77 77 06 3D AB 8D D6 BA F4 4A F4 97 A6 B4 B6 2C 4A A0 87 C7 8A 62 29 81 
BE 5F 87 6A 32 AD 79 E8 33 73 B9 20 61 0F AA C7 68 F7 43 79 4E 4A 49 49 4A BE 62 71 D0 33 C8 EA 
79 26 4B 89 41 47 35 F9 7C F6 1C E8 19 40 E5 E9 2D 03 35 A2 E3 AA 3B 00 7C 8E 20 5F 99 84 48 D7 
14 C1 28 BE 46 24 E3 99 92 B9 A1 12 51 6A 89 87 8C 91 14 41 E7 C7 4A 62 58 1C 61 32 8C E6 F2 B3 
F9 46 0F 8D 7D 07 E8 CC F8 A3 E3 E6 F9 E4 3D D4 02 47 75 78 E7 A1 B2 B9 36 FA 9D C9 FB A8 E8 A0 
7F 33 24 E8 63 0F C8 A7 35 64 CB FE BE F4 F8 D2 0D 1C 9C 7B DD A5 97 CD 16 AB BB 25 93 E5 1C EC 
B5 59 2D 96 61 B9 9D 73 AB 65 78 B8 C7 DC 7D DA 6A B5 F6 0C 48 BC 8E A3 97 15 E6 A7 6E 28 21 A7 
82 36 37 B7 EE 3B 72 F8 F0 4B 87 F4 78 15 5B 1D A5 D4 EE 2A 0C 7A 84 B7 BA BB 0B E8 59 69 6D 4B 
27 1D FF 99 AA CC CE F9 62 A0 AF DD 14 26 8A CD A2 72 FA 55 4D AD 3A 5D F3 9E BD 87 B3 B3 0F BF 
BC A7 59 A7 33 EC 54 40 65 BE 1C CA 14 EE 73 DD 3D 76 C6 95 87 E2 6A 4F A1 1D 74 18 5D C4 C1 A0 
E3 81 36 C8 63 7B 7C C7 00 6E A3 13 9D 64 FC 78 B8 06 84 08 41 0E 64 B1 39 6A C5 06 A5 88 CF EA 
CA EC 88 F3 80 27 15 D0 73 10 E8 29 ED 00 B7 05 DA E1 FA F8 48 13 0C F7 9A FD 99 99 5E F7 91 1B 
77 46 26 47 EF C0 69 EC AF F4 C7 C9 49 67 7F F4 D1 C9 C9 07 33 F2 07 93 C7 6B 47 88 E8 7F 6F 1C 
83 3E 72 BB 6A 1C 3D BD 03 EF DD 98 9E 1C 19 9D 26 7D 5C E8 46 74 6C E1 A7 38 77 F1 FC 2D B9 0B 
E8 E6 93 B7 60 DF A5 8B B7 E0 25 B2 E6 7E F2 CA 95 CB B7 FA AF D8 06 07 2E 5D 39 0F FB BC F7 BA 
77 95 94 98 30 D2 D5 3A 3C 37 AE DE B0 67 8F BE DE 8F B9 EE 26 3F 40 2F 6B 2B 5B 6A 87 5C 25 FA 
2B 55 5B 5B 16 25 D0 D7 46 C5 85 89 C2 28 81 0E B7 36 1B 74 BA 7A DD 9E 03 07 F6 60 CB 39 43 F3 
7E 08 15 A9 0A FC 83 0A E8 69 40 9D 99 92 11 9B 2D 26 41 EF 00 00 83 9E 50 52 92 9F 08 CA FE 2E 
41 E7 B0 4B 60 E9 DA C8 14 B8 19 35 A9 B9 19 50 CC 66 A3 60 0C 93 3C 8C 89 51 00 5D 98 21 CF 4E 
20 1D D1 35 79 F9 E8 EB CB 12 2D 93 25 D3 C8 94 9C 1C 47 1F B9 8E 87 C6 E1 CC F8 3D 28 9D 1A 1A 
1A BA E7 D4 EB 3E 34 54 23 45 74 8F 57 4D E1 4A FC 38 44 D1 5C 72 7C 64 BC 66 88 7C 3A F5 A0 AA 
F6 F8 14 94 7B 9A 31 B3 84 99 71 E6 DE 41 F4 89 2F 5F EA B6 0C 90 66 7E 56 72 C2 CC 05 B4 F5 AA 
DD 39 15 B5 D5 71 A9 12 DB 7A 07 D0 AF 73 DD 5E AB EE 6D 19 19 A9 19 2A 3C 66 4C AC 5E C3 2E 64 
28 AE 69 0D CD 14 57 AF F9 13 D1 51 4C 2F 2B 5E 52 4C AF AC AC 34 E6 66 A5 65 31 0F BA 04 7D 6C 
1D 42 BD 9E F8 DC 06 43 23 76 62 32 15 1A 8B 0B 73 29 CD 8C 13 47 A0 97 F2 52 20 8C D4 E0 A7 51 
00 D5 8E E2 F1 EE 91 05 9E DF 30 60 41 5F 07 C9 A0 CD 4A 5C 8F 3E A6 32 1C B7 C9 F9 51 30 83 8B 
27 B0 A6 79 B2 40 A5 32 D7 5D 00 42 A2 14 E4 C8 39 9B D8 DD C7 E2 16 7A 33 E3 6E 0F E1 7A F7 9D 
99 F1 F1 FB 53 33 33 77 47 C7 EF CD CE CE 20 CD F9 36 8C 4F A3 E7 B3 77 27 C7 C7 EE CF DA AD D0 
A7 C6 C6 86 EE 4E D8 9F 8E DC 46 4F 8F D7 CC DC 1E 61 CA A9 C5 6C EB 21 DA E6 DD 0E AB 25 4B 8F 
F3 56 AC D3 E6 1E 2C 1B B9 75 DE A8 69 E1 F0 5A 49 89 31 85 30 2D 96 6D DD DD 4A 2C 47 D7 6A 0D 
86 3A 4A 0D 74 E8 5F 44 C7 80 96 2D 6A DB E2 11 74 3C B0 66 EF 88 63 16 74 28 39 58 DF 8A 3E B2 
8E F8 DC F5 8D C4 F4 21 59 49 6A 6A 09 A5 09 33 FE 2B 50 41 E7 84 38 58 66 13 99 5E 48 EA F9 80 
18 FC 06 1E AD 8E A9 39 B5 A8 55 15 2B 62 C9 34 42 8C 7E 4F E0 F9 6D E4 F4 75 FB 4C F6 71 C2 66 
09 1B 2D CD CD 75 1F B3 4F 81 1F C1 BD 6F E3 73 4F 27 46 88 E9 F1 CC CD 75 F7 A2 D3 3E 9E 79 05 
DD 59 D5 0D 3B 0D AD 48 86 DD 8D D4 EA ED D0 DF 88 8E 49 C7 B5 77 3F 83 3A 36 72 71 E6 9C 49 D0 
D1 0D AE 4E 6B B7 9C AB DB EA 18 68 50 10 53 D5 83 A0 7B 11 23 CB C7 A9 5A 32 65 7B B7 69 64 12 
74 6F 1A BF 6B D7 7D 5A 56 2D 8C 78 AF 51 D7 22 96 4C B5 07 F7 37 36 EE DF 4A 65 A6 8C 5D FE 45 
74 8C 68 9B A9 C2 CF EA 3B EE 6F 6F 73 E6 9C 51 D0 31 EA FB 1B EA EA 1A 1A B7 BA 77 3F 06 41 F7 
22 C6 97 A9 AE B0 25 D3 BF F8 91 78 62 FC F6 F1 E3 C7 F1 FF 9E 3C 52 19 07 1D 45 74 46 12 4F 2C 
02 3A F4 92 0E D5 BB FC 8C E8 24 E9 C5 46 AA 19 DC 89 64 EF C6 CA F6 F9 7E 38 AA C3 6B 61 9E FB 
C2 BC 48 5E 55 E5 61 F9 FD 72 80 7E 82 6A 61 5C CD 62 3A A2 87 30 71 E7 28 A7 3C 8E DE F2 3B 7F 
52 49 4D 8C 90 A2 E7 BD F6 29 55 D0 CD 2B 04 BA 9F F2 37 A2 67 E1 F1 F4 AC 5C AA 41 9D D8 49 95 
95 E6 CA 39 73 CB 54 7D CB 05 74 11 FD E3 61 A9 28 16 C6 55 2D 36 C3 19 66 98 C8 41 87 40 A7 9C 
06 F6 37 1E A6 C6 2D AF AE FF F6 13 8A E7 C6 84 21 50 F7 E9 9F 38 A7 81 65 02 74 1F 11 3D 0A C9 
13 E8 B8 A1 8E 82 7A C5 A2 51 9D 70 6E 31 16 9B CA BA CA 16 1C 81 04 3D 8A 78 0F 8F A0 F3 4C F4 
3F 9C 0B E8 89 D4 BD A4 7D 29 99 6A 61 5C CD E2 33 02 26 7B 3E 6B 2B 76 7E A1 7B 38 EA 35 77 F0 
D8 EF 56 36 0D EC 8D EB D7 A9 66 76 6F F9 51 37 FD 34 B0 A7 4F BA 78 79 2E 6F 44 27 37 79 02 1D 
71 9A D6 A9 AA 5C 2C AA E3 17 8D 95 AA AC AE 36 0F 07 20 40 8F 72 7A A3 65 07 1D 44 D2 3F 20 84 
62 CA 85 71 35 8B CB A6 CF A5 6B D2 56 0D 27 89 9E 12 39 1A 3F 1C 1C 1E FB FD A7 9F AD A4 7E EB 
87 83 C3 8F DE 3D F9 13 9A 3A FD 86 4B E5 66 59 23 7A 54 54 7C 58 6C 58 BC 47 D0 89 96 7A BB AA 
D2 48 CC 84 A9 5C 88 3B B9 D5 68 2C 56 B5 BB F6 C2 B9 81 1E 1F 1E 1B B6 69 41 4C 5F 26 D0 C1 16 
31 ED 23 A6 E4 51 BF E0 AB 59 02 56 79 22 4D 32 D9 AE C9 99 B9 B4 E5 DF 27 50 7F 42 FF 1D 29 EB 
13 3F 4E AE A5 85 2B A0 2B B7 1C F2 CB 19 D1 11 E7 11 A5 99 A5 91 9B BC 80 8E 5A EA 08 F5 DC 0A 
E3 5C 4B DC 05 73 1C CC 2B 72 4D 18 73 0F 9C DB 41 47 6F 91 9C 59 B8 2E DE FD DD 97 0B 74 10 F2 
AF FF FA 6B 3A FA D7 5F FB 57 18 57 B3 E8 97 7E D7 E3 A9 85 FC 10 3A 12 52 F6 4C 26 4F FF B1 5D 
2B A8 A7 3F F1 E7 DC 04 BF 7E 9D 9E 7E EE 66 A3 E7 01 74 45 6D 75 75 2D A5 F4 AF 76 11 11 3D 92 
6C 2C BB 68 6D DC 7A 09 94 16 7A 01 1D C3 5A 96 D6 95 65 52 15 57 12 C6 E8 95 F3 C2 90 1B 2B 50 
30 CF EA F2 14 CD 9D 40 0F DF 52 06 61 49 5C FC 82 37 F7 17 74 99 A2 AA CA 83 0F 95 3B E8 FF FC 
6F 34 45 D9 3B 77 F5 2B 5B 48 8B CB 10 A1 2B E8 1A D4 C6 A6 A5 72 FF AA EE 7F BA F9 E9 0A EA C6 
EF 76 51 3E B5 96 5F BF 79 FA 24 3D 9D EA F6 5D 75 97 14 34 D6 ED DE B9 73 77 DD 41 CA F3 65 A0 
2A AA 48 14 15 11 17 4F 76 BD A1 CA B4 43 9B D6 E2 E5 D8 19 F1 11 DE 40 C7 A8 E3 B0 6E 52 E5 16 
17 23 B4 E7 54 51 59 9C AB 32 75 A2 D7 CA 3C 86 F3 79 D0 D7 6C 50 42 D8 1E B7 29 DE 55 6B 51 A3 
C1 1F D0 E5 5B 1B EB 9A 9A EA 1A 17 CC 1F 70 03 FD DF 3F FF FC 0B 7A FA FC 3F 28 FA 75 AC 76 09 
D8 F4 C1 74 FE 6E 59 B4 3B E3 B0 C7 13 E5 D3 7F EC FA F5 1B 2B D8 1B 77 E3 C6 F5 4F 29 93 FE EB 
93 A7 4E D3 EC 8D 3B 75 FA 64 B7 F3 21 31 E8 12 09 2C C8 25 FB 93 15 0D F5 AD 06 3D 92 C1 B0 73 
3F D5 A8 6E 6F A3 47 6C 0A 43 5A B3 26 2C DC 51 7F 8E C3 A0 4B 7C 82 4E 20 DB 96 96 D6 96 85 68 
9F 97 A9 BD 13 6F F4 C2 F8 42 D0 23 22 22 91 88 35 F1 C4 23 F4 58 54 94 1E E3 71 91 A8 07 49 0E 
D6 19 88 8F DD 6A 68 3A 38 37 65 A6 C3 D8 EE 96 61 06 FC DB FF F5 39 6D 7D F1 F9 27 94 4B E3 2A 
16 17 9B A7 D1 ED 8B 4B 9A FF 72 D5 CC 58 32 51 1D 5E E3 FE 66 A5 BD D7 6E 5C FF BD 9A DA B9 B5 
30 32 BC D6 BD 60 78 2D 4D 2C 4F 4D 26 D2 76 56 D5 19 F4 D8 6A 50 A7 D3 6A 0D 5A 4A B9 9E 91 0A 
52 0B 33 53 53 73 52 0B D7 6F 58 BF 01 A9 34 7F 4E 95 08 A2 9C F0 08 93 F8 84 93 2E 7B D6 55 24 
D7 07 0B D4 D5 E5 74 98 82 8A 8D 61 9B E2 62 D7 8B 21 2C DB B2 6E 33 D2 FF CA 44 6F B9 7E 0B 7E 
B8 A5 74 FD 96 2D 5B 28 5A 22 4A F7 EB 0C 5A BB 0C CD F6 64 1B 05 AA FC F5 EE E9 9E FF F9 FF A6 
CF 39 22 FD DF 29 16 C6 55 2D 3E 13 33 D9 9C 86 D7 56 DA 92 E9 E6 8A 7B AF 51 9F 30 E3 65 F2 BA 
9F 5A 60 E0 90 52 91 52 22 2D 41 4D 5D 45 53 AB 16 AF E2 22 FF D7 B7 36 F8 D3 52 F7 26 49 A6 28 
3C 45 E5 D4 00 AF D8 EF 43 B3 07 7D BD BA DF 79 78 3D 37 35 42 14 1B CB DB 82 F3 5A 36 AF 8B 8F 
8B FA F3 6E BC 08 A5 41 87 5A 11 11 86 83 7E 9C 61 83 5E AF C5 6B F6 F0 EA 35 AD DE 80 3F B6 4C 
B5 2E 93 E8 60 77 01 FD 69 14 8E 19 00 FD 3F 28 16 C6 55 2D A6 27 CC 30 33 05 96 FA 5C F7 CF 56 
DC 7B ED 91 4F 81 2D C9 CF 31 C1 4A 13 94 35 62 6F A2 E6 D6 03 87 0E ED 31 D4 37 13 99 56 18 00 
BD 50 24 8A DC BC D1 49 77 FF CF 52 D5 BC 79 F3 3A 2C E2 70 EB 36 AE 89 8D 8D 2D 5A D7 41 82 1E 
1F F1 E7 DD 88 50 69 C3 0F 23 E2 D6 46 18 FC 38 F5 83 3A 3D C2 5C BB 67 0F B9 0E 1F C5 74 74 98 
8C 0D AA 85 A0 FF 1B 13 9C 7F FE 79 40 80 BE A2 8B 5A 08 A9 83 DE 6B F4 40 97 77 76 4A A5 27 14 
70 2B 2E F0 BA 43 87 F1 F6 BC 03 E8 21 B5 B4 EE 8B 81 9E 13 BF 26 7C 8D B3 BE FC CB 52 F5 25 9E 
D7 8A 14 8B 8F 18 1B 8B FB 04 44 C9 88 C7 AD BA 75 6B 31 E8 0A 12 F4 F8 B5 11 AD FB 29 CF D7 B7 
67 98 79 09 B5 EE D4 2F ED 41 CD 16 03 F1 B1 95 A9 F9 46 F7 E4 90 7E 80 FE F0 A1 D7 97 02 23 A2 
AF A0 F7 1A 99 6A 8E 9F 11 81 48 D7 68 3C 18 3B 31 0A FA 38 31 A1 1D 67 84 42 3F 88 27 E8 D7 B8 
EB 2C 77 FB 96 31 C7 E6 31 F2 D9 82 FD 96 04 3A 25 EF 35 B3 AB F7 9A D9 6C DF D5 69 B3 D7 B9 EE 
D8 9B A8 F9 90 10 80 C7 D0 09 1D 3E 50 AF D3 EB FD A8 00 7B 93 AC 33 23 D5 55 FF E7 2F FF F9 97 
FF F2 F8 EF 3F BD BE 82 FF FD E5 2F 5F 15 6E 8C 0F 0F 0F 5F FB E7 FC 8C 8C D4 1F FE 19 3D 8E 3F 
84 6D 4F AB E7 41 97 FB 0D 7A 23 91 33 2E 81 FC 3E 0E E3 9C 71 7A 62 49 BA B8 3D 35 45 BA 54 D0 
1F 4E 7D 15 E0 A0 BB 46 74 36 02 50 E3 9A 41 86 85 B6 10 0F 34 0E 5C 35 A4 9C 41 A5 E2 BD 96 2E 
72 F2 5E E3 85 85 A5 2F 9B F7 1A C1 EC 3D BC 44 6D EC DE F4 D8 CD 91 FB D3 D3 F7 C7 6F 8E DD BC 
37 3D 7D DD 99 E0 89 07 D3 D3 D3 0F C6 C6 EE 4F 93 EB 56 D1 83 7B 63 63 78 E3 F4 7D 1F 0B 5F 96 
12 D1 AD DD 57 2E 5D B1 7B AF 5D 72 F2 5E 43 4F FB 9D BD D7 70 36 77 F3 25 AC 5E AF A0 2B 3A 0A 
3A BA 94 B0 6A 37 2A F0 7B 0E 83 96 43 AF BC 52 04 40 82 BE 59 AB AF 63 A2 95 EE AE FF E7 FF FD 
AF 25 E9 2F FF F5 DF D5 4D 7F 5E 1B 1F BF 07 13 0D 1B 7E 18 19 17 FF E7 56 54 CF C6 11 9D 68 A3 
DB 23 3A 6A A3 53 07 9D C8 02 8B 93 DF 72 F3 F2 D0 4D 2E 4F DF AC 6B 6D 92 42 A9 B1 B0 D0 28 F7 
5E 75 FF FA CB 2F BF 78 38 FF F8 6B C4 EF 97 E4 AB F8 F1 E7 5F C0 2F 3F FF 12 EB 0B F2 39 DA E9 
EB B9 BF 0D 3C D0 D9 31 61 6B C2 45 1C 27 84 59 FC 22 54 DD 0A 41 5B 12 D6 24 E0 3D 8A 78 89 A8 
02 86 AA 61 E1 E9 4E BB F9 E9 BD 96 40 0C 98 66 2E 93 F7 1A A1 C9 2A 9C 9C 7D 64 A8 6A 62 62 5A 
0E A5 F0 EE C8 83 1A F4 9E B3 37 E6 01 1E 99 C6 63 CF F2 7B 93 43 50 3A 41 84 F2 1A 38 3B 39 71 
07 CA 51 81 19 BA EE 21 FF EB 92 23 BA E5 22 E1 B2 36 78 12 7B AF 49 E7 BD D7 6E E1 AD F3 DE 6B 
7D D8 7B AD DB 4A 14 68 AF 96 4C B2 92 CD D8 64 11 D6 E8 B4 BA FA 7D 5C B0 F7 D8 B1 63 AF 1D 01 
DC 3D A8 EE BE 9B 81 BA FB 02 21 D0 FF 73 09 22 40 DF FD E7 88 A8 A8 3D C4 69 D5 FD 70 63 54 94 
1D F4 E6 75 51 51 73 11 3D 72 6D 04 6A A3 53 05 BD D6 9E D7 1D 7C EF B5 D7 7E F0 3C E0 1F 6A 6E 
C6 79 DD 2B 33 3B 0A F2 DD 7B DD E7 40 FF 62 0A CA A1 DC 8E EE 57 12 09 84 5F 3D FC 1A FD 4F 20 
FE D7 87 9F 3F FC 5B 15 7A 8E F5 F5 E7 D2 21 BC F9 A1 7C 2A 80 23 BA 30 1F 5B 00 AA 12 E6 10 66 
95 A7 E2 4F 9F 1A CD 62 F1 20 CE F1 26 CC ED 8C B1 4F 47 CA 71 CA 22 41 D9 A9 85 9D 20 5F C7 8D 
56 76 C4 B0 34 11 38 37 D5 F2 81 8E 4D 19 10 E8 B5 23 0F 6A 67 27 C7 6F DF 1E B9 37 F5 60 E2 2E 
3C 3E 97 05 6E FC 1E 81 FD ED E9 D1 D9 2A 09 F6 65 1B BF 23 A9 19 C2 A0 DF 1C 1F 9F 86 33 37 BC 
C5 F4 25 64 81 BD 08 07 AF 99 BB 7B 2F 10 C9 21 AD FD 70 90 F4 5E 53 8A 7B CD D6 8B 73 DE 6B 57 
09 EF B5 6E B3 EC 8A 93 6B F2 C2 88 5E 60 2C 90 A0 B2 4A 58 32 BD 4C 58 32 1D 3D F6 2A 17 1C D2 
36 33 D2 48 5F A0 25 83 FE 9F FF BD 75 E7 0F 91 C8 FB 4F 9D 1E 3F B6 47 74 1D 7E 48 46 74 1D B1 
0B 65 D0 49 A7 16 00 9E 39 7A F4 E8 B1 1F 80 16 C2 92 A9 56 99 8F 8E A5 CC 17 7B 05 FD EB 87 5F 
C8 87 C8 90 FE D5 97 0F 1F 0E C1 87 0F 6B 66 D1 F3 87 5F 55 E1 9D 6A FF F6 F0 6B 39 B1 F7 C3 BF 
11 BF BF 96 7D 1D C8 A0 67 2A 85 FC 18 69 89 A3 BB 8C CD 6E 87 3C 16 2B 1D B6 85 68 8A 20 0F 6D 
CE 2E 51 01 14 88 A5 5B 5C AD 17 A8 7B AF 6D 94 F0 05 EB 61 42 08 7B F9 BC D7 E6 40 1F 1B 9B 44 
A0 DF 87 B7 47 C7 26 26 6E 8E E1 E7 B2 A1 B9 40 3D 31 5B 35 31 3E 36 36 32 3E 39 3B 33 34 83 41 
9F 1D 1A 22 41 47 3B 4E 3B 79 32 D2 8E E8 D8 7B 0D 55 DB DD BD D7 CE C1 5E 8B D9 C9 7B AD CF EE 
BD 26 E9 EF B1 58 BD 83 0E A5 04 14 0E EF B5 EF 92 DE 44 04 E8 94 BC D7 56 12 F4 E6 56 BD C1 D0 
4A DC 7F EA F6 18 90 48 D0 0D AD F8 E1 4E 0C 7A 1D F1 B0 B5 91 3A E8 4E DE 6B B7 ED DE 6B 35 CA 
7C 14 7E E4 5E 41 FF 1C 23 3D 3B FB D0 F1 E4 E1 57 08 F4 AF 20 7E 5C 83 F0 7F F8 25 FC 1C 81 FE 
10 F7 C8 A1 C8 4E 86 F8 40 6E A3 63 D0 D9 20 A7 20 CF 0E 20 3F 1C C6 71 11 92 F1 B0 48 E8 00 DD 
04 D8 2C B6 74 4B B6 0B A3 94 41 D7 A8 4A 00 28 23 BD D7 8A 64 9B BD 7A AF D1 31 70 B0 83 3E 7B 
E3 C1 83 9B 08 F4 B1 59 38 3D 46 66 7F 1B 7F 30 1F D1 C7 EE 4B 8F 93 CE 6A 08 F4 7B 38 21 EC 7D 
78 6F 96 A8 BA A3 58 3E 76 A3 6A CA 93 EF DA 92 22 FA 9C F7 9A D5 EE BD 26 B6 7B AF 5D B6 7B AF 
D9 AB E9 76 EF 35 33 1C 1E E8 EB B5 7A 07 5D DE 56 26 96 C0 6A 7B D5 FD C8 6B C7 8E 7D 97 B5 1A 
AB EE FF F9 DF 35 4D CD 3B 77 EE AC AF 23 DA E8 3A F4 70 27 CE CD 8C 60 AD C7 0F 9B E4 38 A5 6B 
3D 7A 5C 5F 4F B9 1B B1 16 83 BE 2F 1B EC 3B FA FD A3 47 5F 05 EA 7D B8 EA 5E 2B 37 4A A4 12 49 
A5 9B 81 C3 D3 F3 6D F4 2F 3E FF AB EC AF 0F 1D 8F BF A8 45 78 13 44 7F 2D 41 91 FB E1 50 0D 7E 
3A 34 F4 D5 17 B8 D2 8E 5E FB A2 F6 AB F9 6E F8 80 04 1D 08 41 A7 CA F1 5C 90 A3 C4 41 97 9D 27 
CE 07 F3 A0 A3 88 2E D9 E2 8A 28 D3 DE 6B 9C A4 74 5E 28 E0 F3 78 09 20 91 57 C4 01 D1 BC F4 10 
6E 28 2F 06 08 D3 79 D1 80 C5 E3 25 82 04 5E 11 1B 44 17 79 CB 3B 31 39 43 96 8B 9A 91 F1 FB B3 
B0 F6 2E C1 F7 C8 71 D9 03 47 85 7C FC 9E 23 66 23 D0 47 A5 53 23 93 C7 6B C6 E7 41 1F 9B F1 68 
99 4C 82 DE 12 83 4F 85 C7 CB 03 1C 5E 11 71 2A 2C 74 8A 45 5C 90 5E 94 0E B8 3C 74 8A 6C B4 BD 
C5 D5 7B AD EF C2 85 F3 A4 F7 DA A0 9B F7 9A 9B 25 93 F9 C2 E0 E0 55 78 D1 6B 5E 77 65 E1 FA D2 
E4 5C 7B 67 1C 07 80 C3 4F 7E 8F 85 7E 6A EB 97 AF 33 6E 69 A0 FF E5 BF A5 F2 2A 2C E2 AC A4 C4 
C3 2A 22 7B AD 62 6E B3 CC 69 33 25 C9 9B 5A D1 C7 CE C3 B6 F0 C7 5E 79 0A 94 A3 FB 5B EB 6E 39 
94 A5 65 64 74 C9 BC 76 C6 7D 2D 93 C2 21 07 BA 33 12 58 85 7B E6 66 67 1E 3E 9C 92 E3 28 4E 20 
3F F5 DF 53 55 A8 8D FE F0 6F 28 DA 7F 09 9D EE 11 FF 11 CD 8B 11 08 A9 94 48 5C 0C D2 85 6A 5C 
3C 42 8A 50 F1 60 F3 78 49 20 8F 97 AE 01 68 57 75 B6 FD 10 79 E4 21 F2 78 45 78 7B BA 40 90 EE 
28 4E E5 BC A2 72 BC 9D 8F B7 03 F5 82 B7 14 72 63 D0 F6 EC 22 E2 2D E7 4B 5E BA 9A EB 54 22 D1 
FE 4E 25 92 67 2F 91 AE A0 17 CA D7 6C 4A 85 51 8E 5C AD 82 8A 76 6C B3 C8 4E 3C 91 C3 0C E8 EA 
0D 05 F3 DE 6B 31 3E 4C 16 59 EC 72 36 50 27 25 F1 71 6E 2A 21 9E 86 23 E0 B2 93 D8 40 C0 49 62 
81 EC A4 A4 10 3C A5 2F 1B BD DB 67 DE 23 FA BD 7B F7 EE CF D6 4E DC 1C 1F BB 37 43 78 9E 4F DE 
71 32 64 40 A0 DF 9D 07 FD 38 6A 98 CB 6F 4F CE CC 81 7E D3 27 E8 1C 74 76 DC 24 D4 C0 10 26 95 
E3 53 29 CF 06 AC F2 72 2E E0 94 73 00 37 11 6D CF 46 67 2D 70 F2 5E 3B 69 ED 1D 18 56 12 DE 6B 
12 99 9B F7 9A 3B E8 DD 16 9B CD 72 4B E1 35 A2 A7 A4 C8 E5 B9 29 72 59 03 AA BB EB 0E 65 03 80 
A7 25 B2 0F 60 4B 26 EA 83 54 2B 03 3A 65 7C FD 50 03 76 A2 DA 07 80 F0 A9 67 F8 D8 1E 5D A7 35 
34 48 60 DB 86 92 92 0D 9D 3E 7A DD BF FE 0A 0E CD 3D FE B2 0A A2 EA F9 5F 25 5F 7C 5E F5 37 FC 
40 8A 77 44 35 F7 2F AA 66 70 68 FF F2 E1 D0 CC E7 F3 FA 8F 1F 97 B3 B9 5C CE E2 25 12 17 83 24 
0E 97 8B 0B AF 00 A7 4F 11 26 25 11 BB AA D1 76 FB 21 D0 76 3E 2E 36 73 DB 39 E4 76 47 71 22 0F 
8D 27 B2 01 B4 9D 05 04 CE 6F 89 0F CD C1 D3 D6 F1 5B A2 6A EF FC 5B 12 25 CF 7E 08 BE A7 12 E9 
06 3A 2A 86 9D 6B E6 72 32 0B 8C 9D 49 44 44 2F 60 06 74 87 F7 5A DA B2 7A AF D9 41 1F 9A 1C 1F 
47 6D 74 0C F3 F8 E8 14 A2 77 E4 1E 74 AA 8E 8F DD 97 4F CD 55 DD 27 EF 4B EE DE 96 3F 98 98 07 
FD 81 CC 93 1B 93 1D 74 6A A7 E6 00 FD 34 E9 BD 66 F3 E2 BD 66 5D E0 BD 86 59 3F 0F 4F 9A BD 81 
8E C7 2C 2A 4D 70 6B 33 39 61 26 5B 20 10 26 1C C0 1E 8B 94 5C 93 FD D6 EA 02 5D 56 BD D3 A0 6B 
6E DE CB C6 2B F5 F9 7B D1 BD 4E DF 5C 0D 95 F9 1D 32 D9 09 77 4B 26 97 71 F4 87 7F 85 73 FD 6B 
F6 2E 77 F8 D7 AF F1 36 A2 9D 4E 6E 27 02 FC CC D0 43 E8 54 73 0F C8 36 BA 18 38 F2 B8 63 A9 4B 
E5 79 2C D4 9A 8E 81 9B B9 45 44 AF BB BA D2 C8 5D 3A E8 7C 91 DD 7B 2D 8F CB 17 0A 4B 14 5E E7 
C8 31 D9 EB 3E 36 31 32 31 7A 17 DE 1F B9 27 39 3E 39 32 3F 68 36 3E 2B 7D 30 39 3E 32 31 86 40 
1F 19 9F AD 9D 99 9A 1C 27 41 1F 27 DC D5 EF 79 1B 5F F3 BF D7 DD 2A B9 65 F5 EE BD 36 20 B5 23 
6D B5 12 DE 6B 66 0B F6 5E 13 7B 75 6A 49 31 42 28 2E E9 82 D2 06 3C 05 56 D7 BA EF E5 BD 87 5A 
9B F1 14 58 CA 3D 5A 7E 69 75 81 0E 25 E4 C7 DE F3 72 5E DE CB 07 B4 38 A0 37 C9 A0 38 13 BD 95 
D4 47 67 1C 8E DB F0 CB B9 CE B8 AF 65 38 92 CF CE FE AD 06 47 78 F2 0E 80 36 10 3D F1 0F BF 92 
7F 25 99 1F 45 0F 4C D0 95 2E 00 6B C2 60 3C E0 87 80 52 98 A7 89 96 6C 00 7C 21 80 A5 D9 34 40 
B7 7B AF 65 C1 E4 F0 28 D5 72 79 AF B9 82 3E 79 A7 EA EE 9D BB 70 66 F4 3E 9C B9 77 E7 CE 9D B9 
B9 F1 E3 F7 24 F2 BB D3 77 67 6E 8F 22 D0 27 A6 21 BC 3F 6E 07 FD CE F4 DD 21 17 53 C6 25 81 EE 
D4 EB 6E B9 02 95 E7 2F 5D 1C 76 F7 5E BB 0C CF A1 AD 28 DC 93 44 5F B9 72 EB 56 7F BF 6D 60 F0 
CA 95 73 DE C7 D1 61 67 61 89 A9 14 5B 82 2A 9A F4 78 D6 77 B3 8E F8 A1 D7 53 5D BE E6 A7 56 19 
E8 D8 21 1D AF 69 41 1F 58 47 58 CE 35 D5 E2 09 B0 E8 B3 CB 33 BC 44 F4 87 5F CD FC F5 EB BF 4A 
67 3E 7F 38 04 BF F8 A2 E6 AB AF BF 9C C5 6D 70 D4 12 97 11 3D EC 44 3B BD E6 6F 5F 7F 3D 45 DE 
0B 20 9C 7A 18 E0 A0 2B 5C D8 63 6B 52 E0 86 4D 6B 73 60 B2 90 A3 D9 00 37 84 47 74 28 A3 59 4B 
03 5D 98 21 C9 4E 24 87 E5 34 79 78 74 BE 2B 6C 99 BC D7 48 D0 C9 09 33 B3 F2 91 07 53 E8 CD 86 
1E 4C DE 26 8B C9 BC 79 C3 C8 3D DC 61 37 7B 6F 72 A6 76 62 6C 04 CE 8C 8D 8D D5 CC 4C 4E DC C5 
7B CD 78 1D 5C 5B D2 CC 38 6B 3F F6 53 BB 7A B1 DB 32 20 77 F6 5E C3 8E 6C 57 2F 39 BC D7 88 78 
2C B6 5D B9 8A 7E 5D F4 3E 05 56 96 96 91 93 4B F4 6F 55 37 19 F4 D8 7C AD 19 2F 53 D5 D7 31 93 
F3 74 81 56 1B E8 B0 1A 1B 51 91 96 73 5A BD A1 1E 5B 51 C9 14 32 F2 87 97 71 F4 BF A1 7D 66 D1 
33 04 FA E7 7F 45 DF 5D ED 97 C4 64 19 39 51 73 AF C2 58 3F FC 2B 6A F7 54 11 9C 3F 9C 85 5F 3A 
4F 7D 0F 40 D0 53 A1 AB 67 12 E9 BE 26 8D C2 0D 75 D6 06 F4 30 37 06 ED C0 2E 87 EB FD 06 1D 7B 
AF AD 95 93 23 E7 2C 62 55 AB 0F 7B 26 06 E6 BA 4F 12 0D F0 C9 D1 9B 63 93 A3 A3 A3 93 63 37 47 
FE 38 8A E5 34 0D 66 DC FE 0A B1 EB E8 A4 FD 8F 26 F0 5E 93 DE 39 5F D2 5C 77 AB 27 EF B5 D3 9E 
BD D7 88 7D 7D 8C A3 2B 4D C6 12 55 07 C1 90 B4 A1 5E AF C5 19 18 F4 DA FA FD CB 13 CF 57 21 E8 
50 5E A7 D3 DB A5 AB 73 9D 3A E0 B5 EA 4E 0C 92 13 6B 57 1C 8F ED 4F E7 6A EE F3 DB 5D 57 B8 04 
60 44 E7 A8 DD 9D D5 9C DD D7 88 87 C4 A4 39 36 70 EB 2E A7 E8 BD 96 5B B9 22 DE 6B 3E 65 F7 61 
73 32 51 F6 57 CB B6 7A 8D A2 F7 5A 5B 46 4A 4A 46 2E C9 90 A4 BA 61 B7 CE 60 D0 35 35 D6 2E 4B 
FB 1C 6B A5 40 97 94 15 17 17 48 5D D4 A5 AA F4 98 5E 4A BE B5 09 7D 6A BD 41 DB E4 9E 57 C7 DB 
38 BA 77 3D 9C AA F5 BD 43 60 80 EE 71 F5 9A 23 BF 8B D7 36 B4 BB 28 2E 53 D5 50 3D A0 1F A0 FB 
B9 1E 7D EC 7E 55 2D 21 C5 83 A5 92 4E 3D A2 2F CF 7A 74 A9 02 69 2E 7C 4B E4 E8 03 55 C9 E1 B2 
71 4E 13 F4 79 6A 51 BD 7A EE B1 A7 3B 40 C1 BA F4 F4 CC AE B2 79 A5 B5 27 8B 8A 22 3D 7F 30 79 
55 F5 D6 83 D5 0B 4D 99 96 B2 7A CD FB 0A 55 52 01 01 BA A7 F5 E8 FC 1C 71 01 96 38 99 C2 D2 71 
37 D0 19 C9 58 43 3D C3 0C B8 EE 6F E2 09 DA 11 FD 06 E5 88 7E 6A 79 32 CC AC B4 68 81 2E CB 8F 
B4 E7 AF 58 D7 0E 0B D6 93 4F 36 47 14 7A 98 D9 D3 11 99 90 B0 BE DD 49 65 B9 11 A1 79 F1 FE DD 
C1 FC 8F E8 8B 2A 30 22 3A 87 91 88 9E 38 07 7A 36 33 39 E3 84 5E 4E D7 5D 2D BF 5F 79 4B A6 DF 
7D 42 ED DC B8 EF 9E 62 04 F4 D7 9D 8E F9 8D 03 5D B2 2E 2F 2F 1A 2B 2F A6 04 96 85 27 10 8F A3 
59 11 1E 3A 0E 0B 36 46 87 AE 37 95 75 CE 29 2D 37 2A 3D 34 82 06 E8 FF CC 4C 2A A9 80 C8 19 C7 
48 EA A7 72 CE 7C 7E 66 36 03 96 4C CE C7 5B 44 4F 7F EA 77 4C A7 A5 1B 37 3E FD 03 D5 73 7B FD 
24 DD 24 B0 A8 DD 7E EA A4 F3 77 F1 8D 03 5D B6 25 34 26 3D 3D 26 26 26 B4 C8 08 DB D6 46 C7 C4 
E0 27 09 91 5E 40 4F 56 B5 39 81 5E 11 4E 0F 74 F0 FF D1 07 FD 8B CF BF 08 88 7C CF D9 74 93 C0 
12 E9 99 9D 9A D4 5C BA D9 A3 71 FE 68 8A 79 56 B1 FE 70 7D 25 D3 BA 7F FA E9 F5 DF 50 BE 09 B5 
7C 7C 8A 66 5A F7 93 27 4F BD E9 9C 04 F6 1B 08 7A CE BA 75 91 11 91 9B B7 6C 29 ED 82 1D 85 EB 
36 47 46 6E 5C B7 65 5D AA 87 21 02 0C FA 96 4A 27 D0 4F 18 45 34 41 07 FF 41 37 AD FB 17 5F 7C 
FE 6F D4 0B E3 6A 56 08 03 60 BA A4 61 E7 0A F9 34 25 F4 CB 93 E9 B1 5D 7F 58 C1 7F BB FC B0 5E 
03 2D 3F 7A FD 63 9A 7A DD D5 B6 E6 1B 07 3A EC 52 E5 1A 4B 8C C5 2A 55 96 1C CA CB 72 8B 8D C6 
CA 5C 95 AA CB 03 BE 18 F4 CD 46 27 D0 BB E8 83 0E 9E FE 77 9A FA B7 80 88 E7 58 82 10 BA 60 52 
F6 38 0E 8A AE BE 79 A0 8B DB CA D2 D2 D2 DA D0 4F 39 94 15 64 B5 11 4F 3A 3B BC 80 BE AE D2 05 
F4 58 DA A0 83 16 9A F2 F3 02 D1 F7 37 5B B2 15 DA 4A 2B 9B CD A1 E5 DA 98 58 CE A2 DA 15 87 F5 
C9 1F 7E FB E9 BF AC 88 8F 2A A1 3F FD C6 0F 33 AE EC 37 7E 4A D3 4E F5 D4 BB AF BB 1C 71 21 E8 
B5 07 1B 1B 1A 1A 0F 2E D3 AC 38 2C 9A A0 77 B6 13 D4 B6 97 C9 A1 E4 04 F9 B8 D3 74 C2 33 E8 D1 
C9 2A E7 CE B8 E2 4D 31 A1 51 9E 41 97 14 1C DC BF FF 60 C7 FC 30 9D 4C 4E 8C 39 BA 81 FE A3 37 
DE 64 F6 02 F8 D6 CF FE E1 AD B7 57 4E EF FC E3 CF FC 38 37 2E 9F 4D CB 4E 35 31 89 A3 71 AE 5E 
86 D0 6E F4 A3 03 50 1E 5D 03 9F FC 7E 45 7B E3 6E 5C FF F4 4F 8F 51 3C B5 96 EC 77 4F D2 1D 61 
3B 7D CA 65 74 CD 01 BA D4 D1 C4 AD 6D 6C AA D7 1B 0C DA 9D 75 8D CB B1 14 9D D0 4A 81 DE 11 55 
9E B8 DE D4 6E 9A 53 56 F1 DA BC C4 70 4F 43 EE D2 AD 0D 4D 3B 9B 9B 77 36 35 38 1C 99 3A 32 73 
52 53 55 EE 96 4C 3F 3E 45 F7 0A B8 5F 00 9F 17 FC 67 EF BC F3 CE 5B E4 BF 95 F8 F1 FF B3 F7 EE 
51 6D 5D 77 DE F7 46 42 5C 24 40 DC 25 0C 42 67 23 0E 3A 82 73 B8 48 20 C0 12 60 C8 5A 4F 71 A0 
6B F8 CB 26 36 0E F6 B2 BD 16 2C B0 E3 38 89 45 E3 21 B1 3A 9D EA 71 3A 75 27 EE 3C B1 A7 33 60 
C0 F7 6B E2 C4 76 1C E2 A6 7E 67 3A AD ED 66 B8 1A 5F C1 79 BA DA 79 DB 79 D7 BB DE D5 79 66 25 
6D D2 FE F1 EE BD 8F EE E8 86 24 14 47 3E 5F 27 70 B4 B5 75 74 84 CE E7 FC F6 DE 67 EF DF 17 BD 
DB 3F 86 7A 6C 40 12 B1 57 1A 06 DB 45 BA 24 3A B7 D7 42 1E 8D FB 55 AC 1D 1C 6E FF FC 97 A1 36 
99 7E F0 4E 14 6E A4 1F FD A1 BB A1 2A 06 BD AD 5E AD 2A 5A 8B CF 7F FA 95 1D 5B C9 6C F7 EE DE 
BE AD 1B 9E FF 86 83 CE 69 55 AA 1A BD 9E 72 FC 43 FF A9 CD C5 55 3E 6A 76 6E E8 E9 C3 66 54 BD 
5B FB BA 37 AC 27 AF AD 52 A3 5D 7B E7 75 CF FC 49 14 BE 81 A3 1E 9E 58 81 D4 8A 30 8F B1 0E 87 
1C D3 B3 0A 22 07 B3 D9 CD 92 29 21 2A A0 AF 49 08 74 CC 6E DA F9 BF 63 6F C9 74 27 C4 E1 99 9D 
7F 17 8D FB E8 47 DF F9 A9 DB 3E 31 E8 FD B2 AA 72 D5 20 06 FD E5 17 FA C8 9A 96 6D DB 10 EB 5B 
77 74 7C B3 41 87 0C CB 7A 85 6F 9A 61 7D 34 54 8C 1B B6 F6 F6 90 B5 3C 3D 3D BD FC C7 A6 EA ED 
CF 79 80 7E 30 2A A6 58 47 42 0C E9 28 A0 C7 9A F3 15 84 74 51 54 2C 99 9A 9D A0 47 C7 92 69 4D 
C8 53 60 BF 06 4B A6 7F FF 9A 2D 99 A0 A5 AD 9C CC 00 5F DF 8D 2D 1C 36 F6 EE DA D5 8D 17 72 F5 
ED 30 46 11 6F 97 62 06 7A 88 EA DC D1 47 D6 AE 75 77 63 CB 39 F4 B1 51 4C 67 4B AA 6A 86 1A 6D 
5E 11 FD 9F A2 D1 A4 3A 74 E4 27 21 9E 8B FF 1C 73 D0 DF FE F1 DF 87 78 6C 5F 83 25 53 97 7F DF 
06 A7 E2 C1 92 69 67 94 2C 99 7C 4C 81 1D A8 C7 06 C3 ED 1B D0 09 BF B1 F7 B5 97 F6 EF 7F F5 35 
BC 54 B5 77 D3 AA AC 16 7B CA 40 A7 37 E3 E5 E8 DB 76 ED 7E E9 A5 DD BB C8 C7 DE 80 4A 2D 25 6A 
93 DA BB 8F FE 4F 51 B1 B3 0D 15 F4 9D 4F 35 E8 C1 2D 99 44 81 BC 93 56 0E BA 28 39 3B 38 E9 F1 
00 FA AA 79 AF 61 61 4E 5E C6 8B B2 FB F6 F3 EF F5 EA 56 9C 7A 62 7D 34 C0 F6 D6 53 06 FA F3 38 
95 54 F7 6E 31 39 DB 76 A3 8F BD B5 07 7F 6C 46 AD C5 63 F0 5F 23 E8 DF F0 88 2E 2A CB 89 0E E8 
FC 12 58 71 33 94 CA 13 C9 FD B3 00 2B 66 A2 05 FA 34 C9 FB 86 57 99 E3 B5 E7 F3 33 77 66 A6 A6 
A7 A7 3D D6 9A 93 45 E9 53 8E AA 33 F8 C9 D9 E9 00 AB D1 C3 8B E8 23 A3 F6 95 E7 F8 37 5E 6C 3E 
76 0C 17 8F BA AD 47 3F 84 0B C7 1D 1B C7 FC 27 9E E0 06 9A 06 86 8D 90 DD B0 15 C5 F3 57 01 68 
FD D6 B7 9E 03 AD BB 71 D2 B8 CD AB 11 D2 9F 32 D0 79 CB 39 FB 68 6D E5 6E EC A7 8A 5A 32 5C 49 
55 55 89 3E 30 E8 23 63 F6 3F 37 FE 7D 6C 14 15 90 BF B2 E7 FA FF 51 FE A9 30 40 0F 2D A2 4F 1C 
C7 3F 4F 1C 3F 81 37 8F 1F 9F C0 DB 58 E8 31 7E 80 1E 4D BC 4D 0A 26 62 05 7A 17 BF F6 BC B2 D1 
24 4F 24 DC 05 F0 4A 0B 25 C3 4C 15 85 17 A3 B7 D6 1B 0B BA BA 0A 59 08 AD 8A D5 CC 30 43 34 4F 
12 42 CD B7 2F CC CD 2E 75 60 9B A5 99 27 07 D0 B5 FF A1 5B 36 B8 D9 A5 49 D4 C3 3B 30 3B 4F 2F 
A0 AA 33 77 E0 83 B9 B9 C7 01 F2 48 85 17 D1 C7 AE 9F 82 38 97 CC A1 51 9C 53 86 3D 3D 36 76 1A 
8E A1 13 EF 34 FA 3B 50 57 1D 4C 8F 5E 65 F9 E4 90 63 E7 21 7B D2 6F CE B8 FE 62 AD B6 A4 06 76 
BE D0 DB B3 F1 B5 2C 20 7A FD 8D 37 5E EF 02 09 7D 08 F4 2D AB 71 3B FD E9 02 DD 91 EE 19 EC FF 
DE F7 5E 02 20 91 4F F7 4C AB B5 1C AB D5 32 81 40 1F 39 72 0E FD B9 B9 D3 38 8F 17 BA 22 9C 1D 
19 BB 0A 2F 8C 1C 1A BB 8A AE 0F F0 BC BD D2 D1 53 A8 CE E9 D5 8B E8 13 D7 8C 98 ED 4B F4 FB 13 
27 DE 67 20 FC 60 E2 C4 25 FC B1 6A 2E 9D 78 1B 5E 9B 78 FB C4 7B F0 DD 09 5C 40 BD FB F6 89 98 
80 DE 95 03 B3 45 E4 57 59 57 57 C3 30 7A EB BA 66 BF A4 87 92 33 AE 8A 22 69 A4 A8 5A 49 62 15 
2C 97 D5 F5 43 99 DF B4 EE D1 06 7D EA 56 FB A3 87 0F B8 07 F3 F7 3A EE 3D 68 77 CB FB 38 BB 04 
3B EF 3D 38 C0 3E 99 A6 71 D6 D7 99 19 F8 60 7E 8A 79 14 E5 88 3E 72 9D A1 CF 9E 3E 7D E6 CA C9 
F1 8F B8 AB E7 CF C0 D3 C4 92 E9 D0 19 78 E6 DC E9 8F E1 69 7B 04 39 0B 75 3C E8 C7 EE D2 9C 7F 
D0 4B B5 15 9C 9E 85 EB BB 51 CB 7D 37 90 FC F5 9B 48 7F 0D C0 DE 9E 9E D5 49 03 FB 74 81 DE 89 
2D 99 F6 64 01 E5 77 88 E5 5C 25 31 70 68 D7 97 EB 7C 24 87 F4 04 7D FC 43 78 E6 F4 E9 B3 1F 5E 
1D 3D 0D CF 5F 3D 05 CF 45 D3 7B F7 00 00 20 00 49 44 41 54 8C 5F 80 17 C6 C6 4E C1 8F D0 57 03 
CF F0 29 BE CE EB 4F A3 EF E7 BC 87 27 56 34 23 BA 0B F4 E3 EF C3 0F DE BB 06 DF 9F B8 84 7E BF 
CF B1 13 13 1F C0 4B 13 13 97 8D 13 27 70 C1 35 D8 18 C2 EE A2 01 BA 82 80 9E 55 0C 41 A5 0C 9A 
EA 64 E5 50 1B 11 E8 BC 53 4B B2 CE D0 2A 85 A9 92 AC D6 04 B5 4E BE 7A 96 4C 9E A0 CF DF 87 8F 
E7 E7 EE DC 9A B9 35 33 35 FF D8 2D BB FB 54 47 C7 AD F9 B9 A9 DB 77 E6 9D A0 4F 3D EA F4 6B BB 
16 66 44 1F E7 3E BC 3E 8A 74 84 38 B5 8C 1D FB F8 0A C9 02 7B 0E 9E 1F 47 A5 17 21 39 AD 46 AE 
7E 78 D2 9E D7 FD 3C 77 2A 40 44 87 FC 4D 28 87 25 D3 77 DE FC EE 77 DF 7C BD 15 EC 79 EA 2C 99 
08 E8 FA 01 3C EB B5 D4 31 05 B6 94 3C F0 39 05 96 36 36 35 E9 69 DA 95 A9 82 66 8C 4D C3 A5 5E 
B5 EC 96 4C E0 7B 6F 7C F7 8D 37 5F 77 59 32 B1 3E 2C 99 3C 40 1F BD 48 5F C0 7F EE A3 47 D1 1F 
7F 7C 6C FC 2C 7D 1D 83 7E 12 9E 45 A5 E3 A7 20 FF 07 3F 72 14 55 81 A7 C2 01 7D 85 11 FD B8 ED 
F2 F1 89 89 B6 CB 08 F4 F7 26 10 F5 97 4E 9C B8 7C F9 F8 BB 08 F6 13 F0 DD E3 13 C7 DF 43 D1 3E 
76 A0 8B 45 54 51 66 16 54 4B 2A B3 40 1E 4C F5 97 09 2A 74 EF 35 6D 29 90 D4 50 B8 BB 2E CF 81 
79 FE F6 17 79 5E 77 3B E8 0F 3E 9B 9F FF AC 73 61 7E 09 2E CC DB 9D 90 5D CE 0D FC 36 0F BD 13 
F4 87 0B F0 89 5F 23 D5 F0 22 3A 6A 22 9E 1B 3D 34 82 74 88 F7 5E BB 7B 97 CF EB CE 8D DA 9F B5 
5B 32 8D F1 4E 2D 47 B8 73 E7 98 00 A0 53 FD 26 74 FA AF C7 33 65 5E 05 AD 38 A2 BF 81 22 FA 6B 
28 A2 3F 5D 26 8B 04 74 DB DA 7E 93 49 6D 6A AB 19 66 21 53 D1 86 B7 FB D7 AE F5 B5 A8 85 52 A5 
54 6B 8D 16 9B 53 C6 01 73 5A 6A A1 57 4D 02 FA EE 9D E0 7B 6F BE F1 5D 27 E8 EB E9 FE 92 FE 75 
5A 53 80 A6 FB C8 49 E6 D4 38 FF 25 90 14 BC E3 67 58 0C FA F8 59 42 38 6A 73 9D E5 DB 55 A8 C7 
7E 35 BC 88 BE 52 D0 31 C8 13 1F 30 3F C6 A0 4F BC 0F 0F E3 66 FB 07 14 6E BE A3 D6 3B EA B1 5B 
4B 63 18 D1 E5 C9 B0 2C 53 0A 15 38 25 A4 D8 A2 F6 67 7F 1A 2A E8 E2 66 A6 25 4B C2 69 B1 11 AB 
28 5B E7 DF A9 A5 2B 41 9E 00 24 78 BD 4C AB 5C 9E 09 B2 E4 72 09 B0 17 65 E1 1F AD A0 92 2F F7 
E7 D4 62 07 BD FD 11 12 5C 98 9A BA 07 E1 FD 3B 04 E0 F9 03 8C 33 13 EC 9C 33 7D BB 13 F4 45 F8 
D0 9F 73 83 0B 74 B9 E3 50 32 DD 0E 05 5D 9C E4 F8 47 97 BD DC 05 FA 29 DD C9 91 A3 27 4F 9E BC 
8E 41 1F 1B B9 8A 82 48 00 A7 96 D1 B3 DC B1 D3 01 40 A7 4A CC C5 E6 41 68 D9 88 FB E8 95 60 FB 
DF 7C FF FB DF 6B 05 59 7D DB 7A 9E C2 3E BA AE A4 4E 26 CD CB 93 D6 15 16 5B A1 D1 AC 91 A5 E5 
A7 C9 0A EB AA 7C 2D 53 95 29 0D C5 A8 8D EF 96 61 46 B6 3C C3 4C 3B B1 4D 16 61 CB B9 37 BE FF 
57 20 E1 35 DC 47 EF 84 B4 B6 B6 56 1B 68 D4 7D EC 3C BC 3A 76 E8 3A FE 12 F0 00 C9 C8 05 EE 22 
6E BA 8F 5F FC F0 1D 02 FA 87 76 4F DB F3 17 5D 7D 29 07 E8 37 F9 AF 3B C8 19 99 F9 8F 2B 02 FD 
C7 18 E7 89 0F E8 4B 87 E1 FB 87 2F 71 97 8F 23 B6 AF 41 F6 F0 09 3B E8 E8 A9 C3 C1 41 FF 07 C0 
1F 0A 3E F3 1C 67 64 A5 AF 33 32 08 E8 99 DA A1 C4 D6 62 2E 03 8F CB 89 D6 56 78 E7 8E 5C 29 E8 
09 52 D6 20 92 B0 5A BB F7 5A 8B DF 4E 7A 41 BA A2 0C 74 29 14 06 A0 CC 51 AC 01 49 8A 74 79 66 
99 A2 01 24 A4 2B B2 81 38 47 A1 04 06 85 22 11 64 2B 02 26 98 99 87 8F 16 26 27 17 74 0B 53 77 
E6 51 A4 66 97 10 D4 73 0F DD 5A EE 3E 40 3F 80 7A E9 C1 40 CF 6C 40 87 92 A5 50 24 81 35 F6 43 
11 A3 43 51 48 40 BA 22 1D 48 72 50 79 22 2A 77 F3 5E 63 8F 8E 5D C0 66 E0 D8 92 09 35 BC CF F0 
96 4C 76 EF B5 EB 8C 07 E8 23 47 E1 D5 F1 40 A0 6B D5 10 0E 95 30 EC 06 04 7A DF 7E B0 53 F2 E2 
8B A8 FD F0 12 1E 75 5F 95 CC EE 91 81 5E 84 13 4F 94 95 39 13 4F 90 07 3E 13 4F 58 34 19 19 EE 
19 66 06 4B 6B A4 CB 57 AF D1 1B FA 7A B6 6D 7D 09 80 FD AF BF FE 2D 00 0C BD 08 F4 2D 0C 34 0E 
0E 35 0E 52 81 40 3F 07 AF 8F 5D C7 36 F5 17 D0 55 96 65 E1 C7 E8 3B C1 A0 5F 39 82 41 3F 7A 85 
07 7D EC DC C5 8F B8 2B 9E BE D5 3F CA 56 34 64 66 B9 9F 91 CD 3E CF C8 C3 2B 02 1D F1 8D 40 7F 
9F BE C4 0F C6 E1 66 FA F1 0F E0 65 FC AC 1D 74 5D 70 D0 DF 7E 1B 9F 79 E9 95 1E 67 A4 C1 D7 19 
19 18 74 51 06 2B CD CA 32 73 C4 5E B5 CB D4 14 29 E8 A0 C2 24 4F 94 94 D6 64 26 92 A6 7B 5A B0 
A6 BB E7 2A C1 9D CE 1F C0 59 1E AC 8F 3E 4D 9A EE 53 F8 36 DA 43 F6 D1 D4 9D B9 25 B8 E8 8A D8 
B3 F7 E1 C3 39 4F D0 EF 1F 80 4B A1 35 DD 83 2D 61 74 8B E8 A8 2F 78 F4 E4 F5 B3 7A 04 BA FE EA 
D5 93 A3 23 A4 E9 7E E5 AE 67 D3 9D 07 7D F4 E2 DD D1 F1 73 EC 49 BF 06 0E A6 46 74 3E AF 1D 82 
64 E2 C8 2E 25 F1 5E 93 BC 84 03 7A EF AA 4C 77 8F 30 95 94 12 E7 92 32 18 94 49 26 D8 94 5A 80 
F3 4A 19 0C 5D 69 7E 33 CC B8 AD 5E B3 B6 55 FB 58 A6 BA B9 BB BB 67 E3 AE 7D FC 49 B0 6F EF C6 
9E EE DE CD 3A 5D 9B B9 C5 6C AE 62 03 46 F4 F3 A3 87 4E 5E 3F 47 63 D0 AF 5E BD 30 36 42 40 3F 
A3 C7 A6 D5 23 27 59 67 D3 7D FC 10 7B D7 6F D3 3D C0 19 B9 C2 C1 B8 09 3E A2 B3 87 2F A1 88 FE 
2E A6 FE C4 61 78 0D B7 E7 ED 4D F7 6B 54 F0 FD 79 36 DD 03 9D 91 81 41 CF 2A 84 22 71 56 21 36 
52 8A 46 D3 BD 2B 9B 4E 91 27 B6 96 C3 4A EC EE 54 AC 33 C4 6A 30 6E 6A 0E FD 9E 5E 60 9F 4C 2D 
31 93 53 AE A1 B6 D9 25 9A 3C 9C 9A 71 0D C6 CD 2F D2 81 13 C4 AE 78 30 6E E4 3A 3C 33 8E 8D D0 
89 25 D3 F8 D8 08 EF D4 32 7E 06 8E E1 3B EB 67 79 7F 74 3B E8 23 27 21 A3 E7 58 48 3B AC 5A BC 
41 D7 A9 4D 08 0A B5 05 76 62 C7 92 8D 7D AF 2A 9B D7 18 76 13 6F A2 0D AB 92 DA 3D B2 88 5E 2E 
93 69 70 4A 48 59 DD 10 B4 14 A1 2D FC 20 CF EC 6B 0A 3B CE 30 B3 36 E8 7A F4 F6 2D 7D 3D 88 F4 
97 12 B3 B2 C4 FB 77 6D EC E9 D9 4A EE 35 D0 B5 A8 9B 10 68 30 EE 08 75 77 6C 64 64 F4 3C 01 9D 
7C 09 23 08 F4 D1 73 F0 2A 22 7C 1C 3B 5B 13 CE 51 F9 B1 8F 74 23 EE 2F 8C EA A8 7B 15 6E 9C A3 
2E F9 A5 09 D2 47 BF 46 1D 27 83 71 A5 FA E3 6F 4F 34 52 28 A6 5F 3A 41 40 47 3F AF C5 6C 30 AE 
AB AB 51 0B 12 45 65 50 8A 42 70 56 03 D4 F8 CB 16 19 22 E8 59 C5 FA 4A B2 E7 75 22 00 34 B0 DC 
DF 75 23 FA A3 EE 0F 1E 4C 4F 3F 69 7F 34 F5 A4 7D 72 7A 7A DE 15 D2 A7 26 E1 BD CF E6 E7 EF 2D 
4D D3 07 50 F0 9F C2 A0 CF C0 C9 80 8D F7 30 46 DD CF C2 B3 A3 E3 C7 4E 79 5A 32 A1 50 7E 77 64 
FC D8 39 F8 11 3F 4D 66 64 74 FC E3 8F 8F 8D BE 73 1E E9 0C 7D FA 82 3F 93 C5 9A AA A1 E1 5A 6C 
C9 F4 CA 56 3C 77 64 5B DF AE 5D BD 78 2A 28 EF 59 F2 94 81 0E 39 8E C5 E9 A9 39 BC 60 85 B6 6F 
A3 47 3E DE 87 24 9E E8 0F 9E 4A EA E5 5E FC B1 BB 77 ED D9 83 AD D7 B0 E5 1C 2E 1D 6A 19 B0 54 
E9 03 80 8E 42 FA C5 B1 F1 63 E7 49 D3 9D FF 12 F0 A8 FB 11 86 B9 7E EC D8 05 78 85 E7 FC EC 85 
F1 F1 71 E8 3F A2 07 52 28 A0 9F B8 04 AF 1D 3F 7E 98 D2 4F 4C 5C 83 68 03 D1 8E 40 3F 31 81 47 
DB DF 43 C4 1F A6 AF 1D 3F 01 DF 3F 7E FC D2 65 84 7C AC 40 4F C8 26 CE 8A 80 82 D9 00 64 70 94 
D2 5F 04 0E 05 74 2D 5B B9 86 32 E3 46 7B 6B 0A 69 B8 D5 FB 77 73 88 2E E8 CC E4 FC 03 7C BA 74 
3E 99 5E 84 F8 D6 54 BB 13 E4 99 79 6C D8 04 99 A5 69 72 3E 1D 98 83 0F E6 A6 A2 33 61 C6 7D 66 
DC E8 69 72 66 7F 74 7D F4 22 47 CE A1 51 6C C9 34 7A 9E FC 1D CE 38 2C 99 3E D4 43 A8 FF 78 7C 
6C 6C 0C 9D 8A FE 9B EE 70 A0 BE B8 8D 9C F2 9B B7 91 69 DF 64 F9 1A E2 7C 95 D6 A9 C6 CA C0 81 
80 BE 2E 84 0C 33 9B C9 62 9E 6D 1B B1 27 13 EA AF 90 E9 80 15 E6 92 FA FA 75 01 E7 BA 8F 9F A3 
F0 AB EF 9E 24 7F 7C EC 72 8B 27 CC 8C 5D C0 FD 76 78 91 37 AF 45 3D 79 1D 87 AA AC 5A 44 7F 1B 
21 8D 74 F9 F0 89 13 87 2F 43 3D 6C C3 13 66 DE 3F F1 F6 8F F5 35 13 E8 01 7E FA 7D 32 61 06 5A 
0E 87 30 37 2E 3A 13 66 CA 40 BD A5 00 B1 2D 32 F4 E3 77 1E 32 F8 9D CA 16 02 E8 A2 F4 FC 84 06 
D8 40 76 91 65 C8 97 A5 35 24 F8 9F 69 17 25 D0 67 1F 3C 9E C1 1D F1 87 33 B3 4B 0F 1E DC BF 3D 
3B FB F0 01 D6 7D 57 27 7C 66 F6 F1 83 07 0F 9F CC CE DE C7 4F 3C 9E 7D B0 34 73 67 E6 E1 FD 40 
6D F7 70 E6 BA 8F 9E 3C 77 EE 1C EA 16 8E 5C 3D 3F C2 53 8D CD D5 46 AF F3 A5 7C 9D EB E7 4E 9F 
43 FF E1 47 23 27 CF 39 CF D1 E5 53 60 2D 36 9B 45 8F CF 7F 66 73 8F 63 3D FA D6 AD 3B 5E 8E 00 
E6 40 8A 25 E8 1E 59 60 AD 6D BE B3 C0 B2 9B 7B F1 A7 26 57 B7 AD DD 64 00 92 6D A4 74 03 8D DE 
19 66 BC A6 C0 8E 1E 3D 7F EE DC D5 91 11 FE 8F 8F FF E2 A7 AF 23 B6 0F E1 52 C7 97 30 76 F2 DC 
E9 F3 47 DD 03 7A B4 E7 BA 4F 5C 7A F7 DD F7 F1 AC B7 13 87 DF 7D F7 3D F4 FB F0 BB 97 D0 83 F7 
50 47 1D 87 F0 1F A3 B2 77 91 DE 9B 08 61 62 5C 34 40 17 1B 34 05 95 96 62 D2 58 17 75 25 CB 64 
39 89 FE A7 AC 86 32 D7 5D D4 D5 5A 32 64 DF 85 58 2E 97 07 5A 2B 13 AD B9 EE 73 04 D8 59 C4 F5 
CC DC DC 2C 86 7E 0E 6B 76 D6 E1 E2 70 87 14 39 9F 99 E1 5F 31 1B 70 34 2E AC D5 6B 23 28 4E 13 
84 1D E3 6E 63 EE A5 F6 93 6C 74 0C FD 67 DF 76 9D 67 DE A0 37 AA CC 66 95 96 EF 8E AF DF F4 C2 
B6 6E EC BC B6 63 D3 AA 25 93 8A 15 E8 16 E9 9A 02 D5 A0 FB ED B5 B5 F9 19 05 D5 3E EE B8 EB 5E 
D9 B0 11 31 8E 28 DF B8 E5 15 CF E7 03 2E 6A C1 7F EE B1 65 5F C2 21 7B A9 AB 8E E7 AB A2 BC 7A 
ED C7 27 26 26 EC B1 7A 82 87 99 3C 3A 81 7A EE FC 23 B4 31 31 11 12 E6 51 01 BD 19 C1 98 02 33 
EC 38 76 C9 E5 81 96 97 86 B6 7A AD 2B 2D 27 84 95 70 D1 04 DD 8F 66 EF 3F E2 B5 18 78 7C 3D 22 
D0 57 6D F5 1A CD 22 39 86 DD E8 F5 9B 37 6C D9 B2 69 73 E7 2A F9 19 C2 D8 81 4E 15 E5 E4 54 D9 
AC A5 4E D9 2A 8A 73 93 5B 7C 4E 96 65 5F DE B0 E3 85 17 76 6C 78 D9 FB F2 F6 B5 AE 5E 0B E5 76 
18 C1 33 E2 0A 2B 07 3D D0 32 55 71 83 26 44 4F A6 10 2D 99 BA 42 B6 78 0A 19 F4 9F 87 95 78 E2 
F6 2D BB C2 79 6D C8 A0 47 25 ED 81 EF 65 AA B1 D4 D3 E7 A6 4A A4 C3 6E 6E CB 4B 85 C4 13 BE E5 
D3 92 C9 21 51 88 E6 A7 6E A0 67 45 27 67 DC 6A A7 92 42 1D 71 A4 B0 5E 7A FB F6 8D D0 8E 4D 12 
95 54 52 87 96 A5 92 8A B5 62 06 BA 4E B7 8C 5C 1F 45 41 F6 11 FD 54 52 21 67 87 8C 7D 2A A9 B7 
63 9E 4A CA 09 7A 94 92 43 66 06 3A 66 77 FD 2A BC 90 1E BE 6E FF 3C 54 AB 16 C9 4F 57 27 39 64 
AC 15 2B D0 59 75 7D F9 20 A7 77 89 D3 F7 D7 D6 6B 23 C8 EB 2E F9 49 14 DA EE 21 27 87 DC D9 1A 
7A 93 3B 5A 9C 1F 16 05 3F 2E 5E 09 C1 53 CC 84 C0 A5 C8 75 EE 67 AD 69 8E 58 21 E7 86 C4 E9 9E 
FF ED 56 4C F5 F3 5F 84 9C D8 BD F2 27 3F 3C 12 A9 DE F1 08 E8 71 0D 3A 1E 75 AF 6F AA 70 8D BA 
0F 0C D5 45 68 E0 F0 D6 3B EF 44 FE 0D 84 9C EE 19 FC AF C3 3F 8E AD 0E 87 9E EE 19 88 22 07 73 
4D A2 7B 00 AE 0C 71 C0 CD BF 44 2B B2 7E F9 D5 BF FE 22 96 FA D5 0A 2C 7A 32 7F FA A3 BF 8B 50 
3F F1 0C 27 2B 02 9D 66 ED EB 3D D9 88 66 CC C5 0C 74 99 C1 E0 31 EA 3E 50 23 CD 36 E4 45 E4 D4 
F2 D6 0F A2 FC 05 04 96 FC EF 4F BC 7D 22 66 7A 7B 45 06 0E 20 C0 ED EC 10 D5 F5 35 7B C3 3C 43 
5A 11 E8 35 FF 69 D7 6B AA 48 96 AF C6 32 A2 7B D9 26 E7 85 1E D1 69 CE 97 53 CB D7 A1 48 4D A0 
56 60 16 B5 62 C7 A8 A8 2A 4B 24 8E 48 A2 15 9A 2C FE EA 97 31 D4 AF 56 62 B2 08 0E FE F4 27 91 
E9 07 3F 0D 6A B2 A8 A3 59 96 F6 49 C3 F3 AF 65 64 13 29 F3 23 49 48 11 35 D0 8D 2F BF C2 EB 65 
9F 73 75 C9 84 99 1A 8F 09 33 A9 01 40 D7 79 0C D4 31 A6 F2 F2 72 EF 99 71 F8 1B F8 41 A4 5F C0 
4A 9A 97 3B FF D7 3F FE 43 EC F4 8F FF BC 22 50 24 F2 08 C1 EC F2 B0 4A CB 14 47 DC 17 58 B3 02 
DB E4 9D 2F FE DB CF 49 D7 39 56 FF FF 7B E8 B6 C9 E0 A7 3F 8C B8 8B F8 C3 43 01 6D 93 75 ED 9B 
37 BC 80 6F 28 FB 32 5F 5B FF 9F 49 65 44 06 69 28 A0 EB 3C 15 7D D0 37 BF 96 AE C0 CA 29 6B C1 
0F 69 5A A7 A3 DD 6A 2C 33 59 0C 60 9B CC 4F 1F D8 B0 79 BD BD 53 C2 6A B5 4D D6 52 4A E7 0D FA 
0F 22 FD 06 50 27 3F F4 B6 7B D6 3F C4 B6 93 7E F8 ED 15 B4 DD B3 9A 23 05 73 CD 1A B7 B1 38 20 
8E 82 83 43 B3 38 E4 C3 FF F6 CF F1 FD B5 DB 31 FA 9F 8C BA BF 18 E2 A1 ED 8C CA 6D DC 23 47 DC 
F7 E9 05 BA 6E F3 8E 6D BD F6 29 62 CF 2F 23 E2 F9 BE BD AF ED D9 BD E7 B5 BD 7B 43 C9 25 C7 18 
3D E5 BC 72 44 00 3A EB 71 4C A6 DD 19 49 49 D9 49 49 49 BF 96 A1 43 7F 7E C3 86 4D 9B 36 6C 72 
5D 82 56 60 9B BC 7E C3 46 32 21 70 DB 0B BC 23 13 A4 CA ED 87 EB 01 FA CE 9F 46 C1 43 E3 C8 91 
90 63 FA DF 87 3A 63 26 6A A3 EE 3F 0E 39 EA 64 46 E1 76 58 F3 1A 57 E6 A7 28 DD 47 0F D9 4F F5 
97 31 B7 64 BA F5 8B 9B A1 1D 9A E4 47 AB 73 1F 5D 87 C7 D6 48 63 BD 73 03 9E F4 4D 96 B4 F4 F6 
6D 5B 96 75 82 FD D3 97 5F 7E F1 25 D6 7F 87 30 1A C7 0E 37 BA FC 0D 87 1A 87 8C 0E C2 C2 07 FD 
BF DA F5 EE 31 7D F3 9E EC 06 A2 8C 42 9C CD B5 0C 3D CA 56 6C F6 00 DD 6B 99 6A B2 4F D0 E9 97 
B7 B9 A6 F8 6F DC 84 2B E8 CB 29 86 4C 17 F4 00 FD AD E8 DC 47 FF E9 B2 AF D6 B7 BE 86 FB E8 87 
FF 39 C4 63 8B 8E 85 52 73 A2 F3 C2 22 8F 0E E8 A1 E6 8C DB 19 4B 2B 55 3B E8 3F 0F 75 66 5C A4 
56 AA BC 96 CD 8C 1B 28 AE E5 74 4D 46 14 83 37 F4 F6 92 65 5C 3C EA DD DE 59 DD 75 7F FA F2 2B 
AC 2F BF FC 53 28 A0 5B 07 87 DD FE 95 1A AD 7C 56 47 2E 6C D0 FF BF 2F AC 54 29 BF 13 9C 51 59 
B7 FE 8B CF 7B FB FA 7A 3F FF FC F3 05 F4 76 3B 32 50 7C 37 34 B8 81 2E 33 64 14 0D 35 B9 46 DD 
4B DB AA B3 33 96 8F BA EB 5E F6 58 B4 47 56 A9 EA 86 54 2A 73 B1 DA 7B F5 5A 54 BE 81 F8 70 6A 
09 38 33 2E 64 30 DD E6 BA C7 D8 7B ED DF 63 EF BD 16 FA 5C F7 D5 01 5D AD AD 51 57 D4 0C 40 7A 
73 5F 2F 3A DF 7B F7 DA 17 66 6F ED F1 5A BF C6 FC E9 4B BB 42 02 DD 52 D1 E4 26 CB 80 59 53 88 
54 67 0A 3F A2 7F 61 B5 A9 EA C8 4E D4 F8 1D DA F9 E3 41 57 9E 3F A1 B0 3C D9 DD D7 B7 75 EB 1F 
1E 39 0F C0 82 40 37 0F 57 0C 3A 53 49 0D 34 6A B2 33 D2 96 8D DC BF C2 AF 52 ED DB BB B7 AF 87 
7C 6C 72 AD 30 5A 6D 96 65 06 0E 51 F9 06 A2 3F D7 FD EB 00 3D 0A F3 65 12 57 64 C9 24 06 21 CC 
AB 8D 07 4B A6 D5 F2 5E D3 A9 87 60 7F 71 95 11 AE 7F 01 73 BE 77 BF A8 32 4B BC BF 0F 2F CD DE 
E1 39 22 47 AF 0C 74 5B 85 9B 10 E8 AA 34 9C 18 46 AA 8E 00 74 9B B5 45 4A 76 82 F3 64 C0 4E 57 
0B 03 3D EA E0 A9 77 F5 D1 D9 B6 92 92 26 47 66 0A 92 9D 82 6B D4 96 98 BC 23 3A 47 2C E7 FA 76 
EF 13 8B F7 BD DA 87 33 CC EC C0 8B FD FB 8B 8B 4D 50 B0 64 F2 AB E0 A0 67 FA CD 03 B3 32 D0 E5 
24 13 A4 58 04 0B E5 89 A2 4A 89 C4 6F 62 C8 88 41 9F 23 19 64 66 C9 1A D4 79 92 E5 79 66 6A 7E 
DE 7D A1 1A 59 A6 EA 48 2E 31 87 AD 9A EC CB 56 E7 F8 87 58 E8 35 53 3E 67 C3 87 BD 7A 6D 64 74 
7C 7C 74 84 A4 25 23 BF 47 C6 9D A5 EE 75 46 47 3C 5E B5 DC C0 C1 08 E9 C6 7E 56 B7 69 2B 8A E3 
7B ED 7F 29 E5 AE 6D 3D BD 5B 5F F1 40 82 8F E8 5F E1 FF C3 01 BD 58 56 87 24 8B 24 A2 DB 6C 45 
64 27 1A F7 88 FE A5 0B F4 AF DC 41 0F 51 2F F7 F4 F2 56 2D 58 86 5D 1B 7B 7A 7B 5F 86 F4 BA 92 
C6 C1 80 E9 9E 7D 7F 01 E4 4F 6D 2F 75 68 D4 D3 91 29 CA A0 DB 97 A8 92 65 A8 13 C7 D1 AF 13 13 
C7 79 4F 26 FE 19 F4 93 58 35 C5 6C 99 6A A2 28 93 CC A4 A9 D4 0E A1 DF 09 12 49 6B 80 19 6F 21 
80 DE A5 A9 C7 6B D7 12 D2 98 24 51 A5 C1 AC 56 B7 B4 AE 92 25 D3 EC 83 05 04 F5 EC C3 C9 D9 3B 
53 8F 27 17 EF DD 9A 99 99 39 30 B9 F0 D0 95 1F 0A 3D 87 F4 80 47 7D F6 C1 E2 D2 EC D2 24 D1 E2 
BD B9 39 F4 10 F3 3D B5 B4 B0 B8 E0 33 C3 7B B8 11 7D FC C8 99 8B 1F 9D 3A 3A 36 76 EE E2 C5 8B 
67 4E 8E 8E 5C B8 78 04 9D 56 23 67 2F 5E 3C EB 5C 86 7E E1 CC C5 33 47 3C F3 1E 2C 5B BD C6 0C 
37 72 34 6C DF 82 4F 78 25 00 FB FE FA AF D1 33 FB 7B 70 16 58 8F 14 4D 38 A2 7F 15 41 44 C7 C1 
58 23 8B 28 A2 DB 70 96 38 B4 13 47 44 77 81 AE 5B 16 D1 75 1C 45 31 9E 37 F9 58 3D A5 F7 3A 4C 
DD 86 AD 3D DB B0 E5 1C 78 0E 4F 69 D8 DF DD D3 D3 B7 81 E6 6A 71 76 9E DA 40 A9 A4 0E 1D 1D 27 
7F EA EB 63 23 E7 F1 17 70 61 74 E4 E4 C5 93 23 87 C6 46 4F A1 47 23 0E BA 47 8E 9D 3A E3 B9 20 
3D AA 7D F4 13 EF 7E 80 73 4E 5C BA F6 DE 89 13 6F 5F 6B BB 76 69 E2 FD FE 7E D3 B5 6B A6 9A F7 
3E A8 C2 CF 7C F0 C1 F1 0F 4C 6D 6D D7 DE 3B 1E 23 D0 C5 D9 EA 0C 9C 5D 26 89 91 26 74 49 EA D4 
EA 5A 83 FF D0 1E 4A 2A A9 12 0E 27 B1 68 1D 36 65 75 A5 A1 66 5A A9 8E 6B F0 4B 7A 44 A0 4F 2D 
30 38 30 DF 83 73 53 F7 E1 A3 05 7A 71 E6 49 27 F3 48 07 5D 79 65 E6 1E C0 85 85 47 34 31 61 9B 
99 65 E1 81 F9 A5 C5 47 8B B0 7D F1 D1 BD A9 79 16 2E 60 53 C6 87 B0 63 81 A6 67 7D C4 F4 30 23 
FA E8 19 C8 DE BD C2 E8 4F 8E 9F 85 67 CE 7C 08 CF 8F 9F 87 D7 47 C6 CE 43 FA EE 15 9A E6 2D 03 
C6 CE 41 FD 15 48 79 66 32 5A 96 D7 BD AA 56 5B 5F 03 D7 6F 43 2D D8 3D 12 90 B1 F0 E6 1B AF 27 
80 4C 1C D2 77 78 DC 46 73 F5 D1 57 1E D1 2B 70 D3 5D 86 94 16 69 D3 1D EF 84 6F BA 2F 8F E8 1E 
A0 53 AA 94 94 12 8B D5 25 CB 80 39 2D C5 7B 3D 3A 9F D7 5D 0C 9E FB 9B EF 7F FF F5 6F 03 F9 5E 
E2 BD A6 2F A7 83 39 B5 E0 CC 7D CC 95 BB 2C 73 61 F4 14 F9 02 CE 8D 5F C5 96 4C 57 19 FC 05 38 
32 F1 8E 9C FC 18 B2 E3 AB 17 D1 27 4C 7A 92 05 16 5B 31 B1 C6 6B 1C BC F4 FE E5 A1 CB F0 72 E3 
E5 F7 DE 87 EF 62 23 87 77 8F 5F 66 AE 5D B3 C0 A1 18 81 6E F7 5E 4B 28 84 95 F2 6C 4A 57 D1 C8 
C0 C2 48 52 49 F1 4E 2D A2 6C 3A 35 33 1D D6 B6 02 90 C4 59 FD 65 8F 8E 14 F4 76 D4 76 9F 42 A0 
CF 77 3C FA 6C FE C9 FD 3B 4F EE 4F 4D DF 6A EF 74 42 8B 40 9F 9E 9F BE D3 C1 DE 9A 41 44 B3 93 
9D 33 B8 2D CF DE FB 6C 7E 6A F6 31 33 D9 8E 57 B1 3E EA 98 9E 7E C2 1C F0 61 E6 10 5E 44 1F 3D 
0B 4F A1 16 E3 F8 F9 EB A3 67 99 63 E3 A3 77 3F 44 8C 5F 1F BB 0E 3F C6 D6 A9 1F 42 BE 19 7F E1 
EA B1 63 E7 E1 29 F7 C6 E3 F2 74 CF 55 14 67 D2 D2 EB 7B BB B7 75 BF 0A 9E 7B FD CD 37 FC 38 B5 
44 12 D1 2B AC C6 01 F2 7B 58 1F 01 E8 03 54 D3 30 DE C7 30 C9 D6 D6 E9 EC 4A D8 23 FA 57 1E A0 
5B A4 CD 05 AA C1 C1 21 C7 A0 FB 50 53 8D 74 79 86 19 DE A9 45 02 FE EA 8D 37 DE FC EE F7 00 D8 
8D 9D 5A 3A 19 6D BF 0E B6 95 04 48 F7 7C 68 F4 34 3C 3B 7A 0C 7D 01 27 D1 16 FA 7D 91 3D 84 93 
43 8E D0 1F A2 2F 60 F4 2E 3C CA E7 F8 62 2E 9E 09 13 F4 95 7A AF 99 68 D4 5E 37 9A 8E E3 14 91 
97 D0 E6 F1 21 6E 62 C2 D2 36 71 FC 72 0D 2A 7B 3F 94 24 B0 D1 F4 5E AB 51 03 40 71 A8 4B 24 29 
81 65 FE 5A EF A1 5B 32 99 39 89 44 0B 13 F0 9E 65 B0 C1 DF FE 22 05 7D 7A 6A 6A FA 01 06 BD 03 
F5 B3 71 3B 1E C1 ED 66 A9 86 40 C7 31 9F F8 31 4D 4D 2E 3E 81 F7 E7 EE CC CC B0 07 E6 F0 8B 1F 
3D 81 0F E6 66 96 F0 73 F3 8B 1D E1 37 DD 3D 23 FA C8 75 FA 0C EF 10 80 90 A7 47 0F 8D 9F D1 1F 
41 A0 63 47 20 9C F2 F9 AA 3D DB F0 C8 C8 A1 91 77 E0 D9 80 A0 AB 87 10 26 6D 03 EB B7 F6 62 EF 
B5 6F 13 EF B5 BF 41 A0 2F F3 5E 8B A4 8F 5E 61 A5 1C 4F 44 00 7A 93 47 C3 3B 48 44 F7 31 D7 DD 
87 81 83 D3 7B 0D 7D EC 37 9C 96 4C 50 5F 55 6C AE 0A 64 E0 30 72 44 FF 11 E9 92 8F 91 14 BC 87 
46 4F 31 C4 92 E9 34 F9 CB 8F 5D 70 84 F4 AB C7 CE 32 AB 19 D1 5D A0 33 24 DD 33 7B 18 C7 F7 F7 
48 7B 1E 7E F0 2E BC 74 62 E2 72 23 49 EB 4E C7 2E 0B AC 08 45 60 98 D3 AA 80 52 EC 8F A8 D4 15 
57 46 08 BA 58 64 2C 97 48 28 13 CE 05 2B CA D6 F9 75 6A 89 C8 7B 6D 6A 81 C6 89 1E 27 49 D3 7D 
F1 3E 3F 0A 37 F3 84 5D 70 59 2B 12 D0 51 8B 7E 72 7E 66 49 77 FF B3 8E C9 29 3B E8 E4 E1 A3 C5 
B9 D9 C7 10 B5 EB D1 25 C3 47 8A F7 F0 40 C7 8E 40 23 E3 C7 8E 8D 8F 90 88 3E FE E1 C7 A3 18 F4 
8F AF F0 C9 20 D9 33 0E B8 51 B1 A7 F5 D7 32 A7 16 F4 43 6F A2 3A 7A 50 D3 DD EE A6 FA FD FD 00 
E0 A6 FB 0B CB 22 7A B8 A3 EE 08 74 C7 7D AD 48 40 A7 DC 31 ED 24 2D 0C B7 88 BE 1C 74 8F E4 90 
A5 3E 0C 1C 74 C4 4D 75 77 2B F8 EB 37 51 48 FF 1B 20 C1 11 7D C7 7A F4 17 69 6B 33 5A 02 79 AF 
11 47 35 F2 05 8C 91 88 7E F7 C3 51 0C FA 47 1F 5E 77 B7 64 3A 84 BF 9E 98 80 7E 82 37 70 60 2E 
9D B0 83 8E 1E 40 FA 83 E3 6F F3 A0 9F 78 0F 27 87 8D 19 E8 AD C5 94 B2 B5 88 49 22 96 4C 35 03 
91 3A B5 74 95 C1 86 2E 87 25 93 81 F1 EB BD 96 A8 4C CE 55 00 71 7E 7E 12 C8 C8 AF 56 82 86 FC 
E4 AE 4C 45 7E 0E 90 A7 E6 37 80 E6 BC FC 0C 90 94 9F 52 00 D2 AB 7D 58 32 4D 2D D8 4F 8A B9 99 
D9 87 ED B0 83 18 AF CC 1F 80 33 EE 4D 77 0C FA AD 8E C5 F9 B9 7B EC F4 FC 3D DD EC 0C 0F FA DC 
03 7A 7A FE 01 BC 35 F5 10 7B 35 4D DD 63 97 7C 81 9E 99 93 9B 03 12 F2 F3 CB 80 32 2F D7 80 0E 
31 B7 00 1D 62 75 26 48 CE 4D 06 99 79 B9 0D A0 00 95 EF 74 07 7D EC 14 6A A7 9F BC CB 71 57 48 
1F FD 23 0E 5E 20 A0 5F F9 98 80 FE 8E DE 11 C5 47 0E E9 3F 0E 3C 18 37 58 AF 35 99 D5 B0 73 47 
6F F7 C6 BD 62 90 F0 BD EF 7C E7 5B 00 EC 43 F1 BD 77 83 C7 60 5C 44 7D F4 55 00 3D C8 A8 7B 68 
06 0E 2C EE A3 EF DA 87 BA 2C DF FF 2E EA A3 8B 89 3F 3A 7F 5B 51 A7 0E 30 18 37 76 0E B5 9D AE 
7F CC EA 3F C4 4D F7 33 67 38 78 75 D4 65 C9 74 E8 90 DD 92 09 F7 B1 BC 40 3F FA A3 F4 FC 9C D6 
84 E4 FC 60 67 E4 A5 E0 9C 2F B3 64 7A 97 76 81 7E E2 C7 3A 1D 76 77 70 80 FE 6E 08 06 0E 87 F1 
99 97 9A E5 76 46 E6 E7 26 F9 3A 23 03 83 2E EE B2 A9 5C 96 4C EA 88 BD D7 80 69 48 24 46 11 1D 
83 DE 95 AE F3 6B 08 11 61 44 6F FF 6C 7A FA 33 BE 79 3E 8D 50 47 B0 22 78 DD 2C D5 DC 22 FA DC 
E2 E2 E3 87 0F E0 BD 29 1E F4 A9 C9 47 8F 1F DE 87 F7 E6 F9 88 7E 2F 82 88 EE D9 47 47 E7 D9 85 
B1 77 CE 9D 3B C3 60 D0 2F 5E 3C 35 32 36 C6 47 74 42 B7 D3 68 71 64 F4 AE EE 88 C7 FD B5 E5 A3 
EE C3 6A F5 5A 0E D2 F8 F6 5A F7 1E 09 00 DF 7E 0E FD DD 5F C3 DE 6B 2F 7B 50 41 BB 22 68 20 D0 
75 FC 48 37 6B 89 45 44 0F 30 EA 1E E2 5C F7 4D 5B 7B 7A 7A F6 00 D0 FA AD 6F 3D 07 24 A8 E5 DE 
B3 75 13 AD 6B AC AA AD 2A 2F 0E 04 FA 79 EC D6 70 FE F4 19 D2 5C 47 5F C0 91 D1 31 F7 88 AE 77 
34 A9 62 1B D1 DF 75 8F E8 D7 68 E6 DA D7 13 D1 E5 52 68 10 65 A9 58 12 D1 C5 15 6B 23 04 5D D4 
CC AA B2 12 25 26 3D 40 17 8E 56 29 4C F7 37 BA 17 85 C1 38 3C EA 8E BB E7 08 D9 FB B3 28 40 BB 
7B 32 D8 FB E8 A8 1F 3E BF C4 9F 3D 8F 78 D0 67 9E F0 0F 3B 50 39 EA B7 CF 4F 76 F8 70 72 08 AF 
E9 7E 15 9E 42 8D C6 F1 73 18 74 3C 18 37 72 88 80 7E 86 3E 34 42 FA E8 7C 73 7D 64 FC 0C B1 08 
0A 04 BA B1 5F AD 35 55 D0 F0 95 EE EE 9E 6D DD BB 49 32 A1 7D AF F5 A0 96 BB 97 3D 3A 13 D2 14 
D8 D2 2A 2D 52 89 BA C2 D8 14 8B 88 FE 55 C0 88 1E 82 81 C3 2B 1B C9 FD B5 2C 6C 77 D6 FA 2A B6 
9C EB 79 1E EA 2A D4 6A 75 49 20 D0 47 2E E8 CE E0 2F 80 B7 64 E2 BF 00 0C FA 29 32 48 32 76 12 
3A 2C B0 56 1B 74 3D C2 97 98 B2 10 4B A6 2A EE 84 5B 1F FD FD 0F 5C 7D F4 0F E8 C3 B1 03 3D A1 
C4 08 12 E5 29 50 81 42 6F 57 22 6D 8E B0 8F 9E 50 C7 76 89 13 E5 79 B0 50 22 01 65 4C DB 2A 8F 
BA 4F DD 7E 38 35 3F 7D 1F 3E 9C 7F 48 8C 97 9C C1 79 0A 8F BA CF DF 7A C4 3E 99 3F D0 39 45 A2 
FF E3 59 0C 3A 0A E1 B3 E8 E1 7D F4 B0 63 F2 B3 F9 27 BA 03 E1 83 EE 35 EA 3E FE 11 3C 37 3E 7E 
8C 80 4E 8F DA 63 CC 75 74 AE 9D 19 1F 1F 3F A2 D7 1F E3 E3 CE 47 DC 91 63 E3 9E AE BD DE A0 5B 
B5 6A B5 B6 91 86 EC A6 3E 3C E5 7B D7 9E 57 5F DD B3 6B 23 F6 58 DC EC C5 04 5E D4 F2 05 5E D6 
F2 A7 00 19 20 D4 A9 69 52 A9 34 BF CE 44 AD 36 E8 7C 1F FD 4B C7 CC 38 72 0D FA CA 35 AA 10 A2 
81 03 8D 3F F6 C6 EE BD AF EE DF FF EA 6B DD D8 63 71 83 A3 8A 29 D0 7D 74 D4 90 3A 8D BE 00 1E 
F4 51 9E 7D 14 E4 AF C3 8B A3 E3 E3 63 57 58 C7 4C 86 63 67 D9 63 5E B6 C9 21 9E 8B 21 81 8E EF 
9F 1D 9F B8 A6 3B 31 31 64 39 3E 71 42 8F FD D0 79 D0 8F 5F BE 3C 71 DC 78 F9 C4 D7 30 EA 2E 37 
D0 D5 72 C4 28 1C 12 03 20 57 3B B3 BC 87 05 7A 09 97 D5 B5 B6 1F B3 2D D2 42 6B 55 BF 8E CE 5E 
AD FB E8 2C 7F 1F 7D EA 09 EC 9C 5C 84 1D B3 8F 75 CC 02 D2 63 B7 51 F7 C9 85 47 0C C2 79 B6 73 
61 8E 77 4B 9E 9A A1 0F 4C 21 BC F1 C3 59 B8 80 DA FA 93 F7 DA A1 AF B9 71 E1 DD 47 1F 39 74 05 
5E F9 E8 2E 0B 71 D3 7D CC 01 FA C8 D8 19 F8 E1 47 17 19 FB A0 FB E8 29 78 F7 CC 47 1F 9D 09 38 
EA EE 5C 2E DE F9 42 1F 6A C5 6E DC C8 FF DF DD B7 C1 6B 4D 7A FB 96 5D BB F6 EE DD BB AB AF 6F 
47 80 65 AA FD FC DC B5 A2 FE 58 44 F4 AF F8 26 06 6E BA 4F 7E FE F9 D6 DE CF FF D0 E1 7C DA 92 
96 58 50 34 34 E8 5A 41 D7 D4 56 6D 28 48 59 B6 A8 C5 88 3F F6 B6 8D DD BB 76 75 63 4F A6 BE 17 
1C 56 54 3A 63 40 4B A6 D1 BB F0 C3 8B 1F E3 C1 91 53 F6 2F 80 DC 47 3F 05 A9 8B 17 39 E7 7D F4 
D3 A7 EE EA 4E 9D 5A 35 D0 51 C3 1C 5E BE 66 44 CD F6 13 EF C3 9A 0F 2C D8 60 8D 07 9D 98 31 A1 
50 FF 3E B9 8F 8E 6A 85 B0 B3 68 DD 47 97 C8 E8 0C FE 46 98 5E AD A5 60 5D 24 F7 D1 E5 2D DA AC 
24 98 4C 26 BA 03 45 7F C5 DA 96 CC D5 9A 19 77 6F 72 96 98 34 CC CE 2D 4D 76 74 3C 98 9E 7D BC 
F8 E8 51 47 47 C7 43 C7 8C 99 D9 87 E8 E1 A3 07 F3 B3 33 8F 17 1F F3 43 75 93 33 33 93 0F E6 96 
16 1F DA 1F DE 9A 7F D8 D1 71 60 CE D7 1C D8 30 67 C6 8D 1C BB F0 F1 95 BB A7 0E 8D 8D 9D E6 47 
DB 46 AE 5E 41 27 E2 F8 C9 8B 57 EE 3A 66 C6 8D 9D BA 72 F7 CA 95 2B 77 03 8E BA BB 64 D9 D2 D7 
DB C3 AB BB D7 6B 24 0E C7 CC B4 FF C9 AF FF FE 24 25 C0 44 53 13 3F D3 35 06 A0 3F FA E2 0F 7F 
F8 FC F3 CF FF F0 87 3F FC 37 1E 54 4B CA C8 C8 F8 9F E9 AE 56 88 BE 5E 26 53 BB AF 88 A7 6C B5 
75 32 D5 F2 65 AA EB 77 A0 98 8E 50 C7 98 77 E3 7B 6B 6E 0A 34 05 F6 18 F9 53 5F 1F 1B 3B C7 FF 
81 47 2E 5C 39 39 72 68 FC 3A 2A 75 CE 8C 1B F9 F8 C3 BB 77 AF DC BD 1E 06 E8 A1 AD 5E 3B 31 F1 
EE 65 EB 35 EC AB 36 71 E9 B2 E5 1A F1 66 BA 74 19 E1 FE E3 6B 1F E0 AE 79 55 CD F1 AA CB 97 2F 
B7 5D 8A D5 CC 38 51 C3 70 86 64 B8 84 80 D9 2A AE AA 18 AA 35 64 FA 05 33 94 B9 EE 09 99 59 85 
54 01 9F A0 0E 67 99 5B C5 B9 EE 64 D8 0D CF 75 C7 53 D8 A7 EE 38 66 B2 CF 3A 34 E3 9C EB 3E 63 
9F 02 3F 85 6A A1 4D E7 C3 79 E7 34 F9 68 45 F4 43 AE 29 D6 63 F6 3E A0 7D AE FB B8 DB 5C 77 5C 
05 C9 23 A0 04 30 70 E8 DC D0 D3 B7 B5 17 A9 AF 6F DB E6 65 51 7B FD 7F 2A 33 92 92 D0 7F 9F 54 
07 02 BD 5A 2A 93 CA F2 62 D0 74 DF BC 77 B7 22 3D 5D B1 E7 B5 3D 2F 20 D0 5F 58 D3 AC 54 8A 33 
36 39 9F A6 A9 D2 52 4E 47 BB 4B 6F 2B B5 F9 38 E4 F5 5B 7A FB F8 F5 E8 7D 7D 5B 3C AD 25 03 CF 
75 5F F6 05 8C B8 95 F2 F2 F1 05 44 79 51 CB 84 63 26 FB 09 B4 C1 C3 7F 9C 8C C5 7D 5D 73 DD 81 
3C 89 CE E1 97 9A 89 11 C8 11 CE 75 47 CA 2A 51 85 E8 08 B1 3A AB D7 66 EE F3 7A E0 E3 9E D9 0A 
14 E3 D5 6B 81 40 D7 D1 CF 6F DA F2 C2 C6 8D 3B B6 6C 5E 0F 97 85 BE F5 7F 2B 0D 21 39 E4 70 7D 
2D 52 79 C9 E0 AA 47 F4 CD BB 33 48 66 AB 6C A5 06 42 E6 95 F2 72 F4 B6 55 61 59 3D 73 2F 6F D8 
81 0D 16 5F D8 B0 D9 AB BB F2 35 AE 5E 0B 7F 3D 7A F8 AB DE A2 01 3A 8A BB D2 1A 7F F7 BF C2 02 
3D B1 32 50 14 5F 7D D0 67 0F D8 F5 38 16 A0 AF 9A F7 9A A7 E8 CE E7 5F 79 E5 F9 CE E5 98 23 1C 
D0 13 44 AF AC 0F 90 4A 95 76 AC 0A 5D F5 DB 6B 9B 5F 2D 30 10 89 A4 2B 46 DB 5B ED CF 6F 46 7A 
65 D9 05 EC 1B E1 BD 16 3D 45 69 99 6A 57 08 2B 54 BD 40 0F E8 BD 16 B2 56 C9 7B 6D 6E 8A 57 44 
9C C7 DA 7B CD 7B 3D FA B2 53 3B 90 6B 91 67 9A C7 80 62 56 7D C2 CC FA 2A 73 3D 51 B1 3A B4 43 
0A 2C 9F 1F 4C F0 5E F3 A3 68 67 98 89 52 CE B8 90 53 49 FD 81 1E 69 63 00 00 20 00 49 44 41 54 
6B EC 73 C6 DD 0E D1 C2 21 73 95 72 C6 AD 92 56 7F 66 5C 2C F4 8C 79 AF 85 6E D5 12 1D EF 35 57 
CE B8 67 C1 7B 2D C4 AC F9 3B A3 E4 BD F6 96 DB 3E 63 09 BA E3 89 A8 2D 6A 89 85 3C D3 3D C7 D4 
7B 0D 64 C6 DC 7B ED ED C3 21 37 7D B3 A2 E3 BD E6 B6 C3 48 B3 BA E3 04 D2 21 27 81 05 92 7F 89 
B5 F7 DA BF 86 EC BD 96 F9 93 1F 1E 39 1A A1 8E C4 CC 7B 6D D9 32 55 8B 0D CB 1A 7E 72 48 BC 4C 
D5 62 B3 20 D9 7C 64 9D 5F 1D 79 82 5E 79 F4 9D 48 BF 81 23 21 27 81 C5 21 3D C6 0A 3D 09 2C CE 
E6 18 39 97 89 EE D9 A5 03 8D CE 87 26 51 E8 9C 23 D2 5F FC E5 2F FE 77 CC F4 8B 7F FD 55 88 A6 
C9 E4 D8 BE 5E EF B5 95 69 59 E2 89 FA BA 16 A4 BA FE 88 12 4F 14 17 E2 9D 14 9A 56 EF B8 3D E5 
ED BD F6 D3 D1 F1 88 34 FA 83 95 79 AF C5 34 9E AF CC 7B 2D 2B 52 EF 35 B1 97 F7 9A A4 35 AB 32 
92 7F AD 2B B4 72 DB FE ED 18 EA B9 95 B9 5D BD F5 4F 91 E9 E0 5B 9E FB 8B 19 E8 CE 54 52 11 26 
87 2C 92 BA 52 49 C5 42 DE 96 4C E2 1C 59 9D 26 7C D5 E5 36 AC EC 64 8C AD 56 E6 BD 96 19 11 96 
59 59 99 9E 60 CA 13 9B D7 44 A4 E6 C4 90 3B 1E 48 CF FD EF 3B 3F 8F A1 EE FC 62 05 E6 6B 6F FD 
E8 D0 3B 91 E9 C8 A1 1F 78 0C 57 2C 07 9D E3 6F AF 79 CF 8A 5B B9 DC 41 6F 6A AA 88 4E 72 C8 2B 
7C 72 48 59 54 86 D9 DD 45 B7 77 AE 5F DF D9 BE 6C 0E BF 17 E8 B2 88 07 09 74 FD A1 DB 06 3D D5 
92 88 22 05 33 31 D1 BD A9 DD 55 10 E9 70 1C EA 0B 84 6C EF 0E 9E BB 75 EB 76 0C 87 E3 6E DF BE 
F5 6F A1 5A 32 81 83 47 50 07 31 B2 81 A0 A3 47 DF F9 91 FB 2E BD 41 6F 7F 79 0B 6F C9 B4 E1 95 
48 51 47 A0 DB 53 BA A3 70 6E 1C 78 AA 23 3A B3 7E D3 0E F4 B9 7B 5F D8 F4 BC 03 75 6A 70 10 0F 
1F 7A 82 1E F9 FD 7A 24 2E E4 93 F1 69 96 24 71 4D 84 60 7A 0E 9E 45 C3 E2 09 ED 32 54 BB AB 9D 
FF 12 EB 51 F7 3B B7 7E 19 6A D7 E2 07 D1 19 75 77 EF 24 7A 81 6E DC D2 DB DB DD DB DD 8D 67 C1 
6E 8A C4 31 15 62 D0 9D CB C6 2A 2C C6 26 5B 54 22 BA 55 A5 71 A5 7B 8E 9A 98 4D 1B C9 C4 5F F4 
D9 7B EC 33 7F F5 E5 2D 2D E5 DE A9 A4 0A A8 20 3B 0A 4D 75 21 7E DF 4F B5 E4 D1 70 70 68 16 7F 
6D 96 4C 77 62 7E 1F FD 76 C8 96 4C 51 B9 8B EB 63 C2 0C CD 70 BC A7 19 F6 26 EA E6 57 77 74 F7 
6E 7D C1 12 D1 E9 CC 5A 88 7B 12 71 50 2A B5 96 5A 2C 43 EB D6 AE 5D DB B6 CE 18 C9 A8 FB 87 8D 
64 27 6D BE 66 AC 87 AD CE 2D 64 A6 3B 36 64 42 1F 7B 07 BE C0 71 25 43 3A 38 54 C2 79 82 9E 13 
9D F7 AB 09 F1 64 7C AA 25 8E CA 7D 74 D7 7D EF 58 5B 32 FD DB B3 67 C9 D4 64 1A 2C 37 97 22 D2 
3B 37 F6 62 CC 51 3C EF C1 A8 6F DD 12 82 67 AA 7F B1 94 DE 43 14 6D 5F 0F 1B 01 E8 43 8E 9D 44 
73 DE 0C BB 01 5B AF 6D DC D6 DD BD 8D 7C EC 0D E8 63 53 B5 E8 09 AE DC 2B DD 73 5E 74 DE D0 16 
EA C9 F8 34 2B 1A 01 78 45 96 4C 89 01 7C 1B 9C 8A 07 4B A6 55 9B EB AE 6E 51 97 9B 07 68 D8 4E 
4E F8 AD 7B 5F 32 18 5E C5 E6 6B DD BD 9B 02 E4 97 08 2A 9A 71 5F 37 C6 30 CE A4 34 91 4C 98 59 
85 FB E7 BA CD F8 63 F7 EC DA F3 D2 4B 7B 76 F5 E0 8F BD 01 7B 37 34 51 90 AD F2 02 3D 2D 3A EF 
68 0D F5 64 7C 9A 15 3B EF 35 31 7F 7F 5D 5E 95 86 48 17 75 75 05 BA DD FE 75 80 3E EF CB 95 25 
02 D0 7D AC 5E 1B 19 1B 1B E1 7F 91 DF 87 C6 DC 4B 9D 1A 0B 62 C9 A4 53 6B 4B FA 51 88 7C 05 C7 
F3 DE 57 13 50 B7 49 22 DF D3 8D 73 2A 19 A3 73 66 7B 2A 02 7F F4 10 72 52 AE 58 EB 77 6C 45 F1 
FC B5 7D 95 3B 77 B6 26 E2 0C 5A 5B B7 75 40 DA 54 5C 05 E1 00 23 80 EE 4F BE 22 BA B8 0B 89 BF 
BB EE 00 92 7F 28 72 FB B9 52 D0 C5 D9 E9 24 C3 64 03 4C 17 89 44 65 0A 45 76 80 1B F8 61 80 4E 
72 44 E0 E5 2A 53 78 05 FA 1D 77 E3 34 B2 1C 9D DF 42 85 64 2D 3A AA 33 33 C5 A7 89 9A B3 67 81 
7E 74 9F 2C 52 9F B1 3F 9C 22 BF E7 E6 11 FF CE 5D AF 08 F4 65 11 7D 6C EC C2 D5 AB 17 C6 46 46 
4E 5E 45 BF 0F 8D 1C BA 7E 95 60 8E 4B 5D EB A1 47 DE B9 7A E1 68 40 D0 21 A4 CC EB F8 16 2C EF 
4D 24 42 07 94 B5 1B 27 87 F4 36 4E 8E 8A 22 00 7D 35 0E 67 13 0E E8 AF 55 02 B0 9D FF D8 A8 F1 
8E 5A 32 9C C5 42 EC 9B 42 02 DD 36 50 8A 2F 89 5C 13 BE 53 41 0F A0 9F 54 53 53 93 D5 DF 7D 8B 
78 05 5D 6C 50 28 72 D2 D7 E0 B8 2B 47 40 36 64 89 12 0B 14 38 0F EC 9A F4 24 F4 B3 39 3D 7B 19 
A1 A1 A4 92 D2 32 78 CD AB 44 5D 21 4A 50 D6 E0 BF 5F 7D A2 5F D2 57 0E FA CC BD 87 33 77 66 0E 
2C CD CE 1E 58 9C BC 3D 73 67 61 71 C1 E1 D7 30 F3 78 72 72 71 72 1A 67 9D 79 BC F0 78 EA FE E2 
E4 C2 E4 E2 81 D9 27 0B 0F 30 CB D3 F7 0F 3C B9 83 9F EA 7C F2 60 72 71 F1 DE 93 03 A4 D7 7F FB 
C0 3D 9C 8B E2 C1 E2 E4 C3 D9 7B 78 59 EB 01 E7 22 F6 30 23 FA E8 D5 8F F1 A7 BE 78 1D 7B 33 31 
F0 CA 3B A3 E7 E0 F5 91 91 23 17 71 E9 99 EB 0E D2 C7 4E 41 FD F5 80 96 4C 90 A1 AC 7A 9C 48 AA 
B7 E7 85 BD 72 B0 73 F7 77 5E 37 00 20 DE 8A 3A EB 5B 22 BF 9D BE 5C 4F 17 E8 EC 86 BE 9E 6D BB 
F6 03 F0 AD D7 5F FF 2B 09 D8 D7 B7 AD A7 6F 0B AB 5B 67 AE 2F AA 2E 0F 29 A2 B7 91 39 30 1A 06 
16 82 74 F4 B0 09 A0 FE 7D 2E 2E 12 D7 FA 7E CB 78 05 5D 5E 08 59 0E 5A 93 BA 44 6B C8 ED CF 5A 
43 57 22 2C 96 27 76 25 C3 92 CA 44 51 12 2C 5E B6 AC 3C 64 A7 16 B1 92 6D 91 64 50 54 43 73 B3 
06 96 F8 5D 05 1B 06 E8 8F 1E CC DD 99 69 7F 38 3D B9 F0 E4 FE BD F9 03 F7 9E 4C 76 DA F3 3B CF 
3D 68 7F FC E4 40 3B CE D3 BE C0 2E 4C 3D 59 7A 4C DF 5F 5A 9A 7B C8 76 A2 90 7E 7B 12 92 94 CE 
53 F7 26 A7 16 17 9E 2C 3D 79 CC E2 0B C4 EC 63 86 99 9D 99 BD DF B1 F4 F8 C0 9D 8E FB B3 78 D7 
B3 11 45 F4 B1 AB F0 EE C9 23 EF 9C 3C 83 B3 C0 8E 8D 5C 60 3E 26 DE 6B 47 AE E8 AE 1E 3D 82 9E 
73 24 3D B9 CE DD FD 30 30 E8 6C 6D 4B 91 B9 02 AE C7 03 EE BB 01 D8 FD C6 9B 6F 7E DF 00 76 EE 
ED F1 36 70 88 92 9E 2E D0 3B 77 F4 F6 6C DC 93 00 BE F5 7D F4 B1 FF 0A 54 EE C1 06 0E 9D 90 61 
8D DA 62 4B 28 11 DD 04 14 46 1D 6D 4C C3 A9 D1 00 3A C1 AD 95 25 10 4A B3 D1 33 2D A0 C8 E7 5B 
C6 2D E8 75 B0 4B 94 64 B1 CA 13 07 75 8A 35 6B 72 E0 10 00 A6 52 91 38 AB 08 36 29 C5 F2 6A A8 
0C 2B A2 F3 96 4C 1A 5A 9E A9 82 86 2C B1 48 52 EC 63 47 E1 82 3E 83 40 9F 9A 9D ED 78 38 0D 1F 
CE CF A1 D6 F6 D4 DC 12 6D 27 73 EA 41 C7 CC EC F4 81 8E F9 99 A5 8E 87 1D 77 66 66 6F B1 8F E7 
66 E6 27 1F 74 3C 9C 9D 59 3A F0 98 07 BD FD C1 FC E2 81 F9 99 D9 C7 ED 18 F4 A9 85 03 8B F7 E7 
A6 3A 0E 4C CF 4E CD 3C BA 8F 76 DD B9 52 D0 BD 22 FA 18 F7 F1 28 6A B6 8F 8C 62 2B 90 D1 91 F1 
B3 DC 3B 08 74 14 D5 AF 8E 8F 8C 8C 9F 86 76 B8 C7 3F BA 78 2A 48 44 57 6B F5 54 BF 16 AE C7 69 
DD 5F 02 CF 7D E7 CD EF 62 CB 12 B0 67 99 25 53 94 F4 74 81 EE D3 92 E9 79 74 F9 33 99 F0 88 40 
70 D0 41 8A 63 AB 2E 5B 93 C5 B8 81 0E 65 C0 E7 E0 61 1C 83 9E 25 92 14 D2 19 79 30 47 22 16 03 
19 CC C8 D4 40 A5 A8 AB BF 1F A6 77 B5 16 73 CB F3 41 85 0C 7A 57 8D 09 80 8A 41 1C CA BB 1A 74 
75 7E 0D 1C 56 1E D1 17 EF 2D 2D 2D 75 3E 9C 7E D4 FE 64 76 96 B4 C5 1D A0 CF 3D E8 B8 8D 00 86 
B3 53 0F 16 67 3A EE CF CD 3C 61 11 E1 B7 DB 9F 1C 98 C4 59 E2 1E B3 4F B0 D5 62 FB EC DC E2 81 
E9 A9 29 02 FA CC 9D F6 A5 7B 8F 66 A6 EE C1 FB A8 5B FF E8 01 D9 75 44 11 1D 05 F4 73 A3 87 C6 
46 47 47 49 E2 F0 B1 63 1F 13 93 C5 F1 8B 14 36 F7 1B 39 C9 F0 4E 2D 63 57 75 D7 83 82 DE 88 3A 
96 FD A5 D8 64 B1 87 98 2C F2 A0 BF D6 B3 CD CB 64 31 4A 7A DA 40 DF EA CB 7B CD 58 AC A5 18 3A 
04 D0 4D C0 B9 C0 A6 2E 83 03 C5 EE A0 F7 03 9F 13 7B E2 18 74 90 00 AA B8 04 AD 11 E7 72 14 65 
B0 C5 A0 01 E6 64 29 D9 14 AE 25 0B 50 E5 CB 13 42 85 0A BA C8 00 AB E5 12 B6 84 58 32 25 D1 7E 
2D 99 56 EC D4 32 33 B3 D8 81 3A E2 F0 F1 DC ED 03 F0 11 CE EC 3A FF 68 61 DE 19 D1 6F CF CC 2C 
31 4B D3 8B F7 A6 17 16 E7 09 E8 88 FE E9 87 3C E2 F8 27 8A E0 F3 B3 93 1D 07 16 EE 2F 61 D0 E7 
EE 77 CE 2F D1 4B 33 D3 F7 18 FA FE 14 D9 B5 EE 71 64 A0 9F C6 8E 40 A7 CE 9E 3D 75 7D F4 2C 7D 
F5 FC 19 78 7A DC CD 92 E9 3A C7 83 3E 72 E5 CC B1 A0 A0 F7 63 EF 35 4B E7 46 D4 86 7D 2D 13 EC 
47 6D D8 EF 3C 07 2A FB 96 D9 26 47 49 4F 17 E8 ED 3B B0 6D 72 17 78 91 6F BA 67 BD 86 9B EE ED 
BA FE 16 55 BD D9 44 07 07 BD 18 18 21 57 6F 36 57 31 B0 4E 09 8B 00 67 71 81 DE 04 EA 7D BD 65 
69 A8 27 E3 D3 2C 1F A0 27 D4 C1 E4 1C 33 54 81 C1 1A DC B4 16 2B A9 7A 49 E2 90 16 A4 33 05 55 
83 40 04 AB C3 8F E8 AD 2A A3 52 2C E1 78 EF B5 6C FF A0 AF DC 7B 0D B5 AF A7 E7 E7 71 63 7C 7E 
69 B1 FD D6 CC FC BD 4E 87 9B 92 23 A2 CF CC B2 0F E7 1E B0 B7 66 09 E8 8B 07 50 E3 1E 45 69 02 
FA CC 93 CE C7 B3 B3 8B 93 0F EF 2F 91 88 3E B7 30 39 F7 84 C5 5E AB B7 EE C1 C7 8F 1E F2 BB 76 
82 1E 8E F7 DA 69 EC 91 7C F1 2E A5 C3 79 DD 75 F0 C3 73 BC 25 D3 95 BB EE A0 8F 9D 67 8F 20 D0 
8F 04 04 7D 5D B9 95 AB AD 82 DC 96 DE EE 8D 78 54 6A FF DF FC 8F 7D E8 27 6A C8 F7 6E 5A 8D FB 
59 4F 17 E8 34 1E 8C EB DB 0F 76 E2 C1 B8 56 A0 DC 8A 07 E3 18 C8 51 46 8B 25 94 51 F7 FA 2C 0E 
52 E9 49 22 39 85 41 67 2A F3 39 77 D0 CB 7D BD A5 25 29 34 EF B5 FC 6A 7C 1A 24 CB 2B 73 50 55 
51 0A 39 3D F2 0D 20 3B 3F 25 11 A4 E7 E7 54 66 91 5D E4 E6 67 03 43 7E AE 12 94 E5 A7 34 A3 F2 
D4 D6 D6 64 74 3A C9 F3 48 79 35 A9 2F 06 8A FC 64 50 99 92 9B 0E 44 79 8E B7 2C CB 4F 95 4B 14 
E8 0C CB AA 26 6F 99 EB 7C CB 30 BD D7 E4 1A 74 22 52 1A 11 18 E2 41 37 E8 EB 5B B3 6A 29 50 DF 
98 55 08 41 0E 9D B4 FC 0E 78 88 A0 8B 13 B8 F2 CA 44 49 4D 29 B6 71 48 A8 86 39 7E 2D 99 56 EC 
BD 36 4B 06 E3 3A 1F CE 61 38 99 A5 A9 7B EC 6D 07 98 24 A2 CF DF 7B F4 D9 7D 7A F1 D1 22 C2 17 
81 3E B5 D4 8E B6 3B 27 E7 71 A3 FD C9 CC EC C3 8E D9 99 59 D4 47 9F 25 7D 74 C4 FD A3 47 8B 1D 
8F A6 51 9F 7D AA E3 FE 22 1E 8C 8B B0 8F 8E A8 3E 8D BA E7 C7 EC 96 4C C7 C6 C7 78 4B A6 8F 38 
D2 74 B7 BB F6 8E D1 1F 5D B8 70 86 3B 7F 24 10 E8 BA C1 FA 62 13 EA 4C 92 89 23 BB 10 E3 F8 46 
FA FE BE 8D 3D BD BD CF FB 3A 4F 23 D5 D3 05 3A DC DC DD DD B3 71 57 22 00 37 D1 F7 D0 BC 17 5B 
B5 6C 86 8C D6 5C 5F 6F 2E 09 3E EA AE D3 02 7E 84 59 A4 C7 A0 43 35 A8 12 39 40 D7 A9 41 8D AF 
77 8C D7 88 8E 9B EE 00 24 24 66 56 E9 71 D3 BD AB 01 4A E5 5D 0A 5D C3 50 91 24 9B 56 94 F4 FB 
48 EF 1E 22 E8 F2 74 BA AC 2B 31 4B 05 0B 32 E5 59 99 6A D6 C7 1D 79 3B E8 61 8E BA 77 3E 5C 9A 
9C 9F 5F 78 34 FF 90 7D 3C 3F E7 8C E8 9D B3 F3 0F 75 0F E7 3A EE 4D CF 7F 76 E0 D1 CC 13 E6 E1 
FC 01 44 F1 F4 43 7A 69 16 F5 D1 6F CD CE 2F 2C CC DD 41 A0 4F DD 99 79 DC 3E 3B 35 FF A0 73 6A 
7E FA B1 EE F1 E2 DC FC 7D FA C9 A3 A8 8C BA 53 1F 8E 8C DA BD D7 5C 96 4C 64 30 6E 6C EC D8 19 
38 C2 F3 CE EB DC 58 00 D0 69 6A A8 C6 82 42 F7 FA 17 B6 62 47 A6 97 D0 45 51 8C 3D C8 BA 7B 77 
AC 4A 22 17 04 7A 58 5A 25 D0 B1 6F F2 B6 6D 7B F7 E3 3F 87 61 2F 9E 30 B3 B1 13 EA CB 2B 6C B6 
C1 72 7D 08 83 71 09 65 F8 67 BD 1D 74 A8 54 34 3B 23 7A 4E A5 CF 77 8C E3 3E 3A 19 24 93 4B A1 
02 C8 E5 A8 DF 92 28 4E CC 62 8B F4 0A B9 D8 62 B6 A6 F9 C8 CD 1E 2A E8 EA 61 80 FB 02 4D B0 30 
A7 BA 06 E6 FA 6D B9 87 31 61 E6 00 02 71 66 E1 31 62 B4 73 61 7E EA C0 A3 8E 8E CE 07 3C 9A 28 
5C 77 74 2E 7E 36 B5 B4 78 67 E6 CE CC D2 E2 D2 AD C9 C7 F3 0B F7 F1 7D F5 C9 FB 4B 9D 1D 8B 9D 
07 A6 71 BC 9E 39 80 5E 30 B3 D4 D1 D1 F1 68 01 5D 35 EE CC 2E 3C 98 69 EF 58 7C 32 8B 77 7D C7 
65 E8 14 E6 A8 FB 49 48 9F 3E 7F EE 23 9D 07 E8 23 87 3E 86 A7 CE 9F FF 08 F2 66 AA 23 C7 8E 1D 
FB BF 4E 53 A3 01 2D 99 06 CB AB AA CA 51 77 14 BE B2 B5 17 4F 75 EF DB B5 AB AF 07 05 B6 AD 1B 
C3 CA 91 1E 4C BA FF FA 3F FF 6F 98 5A 0D D0 75 F0 E5 6E FC B1 7B 77 BD F6 DA AE DE 6D 78 3E E0 
66 08 F5 55 3A 08 99 92 50 A6 C0 36 01 79 49 CD BA EA 2C 8A 07 DD 06 00 06 DD D0 58 A3 35 80 41 
9F 6F 19 EF A0 8B C5 FD B0 28 B9 BA 04 B6 B4 E2 89 2E 50 9F 28 AE 2C 82 B0 C0 47 18 0E 05 74 35 
5D 59 C0 B6 60 B6 BB 32 70 EB C9 92 12 55 4B A6 29 4C F5 D4 0C 9E CB 86 2D 16 89 33 CB 94 DD A1 
85 9F 19 37 43 5C 16 F1 4F F4 1F A9 7E 67 7E 96 37 71 B9 DF 8E CD D3 49 19 29 E0 27 CD 4D 91 67 
67 9C BB 8E 28 A2 1F 1A BB 70 06 7D 6A FD E9 23 A3 67 EC D6 5F 64 C2 CC 75 5C CA 9C 73 F5 CA 47 
CF EA 82 DC 47 B7 59 2C 36 BD 0E 77 57 11 E9 78 F1 1A 59 BE B6 75 EB CB AB 93 72 F5 BF FE 4F B8 
FA AF D5 88 E8 F6 8F ED B0 9C EB DD 8A 2D E7 18 53 BF 0E AE 55 87 34 61 C6 96 8A 9E 12 97 E8 60 
9A 04 3F 4C C5 43 ED 29 B8 7A FE 80 EF 37 8C 5B D0 5B 20 1F B4 45 06 3C 08 C9 A4 E1 3E 79 82 0C 
9A 24 89 5D E9 D0 E8 CB 02 35 94 B9 EE 59 92 84 7C 96 BF 73 2E C2 D5 25 01 5C 5B A2 33 D7 7D 6E 
A1 BD B3 B3 B3 7D F1 49 80 3A FC 45 62 E1 DE 54 B0 3A 2E 85 3B D7 7D 64 74 9C F4 CD 0F 8D DA 27 
C7 8C 61 47 A0 11 92 D4 CC DD 6C 8D 14 07 00 DD ED 94 DF 8C FA E5 DD 44 BD 5B 5F 78 39 20 1E 0C 
15 AE 16 27 C3 D5 F3 C6 F0 DE 91 0B 7C C5 62 37 93 4F 8D 57 A9 76 F7 76 F3 03 90 78 16 51 79 A8 
53 60 57 A8 78 05 3D 51 EE 60 59 44 F2 3F C8 ED 85 28 AE 27 76 01 9F B3 D9 42 5B BD D6 BA B6 2D 
B6 96 4C F6 88 1E DC AF 61 CA 87 3B 72 A4 A0 FB 5C BD E6 73 E1 EA 88 AF C2 50 40 87 BA 57 B6 6C 
C5 29 18 70 8A 99 40 6E 2C E8 9A 60 B4 96 86 29 CB 87 E1 CA 12 E6 3B 06 4B 1A CB 6C DE C1 5B CE 
6D DD BA F1 65 7B 5D AA B1 71 59 86 19 01 74 97 62 BB 4C 35 D4 04 B1 2B 00 FD A9 5D 8F 1E 0B EF 
35 14 C9 D6 6F DE B4 61 C3 A6 97 3B 82 CC 72 67 AC A5 36 6B D8 B2 85 A5 B0 DF 6D 20 68 A6 B7 F6 
97 37 6D 79 E1 85 2D 9B 5E F6 9E 0A 28 80 EE 47 51 5F A6 1A 30 F1 44 A8 09 67 57 C9 92 29 2A 0A 
DD 92 69 95 12 4F 78 9F DA 6C 7B 3B 1B B4 77 CE 84 4B 6B F8 BC 86 7D 81 B0 95 86 90 D2 91 45 BD 
32 1F 29 31 57 03 74 21 F1 84 0B 4C 27 E8 09 51 49 4D 15 7A 2A A9 5F C6 DE 92 E9 17 AD A1 1D 5B 
E6 DF C5 04 F4 50 44 73 94 CD 1A 09 B1 31 96 51 AF 0F D2 4F 87 A1 78 AF 29 C2 FB 6B 79 4B 48 25 
E5 02 D3 99 33 2E 33 3A A0 87 9A 1C 12 BC F8 F3 5B 31 8D E9 B7 6F FF FC 57 A1 1E DB 0F A2 61 E6 
19 30 39 64 88 1A CC 57 14 59 2D 5F 37 BD 21 CB 46 69 53 92 73 34 61 7D 56 0F D0 9B A3 E3 08 55 
18 EA 17 FE 34 2B DA C9 21 89 F3 4B A4 98 87 DE 72 C7 E6 6B B1 D5 AD 7F 09 D9 5F E2 E0 48 C4 69 
60 8F 1E 7D C7 C3 CB 33 AC 93 DF 98 06 40 8E D5 F8 75 F3 1B B2 6C 7A 33 FE AC B9 E1 7C 56 CF 74 
CF 51 49 1A 67 09 FD 64 7C 8A 25 11 47 4C 7A 73 73 B3 7B 62 77 79 62 64 69 E2 D7 AC 59 91 81 03 
78 EE C5 5F C5 52 2B F0 6F 00 07 7F F2 CE 0F 23 D4 D1 60 06 0E 21 68 68 BF 44 92 FB 8D 02 BD 7C 
FB CD 4F 41 76 38 F3 FC BC 0C 1C 5A 22 4F F8 AC 2E 58 C9 D9 F8 F4 2A 53 14 A1 7F C3 9A 66 B1 A7 
57 9A 24 33 42 AD D0 92 69 85 D5 63 A8 9D 99 6F 45 2C CF 3D 86 05 FA E0 FE 9B DF 3C D0 6F 80 86 
28 80 0E 12 93 22 54 46 0C CF 97 D5 55 C4 5C AE 14 4C 41 E1 2B 4C D0 BF 81 11 3D 4A A0 0B 12 F4 
4D 54 B8 A0 DF 14 40 17 24 E8 9B 23 21 A2 0B A0 0B 7A 06 24 44 74 01 74 41 CF 80 84 88 2E 80 2E 
E8 19 50 A4 A0 7B CF 8E E3 A7 B8 92 9F 91 6C DA FC 6E 06 7D ED B2 23 42 FF 0B A0 0B 7A C6 E5 07 
74 6C 95 C6 F8 CD 17 87 41 4F A3 38 4A 4F D9 BC 50 B7 E1 25 6D 56 FE 87 CF 4D 9B CF 4D FC D3 EA 
2A B5 BA 95 DA BC 37 DD 2A D8 3C 77 5E EA A8 E0 79 40 16 4A CF D4 0A A0 0B 7A A6 E5 1B 74 5D 93 
56 AB 2D 51 FB 23 1D F7 D1 73 D4 6A B5 56 3D 60 F4 9C F2 5E 6A A4 8C 46 9B CD 68 34 5A AC 16 B4 
6D E5 37 8D 68 13 97 52 68 D3 AD 02 45 39 36 ED 15 28 52 01 6D 5A 70 A9 0D D7 B5 5A 9C 15 1C 3B 
73 ED 81 AF 4B F1 75 71 05 BC E9 C9 B9 8D AA 50 6B FB 5B B6 7F 1A 00 74 9A C3 6E AF BE 3F AD 00 
BA A0 78 90 1F D0 D5 1A A9 4C AA F1 07 C6 E0 FE 9B 9F 26 EE CF D8 BF AF 61 88 B5 78 82 AE D7 E9 
58 8B 91 D1 D1 7A 1B DA 64 2C 46 1A 6F 72 64 93 D1 E9 F4 03 1C E4 2B E8 F4 56 5C 6A C3 15 28 1B 
47 DB 2B 50 03 AC 7D 0F 3A 8A 54 B0 BA 2A F0 9B 56 BE 02 6D AF C0 5A 29 5C 6A 21 9B E4 DD 3C 41 
B7 C0 FE 97 0C FB F7 DD 08 04 BA B1 A4 D8 6C 2E F6 9D F6 49 00 5D 50 3C C8 37 E8 B4 A9 4E 53 27 
AB 0B 04 FA A7 37 6F DE 04 05 8D 8C 17 E8 E8 25 3A 0B 31 1C B4 E2 4D 9B 51 87 37 59 B4 69 C4 9B 
7A 6C 40 48 1B F1 3C 52 3D 29 B5 E1 BA 7A 1B E3 78 99 BE 14 6D D2 16 BE 02 DE B4 BA 2A 90 4D 8A 
94 DA 28 67 5D 2B D9 B4 38 37 39 9B 17 E8 6A 11 B8 79 F3 C6 8D 00 A0 0F A8 A4 1A 59 5A BF 00 BA 
A0 B8 95 9F 88 8E 41 D7 14 06 00 FD 06 0A 91 37 80 D2 1B 74 2B C3 19 59 23 C5 50 7A D6 C6 71 16 
44 2C 6D E4 F4 16 96 33 32 46 23 6D E1 B8 52 7B 05 A3 1E E1 8F 4A DD 2B 50 A8 02 82 97 A3 48 05 
8E C3 3B 63 6C 78 93 54 40 74 D3 16 16 31 AF 27 15 50 91 95 D1 1B 59 8B 9E AF A0 C7 75 51 85 65 
A0 9B F6 DD 44 C7 1A 08 F4 D2 62 59 9D 46 26 80 2E 28 7E 15 20 A2 07 04 9D A0 23 51 36 7A 35 DD 
6D 74 7D 4A 8D 9E AB C8 53 B1 14 57 9E 32 60 D4 1B F3 8B 11 F5 E6 D4 52 8E 1A C8 AF A7 2C B4 39 
77 08 55 48 29 46 AC D7 A7 55 18 39 4B 72 31 EA 22 9B F3 AD 7A 7D 53 75 39 AA 50 9C 37 C4 71 35 
D5 E5 A8 82 59 3A 68 64 86 52 EB 51 85 E2 34 0B A5 1F AA AE 42 88 AB A4 C3 1C D7 9F 52 C2 19 39 
95 6C 98 62 D6 A6 D6 72 94 BE 48 6A 34 EA 1B 53 4A F4 C6 E5 A0 DF 10 40 17 F4 6C 2B DC 88 CE C7 
C8 65 A0 5B 58 99 A4 8A 63 4C 20 99 D5 53 79 DB D5 08 BD 1B 0A 0B C7 E6 80 1A 4E AF DE 97 37 40 
B1 69 40 8B 2B E4 B2 7A 6B DA 3E B5 91 6D 04 0A 8E 33 E6 6C AF D1 EB B5 E2 34 14 C0 AB 25 6A 96 
AD 92 68 38 AA 34 6D 9F 96 D2 A9 41 1E C7 D9 72 F6 A1 0A 55 22 8D 55 4F 2B 12 4C 0C 63 BE F9 33 
8A B2 A4 EE 53 EB 61 15 D0 A0 E8 DE A0 6C A4 F4 55 DB EB 28 01 74 41 82 BC 15 F6 60 9C 1B E8 6E 
19 A2 10 E8 37 11 E8 FD 37 53 11 E8 69 62 04 FA D0 76 85 85 65 93 41 23 06 3D 0D 81 2E BD 49 40 
CF 47 A0 4B 0D 08 F4 21 90 C3 71 54 B2 A8 51 8F 2A 48 2D 14 93 7B 13 83 7E 53 83 9A F1 52 03 01 
3D 0D 81 9E 8C 41 2F D9 C7 83 DE CF 30 F5 9F 62 D0 AB 0D 04 F4 3A 04 7A BA 01 83 2E 2A E4 41 77 
1E 54 A8 A0 D7 09 A0 0B 8A 63 B9 40 D7 B9 89 EE 57 15 A1 7F 9C 5B A1 1F D0 99 E5 A0 97 60 D0 53 
10 E8 D2 7D 18 74 71 0E 8A E8 A9 18 74 D3 BE B4 52 0A 55 50 63 D0 F3 3C 41 4F 15 13 D0 65 08 F4 
7C 0C 7A C9 A7 75 1C 65 B5 83 2E 65 51 03 5F 49 40 AF 43 A0 E7 C8 31 E8 37 54 0E D0 4B 30 E8 B6 
F4 8C 21 4A 5F 22 E6 41 B7 AD 0C 74 55 9E 4C 96 6F F2 F9 9C 00 BA A0 78 90 0B 74 5A EF 96 08 DD 
68 B4 18 2D 16 F7 02 BD 1B EA EE 11 DD 36 E0 C8 A9 6C B5 59 6C 16 46 83 40 A7 D7 DD AC 66 30 E8 
26 8A 1B 14 E7 18 59 26 15 0C B1 08 74 A9 95 62 10 E8 2C D3 0F D2 18 BD 45 66 50 53 EC 20 6A E6 
B3 FA 54 F1 10 0E F9 32 23 45 E7 DD 44 2D 73 04 3A AB B7 C9 30 C7 26 0C BA 31 D5 80 BA F6 DA 7D 
75 16 BD 2E A7 6B 1D CD 94 DF 50 E9 29 63 BE C1 84 41 2F 64 38 4B 7A C6 20 01 5D 4F 59 2D 36 67 
2A EA 01 9B 1F D0 75 B4 53 3A 6B 6D 51 B1 AA A8 C6 AD 88 16 40 17 14 57 72 8B E8 9C C5 95 36 15 
CF 52 31 BA 3F 1E 1E A0 7D 82 CE 20 B8 ED 32 1A 29 4A 4F A3 88 CE C0 FE 9B D5 34 A3 47 A0 73 0C 
8A E8 94 0E 83 4E B3 08 74 0B 8B 2A A8 69 1D 02 5D C7 18 11 C7 9C 6E 50 92 C3 E8 30 E8 0C 8B 40 
A7 58 5D 7E 96 09 EA 10 E8 0C 8B AF 04 2C 06 9D A6 8D A9 E8 BD 58 14 D1 29 06 83 0E 61 F9 76 15 
C7 52 B9 06 13 8B 41 A7 19 23 02 1D 35 04 10 E8 1C B9 4E D9 65 33 FA 01 9D 35 BA 8B 3F 7E B7 87 
AC 00 BA A0 78 92 5B 1F 9D B5 56 F8 55 53 63 85 6F D0 A1 2B 2E 96 96 D4 57 95 94 BF 74 53 56 52 
A2 B9 B9 BF 5C 6B 7E 69 BB A6 AA AA EE C6 7E B3 BA 7E FF CD C2 92 2A 8D E8 25 73 49 FD 4B 37 35 
A4 42 AD B6 F8 25 B1 A6 AA A4 8E 6C EE DF 5E 58 52 2B DB 5E 56 AF AD DF FF A9 46 5B 22 FD B4 A1 
56 AB 42 15 4A B4 32 80 37 F7 8B EA B4 55 69 DB D3 51 85 8C 1B 75 EA 92 EA 1B 8A F2 92 E2 FD E2 
BA 12 6D 1E 48 47 15 0C E2 96 92 DA B4 ED 0A B3 B6 B6 BE 5C EF 3A 2E A8 F6 09 3A 6D 2C 1D 70 A8 
94 6F E5 BB 1E 57 34 72 02 E8 82 E2 49 A1 82 3E D4 E4 07 74 97 D4 FB 13 C4 62 F1 8D 4F E5 62 B1 
FC D3 1B 64 73 3B D9 14 25 8A 6E 7C DA C5 6F 8A 45 A4 C2 76 5C C1 59 2A 4E 14 B9 5E C6 97 DE B0 
6F CA F9 CD 44 F7 D2 4F 97 55 40 EF D3 E5 28 15 25 8A E5 E2 52 F7 E3 F2 DD 74 37 36 55 34 39 C4 
7F 46 A7 06 06 87 04 D0 05 C5 95 3C 41 6F F2 A7 8A 50 40 37 80 9B 37 D1 13 E8 C7 CD 1B 78 E2 1C 
99 3D 67 DF BC 11 DE E6 A7 7E 77 F6 A9 EF BA FC 8C BD 9B EE EE 86 01 40 F7 77 59 13 40 17 14 67 
8A 6A 44 07 37 22 D4 76 1F 5B BE 9F F7 53 CA 6F DE BC 21 80 2E 48 90 BB DC 06 E3 02 81 EE 19 D1 
87 9D A0 BB 2F 04 31 ED 07 9F 46 4A 7A 74 74 F3 86 CD FD B8 04 D0 05 3D F3 8A 28 A2 4B 3C 06 E3 
D4 4F 03 E8 9F 7E 8A 82 FA CD 84 26 F7 E3 12 40 17 F4 CC 2B AC 88 DE 68 47 E7 A6 58 AA FA 99 43 
AA 7C 7B E9 D7 AF 9B 37 34 EE C7 25 B2 83 BE DF 26 80 2E E8 19 55 58 11 BD AD CB 8E F4 D7 1F C1 
7D EB 53 5F 8F 40 C6 A0 00 BA A0 67 54 61 45 F4 75 0E D0 C9 98 B7 53 B1 85 39 A0 DC 0F CB 41 BD 
00 BA A0 67 57 1E 11 BD 69 C0 EF A9 EF 07 74 37 6D F7 33 26 FE D4 68 39 E8 7E DB 2F 02 E8 82 E2 
4C EE 53 60 6D 56 63 A9 9F 5B E9 FE 22 3A 81 FB 69 04 7C BB F3 87 53 20 63 C8 13 74 EB 80 00 BA 
A0 67 44 1E 4D 77 AB D1 EF A9 DF E8 0E 7A CD 3E 67 7B 18 75 80 C9 BF ED 9F 3E 65 1D 76 D7 71 39 
04 F6 97 7A 80 6E 35 5A FC 04 75 01 74 41 F1 26 EF A6 7B D3 F2 73 9F 84 74 0F D0 87 F6 BB 40 B7 
13 F5 F4 69 BB F7 41 81 32 BD 07 E8 03 16 7F 83 12 02 E8 82 E2 4D EE 4D 77 B7 95 5C 6E E2 0B 2B 
4A DD EF A3 67 DF 7C 1A D1 0E A2 65 8B 5A 4A AD E8 DF 80 A7 4A 49 D6 8A 61 01 74 41 F1 25 37 D0 
19 63 9B 09 A9 89 65 39 B7 7F FA 1A 5C 38 CC B1 3E D6 A3 7F B3 E4 BD 4C 95 C2 C9 DC 29 B7 B5 B8 
58 46 5C A8 B7 56 08 A0 0B 8A 2B B9 A7 92 B2 AA EA 0A EB 0A FB 3D 92 C9 40 CE AC 29 2C D4 A8 3D 
CA E2 01 74 1D AB 56 15 17 17 97 E8 DD D3 4D D0 74 0D 2A 54 95 73 B4 F3 8F 20 80 2E 28 1E E4 01 
7A 91 4C 23 D3 78 65 54 62 8B A5 1A 8D 4C 1B 77 A0 43 BA 36 4D 26 93 16 7B A5 97 32 A5 49 65 79 
85 AC AB 40 00 5D 50 3C C8 33 A2 6B EA 34 75 CB 40 C7 89 13 E3 11 F4 2A 4D 5D 9D A6 5E EF F1 C9 
A0 49 A3 A9 93 15 B9 55 14 40 17 14 0F 72 07 BD 54 00 5D 00 5D 50 7C EA 19 8F E8 32 01 74 41 CF 
84 3C 22 3A EA A3 6B 9E 9D 3E 7A 95 CC 57 44 97 09 A0 0B 8A 43 F9 88 E8 5E A3 EE 71 1B D1 6B A5 
32 99 D4 EC 0D BA 54 A6 91 B6 08 A0 0B 8A 33 B9 83 CE 36 0D 22 79 9D F9 74 E9 D0 E0 E0 90 31 0E 
41 C7 B7 D7 54 25 5E A3 EE 8D 2A 55 71 51 BD 30 EA 2E 28 CE E4 DB 92 29 88 E2 02 74 48 E1 59 70 
14 ED F9 D1 38 5C 68 71 6B D4 08 A0 0B 8A 07 3D C3 A0 87 26 01 74 41 F1 20 01 74 01 74 41 CF 80 
3C 41 D7 51 43 8D 03 8C 87 A8 E1 A1 46 6F 40 04 D0 05 09 FA 66 C9 13 74 46 9B 9B 5A 64 B3 B8 F9 
8B 5B B4 9A DC BC 21 AF 93 5F 00 5D 90 A0 6F 96 3C 41 E7 EA 0D CA EA C6 8A 41 A7 86 2B 54 65 19 
65 35 02 E8 82 04 7D A3 E5 09 3A 5B 9E 94 91 BF B6 69 D8 A9 A6 01 55 43 76 7A A3 D7 C9 2F 80 2E 
48 D0 37 4B DE A0 67 67 54 9B 9A 2A DC 40 2F 2C 13 40 17 24 E8 9B AE 65 A0 27 A5 A8 3D 40 D7 64 
97 09 A0 0B 12 F4 0D D7 72 D0 93 B5 15 21 80 7E 83 CF EF BC FC 5F 58 5A 66 93 18 A0 82 FF 3D 38 
DE DE CF 81 79 E6 8C 13 40 17 F4 2C 69 39 E8 A9 DA A0 11 7D 78 3F B8 E9 4F 6E EE C5 37 DD 7E B8 
36 DD 0A 3E 5D B6 E9 FD 5A DE 2B D9 67 A9 7B 05 AF 3D F8 16 28 63 E1 CA 25 80 2E 28 1E B4 1C F4 
6A D3 80 67 1F 7D 39 E8 DC CF B6 07 B2 65 D9 EE ED 7E EC FE D3 55 61 59 18 0F F0 32 8F 88 FE A9 
77 85 4F 43 C9 2D FF A9 B8 30 0C CE 05 D0 05 C5 85 BC 6E AF 99 95 E2 E4 9A E1 C1 21 87 86 2B 8A 
92 94 49 6D DE 67 3F 57 FF 33 DF 2A FA 59 CE 7E 59 91 4A B3 5F F1 B3 A2 96 9C 6C D9 CF 54 9A 6C 
45 8B EA 67 8A FD 1A D5 CF 64 65 39 2D 6E 15 54 85 39 65 B8 C2 7E 45 91 AA 45 91 CD 57 40 7B C0 
75 55 D2 FD C9 45 A4 82 4A 25 CB C8 41 75 15 65 9A A2 22 69 59 2A DA 43 3A AE 90 96 9D 82 DE 02 
95 A2 BA 86 54 54 21 BD AC 0E 55 C8 4E 45 7B F0 A9 96 AA 70 5A EE 02 E8 82 E2 42 DE 13 66 A4 B9 
45 56 8B D5 95 15 D5 A2 D5 A4 69 2A 7C 9C FF BE 05 61 79 FE 10 84 D6 7C 33 0D E9 7A 59 13 84 46 
69 31 0D 61 71 B5 05 C2 01 59 3D 03 61 7D 3E 2A 1D A8 36 A3 77 2B D7 A0 4D 4B 75 31 DA 2C 96 A1 
0A C3 B2 72 F4 32 73 5E 29 84 8D 79 B5 A8 81 51 8F DF 7A 38 B5 1C 2F 8B D7 A0 0A 8D B2 2A 06 EA 
54 F9 68 B3 3F 4D AB 83 8C 59 33 80 4A 73 4A 50 85 A2 3A 23 84 35 B2 12 DA FF B1 09 A0 0B 7A 56 
15 D6 5C F7 40 2A CF 1F 44 A0 E7 22 8E 75 F5 D2 01 0C BA 4A 87 41 37 7A 80 5E EA 05 3A 5D 2C 43 
15 2A 64 E5 3A A8 33 E7 3B 40 67 78 D0 93 CB F1 95 C0 0E 3A BA 6A 38 40 47 2F 33 6B 70 5D 05 0F 
3A 85 40 97 56 85 02 34 AB E7 02 4B CF 39 76 23 80 2E 28 1E 14 75 D0 EB 73 51 8F BE 29 B7 58 87 
28 94 0E 43 68 93 AA 10 DD AA 14 1B 0E D8 66 16 57 40 A5 15 29 66 12 B0 F1 45 21 45 85 39 96 5A 
21 1C 92 D5 E3 88 9E 8B E8 AE C9 2F C7 3D 04 5C 61 30 B9 9E 64 B4 B2 62 8E 6B 51 44 2F CA 45 9B 
A6 BC 12 1D 2E 45 75 D7 2A AA 50 DD 22 7C 25 68 93 56 D1 41 0E 10 E2 9C 13 75 41 24 2B B2 08 A0 
0B 8A 23 79 81 CE 1A 8D 7A 8F 3C E7 34 4B 19 BD D7 6C 87 0B 7A C5 72 D0 71 05 17 E8 83 2B 05 1D 
C5 79 5C D7 05 FA DA 90 40 67 F3 DE CA 7C 2B A0 76 66 38 06 20 05 D0 05 C5 83 BC 46 DD 4B 72 14 
85 56 5B A9 53 56 5B 49 5A 4E FE E0 72 56 56 08 7A F1 4A 40 CF F7 0F BA 0C 83 AE 8A 18 74 E9 C1 
B7 0E 3A 84 B0 3E 28 4E 4C 14 E3 2D 67 61 66 92 63 21 8F 00 BA A0 78 90 17 E8 F5 19 CA EA C6 26 
B7 45 2D 4D C5 65 19 65 2B 69 DF 9B 53 6B 10 E8 A9 A8 63 4E 17 93 EE 7A 7E 11 8E E8 39 98 63 69 
31 8B 2B A0 D2 8A 1C D4 31 67 CD 52 B4 59 9A 53 84 40 57 E5 A1 0A 43 69 78 0C AF 38 15 E1 BF 36 
A5 1E DF 04 90 21 DE 86 14 F8 A2 A0 92 A2 DE F8 DA B4 72 04 FA CF 52 D1 A6 BA 1A 37 DD 55 32 54 
B7 2D 1D F5 E7 B9 16 3C 9C B7 2E BF 36 24 D0 3F 39 F8 09 AF 83 9F 14 EC FB CD EF 7F FB BB DF FD 
C7 EF FF F8 E2 3E 67 71 66 B6 00 BA A0 78 92 D7 ED B5 F2 EC 8C FC B6 A0 8B 5A 02 A9 5C 8A 10 29 
95 9A 11 E8 E5 64 D4 5D 66 46 A0 9B F3 F0 A8 BB 06 61 8A 2A A0 20 3C 90 87 A3 74 79 1D 1E 8C CB 
37 E3 51 35 8C 69 85 06 8F BA 93 31 BC 46 69 15 A9 80 07 E3 72 F1 A8 BB B9 8E 0C C6 95 E0 2B 81 
14 35 0F D6 49 B5 E8 FA 60 AE C3 83 71 29 84 79 3C 18 87 2A 84 30 18 C7 48 0F DA 89 3E 78 F0 C5 
DF FF EE CF 0E FD F6 37 05 F6 27 04 D0 05 C5 97 82 2E 6A 69 F1 B1 A8 25 90 A8 01 04 33 6D C3 D9 
24 F5 C3 08 3A 7A 80 C2 9B D8 75 59 D7 84 37 29 EC CB 4A 0F E0 0A 54 13 AA C0 F0 15 06 70 69 05 
BE D5 4D 59 19 47 29 35 40 2A E8 1D 7B 60 88 F9 A1 D1 86 37 9B 70 A9 11 EF 8C 2D 25 A5 A4 6E 45 
28 F3 D9 59 07 E8 07 F7 FD FE CF 7F F9 CB 5F FE FC 97 3F A3 FF F0 C6 EF 7E C3 07 75 01 74 41 F1 
A5 B0 16 B5 7C D3 65 8F E8 28 9C FF 07 82 DB 4D E8 D1 1F 09 E9 02 E8 82 E2 4B 61 2D 6A F9 A6 CB 
1E D1 0F BE F8 3B 4F CE 31 EA 7F FE BF 0B 0E 0A A0 0B 8A 37 05 5D D4 52 17 87 A0 F3 11 1D 73 FE 
E7 65 42 A4 A3 27 05 D0 05 C5 97 BC 47 DD 93 42 49 3C F1 4D 17 89 E8 07 9B FF C3 07 E7 98 F4 DF 
4A B4 A8 FE 00 00 19 34 49 44 41 54 08 A0 0B 8A 37 2D BB BD 66 A8 AE A9 18 76 DE 5E AB 68 2A F2 
91 33 6E 99 8C A5 F6 A9 F1 A5 2C E3 98 25 5F 6A A4 29 2B 3F 6B DE 6A 65 E1 F3 CF AF 27 7A BE 43 
A7 AF E0 6B 58 6D 1C B3 DE 51 BC DE F7 68 B9 DE 54 D3 88 55 D3 68 F1 F9 7C 58 C2 11 FD E0 27 7F 
5C D6 6E B7 93 FE 1F FB 0E 0A A0 0B 8A 2F 79 2D 6A 51 E7 55 17 D9 8C 16 97 8C DA 3A A9 34 E8 84 
19 AD 34 25 9F 28 59 CD AA 92 73 F9 CD 3A AA 31 85 2F 4E A9 56 C3 C2 9C FC DC DC DC FC DC 94 BF 
ED EC CF AF 26 C5 D5 D5 DA F6 BF 4D C9 C5 CA 4F D6 F8 5E 5B 36 94 9E 9C 42 94 53 14 CE 6A 72 DF 
C2 11 FD E0 3E 5F 0D 77 47 E3 5D 00 5D 50 7C C9 7B 0A AC 9E E2 74 3A DA B9 E2 8B D6 31 9C 3E F8 
14 D8 F2 6C 43 06 51 73 2D AB 29 E0 37 D7 28 A8 7E 25 5F 6C 30 D4 EA AA 9B F9 62 E5 9E F5 EA 24 
47 71 7D FB 5E 25 5F FC EB 74 CA E7 9E D7 AE 49 CA 26 32 48 A3 07 3A 83 67 C6 FD F1 CF 7E 40 FF 
F3 5F 7E 57 20 80 2E 28 BE 14 9D 45 2D B5 E9 49 65 D9 65 18 C7 2A B6 CE 80 7E A3 6D 43 0A D5 96 
C4 17 27 25 95 C0 34 43 19 51 D2 6B EB D5 65 8E E2 F2 F6 FF 4C CA 26 C5 19 39 BE 41 AF 31 34 A4 
37 34 A4 A7 37 64 6B A2 1A D1 DF FA C4 5F 40 27 BD 74 61 0A AC A0 F8 52 74 40 1F AA 35 AB 5A 8A 
54 E6 FA F2 01 C6 64 2E 2E 6A 51 15 D7 D7 AB 19 5B B9 A3 D8 0A BF F8 BC BB AF 6F 6B F7 E7 9F 7F 
D1 5E EA 28 AE 6D 62 0F 38 8B 7D 73 5C F3 6B 65 46 12 6E 08 28 F1 4C DA 28 09 47 F4 6F FB 0D E8 
48 BF AF 14 40 17 14 57 8A 0E E8 FA A6 A1 C6 B5 35 43 43 83 83 9C CE 38 D4 58 53 D3 88 36 6D 3A 
76 10 17 A3 ED 61 0E FE E9 4B BB FE C4 72 15 F6 E2 0A 8E 76 16 FF B7 6F 8E 1B 0F 1E FC F5 AF 7F 
8D E7 A4 AB 56 B2 86 2E B0 70 1F FD 37 01 40 FF CB 7F 64 09 A0 0B 8A 2B 45 07 74 AE B4 62 A0 B4 
74 A0 A9 69 58 0F A9 E1 81 81 D2 81 81 A6 E1 52 C8 0C F3 C5 15 15 18 F4 AF BE FA F2 4B F4 DF 9F 
DA 99 81 0A 52 A3 A2 42 4F 3B 8B BF F2 07 FA 5B 98 F2 4F DE 3A A8 8A 6A 44 0F D0 45 C7 9D F4 1B 
02 E8 82 E2 4A D1 8A E8 83 FC 7D F7 41 3D 34 DA 37 87 4A 51 44 E7 B7 51 A0 77 8B E8 ED 6C 85 BD 
78 58 EF 8A E8 7E 41 B7 CF 4A 8F 26 E8 AC 00 BA A0 67 4C 51 8A E8 4D 0E A2 5D A0 0F 96 EA 18 2F 
D0 BF F2 03 FA 57 C1 41 8F 76 44 17 FF D1 7F 0F 5D 00 5D 50 DC 29 BA A0 0F 07 06 DD D1 74 5F 1E 
D1 BF 12 22 BA 20 41 AB A8 E8 36 DD 83 44 74 3F 4D F7 AF 42 68 BA 47 BD 8F 1E 70 30 EE B7 C2 60 
9C A0 F8 52 4C 23 BA BD E9 FE 34 44 F4 B7 F6 05 02 5D B8 BD 26 28 CE 14 C3 88 FE D5 D3 14 D1 85 
09 33 82 9E 29 C5 B6 8F FE D5 D3 13 D1 03 4E 81 FD 44 00 5D 50 7C E9 99 ED A3 7F 12 60 51 CB 1F 
85 45 2D 82 E2 4C CF 6A 1F 1D ED D5 DF 70 DC 5F 7E 2B 2C 53 15 14 6F 8A 21 E8 5F 39 9A EE 5E 11 
FD AB AF E3 3E FA C1 4F 0E 7E F2 5B 9F 0B D2 FF F2 E7 17 85 C4 13 82 E2 4D D1 01 9D B5 0D 58 91 
4A 4B 2B F4 90 6A E2 37 9B 6C 90 6E E2 8B 07 9A F8 29 B0 58 5F FE 89 65 AC F6 E2 01 8E 76 16 07 
98 02 7B 30 DA 53 60 F9 88 7E F0 DB BE 48 C7 0D 77 01 74 41 F1 A6 E8 80 6E EB 57 6B 91 D4 FD EB 
28 66 D0 A4 D6 96 68 D5 A6 FE 41 DA D8 AF C6 DB 26 53 9B 1E FE F7 FF F3 C5 1F 90 BE F8 E2 BF 59 
0A 17 A3 DA A6 B5 7A E6 BF BF B0 17 FB 01 BD E6 E0 27 BF 56 2A 95 BF FE E4 D7 D1 8E E8 38 09 AC 
AF E4 90 24 0D AC 00 BA A0 F8 52 74 40 D7 A6 25 2B D2 D3 15 A9 B9 B9 FD 7A 55 6A 0E DA CE A9 AE 
2E D2 F7 E7 F3 C5 D5 D2 75 F0 6F 77 EF 46 DB BB F7 EC E9 EE 5C 97 EB 28 36 B5 F7 EE B1 17 F7 F9 
4E C8 BE 56 99 5D D6 D0 50 56 96 9D 51 18 ED 88 8E 63 FA EF FF EC 95 EE F9 77 BF 39 28 A4 7B 16 
14 7F 8A 5E E2 09 2C 92 78 22 83 CF 30 91 C1 27 9E 20 C9 26 92 4A 74 D2 0C 67 E2 09 53 19 9F 6C 
22 9B 24 9E 40 1B 0D 01 12 4F 64 34 A4 37 A4 23 45 33 F1 84 C3 A9 E5 9F 0E 16 FC 11 05 75 7B 58 
C7 BF 7F FF E2 41 C1 C0 41 50 1C 2A 3A A0 97 67 F3 19 A1 0C 89 B5 AC AC 99 4F 14 95 98 43 F5 2B 
F9 62 25 4E 25 25 E6 6B 28 77 AF 57 67 B8 A7 92 E2 B7 D7 F8 49 25 B5 2E 41 69 20 5A 93 1F DD 9C 
71 0E 4B A6 7D 7F FC ED EF FE CC C3 FE BB DF FF C6 61 BE 26 80 2E 28 BE 14 1D D0 D7 16 B5 F0 AA 
5B CB 54 15 92 AD A2 42 33 57 5A 58 68 2F 5F AB 2B AF E3 B7 0A CD 9D 83 8E DA 2D FD 6C AD BD 46 
61 B1 EF A6 FB 80 C6 5E A1 AE 3C 9A 7D 74 A7 9B 22 46 FD 37 7F FC FD 6F 7F FB FB DF FF F1 45 57 
A9 00 BA A0 F8 52 74 40 0F 5F BA 65 1B 31 10 9B 9F 99 99 F9 96 EB 1F FF 9F FB 3F 60 10 FC D1 05 
C5 93 BE 6E D0 BF 16 31 2D 78 5C A0 81 FF 0F 8F 10 38 D4 E0 28 4E C2 D6 CD 44 02 E8 82 E2 41 CF 
24 E8 3A 0B 36 A7 B8 6B FF CF FD 9F E3 BF A1 0A 47 47 41 00 5D 50 3C E8 99 04 9D 97 0E EA 74 E4 
A7 5B 09 5F A8 73 EB 47 08 A0 0B 8A 07 3D C3 A0 87 26 01 74 41 F1 20 01 F4 20 12 40 17 14 0F 12 
40 0F 22 01 74 41 F1 20 01 F4 20 12 40 17 14 0F 12 40 0F 22 01 74 41 F1 20 01 F4 20 12 40 17 14 
0F 12 40 0F 22 01 74 41 F1 20 01 F4 20 12 40 17 14 0F 12 40 0F 22 01 74 41 F1 20 01 F4 20 12 40 
17 14 0F 12 40 0F 22 01 74 41 F1 20 01 F4 20 12 40 17 14 0F 12 40 0F 22 01 74 41 F1 A0 28 80 AE 
D7 AE A5 23 DF 0B AF 81 AA 81 A8 EC C7 A2 6E 8C D2 31 09 A0 0B 8A 07 F9 05 DD B8 B6 BF BF DF 34 
C8 05 CD FC A2 D3 AE A9 0B 96 E5 89 6A 6B B4 EF 47 BF B6 22 00 81 74 4B 42 2D B4 9A D0 3B F7 B7 
AD C3 EF 1F A8 B2 BB B8 46 CF 94 73 E5 05 2D 51 CA 3C 25 80 2E 28 1E E4 17 F4 DA 24 A5 B2 A0 C0 
50 E6 27 97 9B 1B 09 B5 40 1A 04 2A 5D 55 92 23 35 93 29 5B E3 3B 0B 24 11 2D 03 E5 B0 48 AC 54 
E2 8C 90 E8 A7 48 A6 0F F2 EE BC 58 73 B3 D4 E3 92 50 0C 82 5E 7C 42 94 00 BA A0 78 90 5F D0 55 
40 A4 48 49 4E 02 40 1A 00 4C 42 42 49 AB 2C 08 54 B4 19 00 85 91 6C 6A 1D 1B BE 2B 6A 40 2D AC 
2F 53 28 72 94 A0 4B A1 50 94 15 B9 5D 66 18 C6 6F EB 82 4A 03 19 1E 17 24 73 56 B4 D2 C0 0B A0 
0B 8A 07 F9 05 BD 38 33 B7 54 4F 59 6B 45 A0 24 08 09 21 80 5E 9F 00 2A 8B 49 65 B5 28 25 50 44 
D7 A0 88 CE 59 8C 46 AE 08 E4 5A 28 A3 CD 2D A0 EB A5 D5 8D 7E 5F 67 4A 36 7B 5C 05 04 D0 05 09 
72 97 7F D0 81 86 34 86 65 40 16 24 A1 BA B6 32 38 E8 72 83 A4 92 A4 5B 54 8B 52 03 44 74 5D 1D 
02 9D A8 1E 68 BC 9E 33 76 01 B5 FF 57 7A 1D 81 00 BA 20 41 EE F2 0F BA 44 4A 00 2F 06 C9 38 AC 
72 35 EA 1A 02 3E 55 4A C3 61 D3 5A 7B 43 99 AE 31 D5 14 67 69 08 54 54 BF 7A 90 87 6E 90 83 16 
52 85 5A 67 B2 E0 5A E6 2E 59 3A 90 71 24 A2 F3 A0 B3 35 6A 02 BE AE B4 09 32 A6 7E BC 3B 7D BF 
69 28 CF 01 BA 19 C8 70 88 66 86 F1 EB 21 D7 A4 87 AC 41 5C E3 38 38 A3 89 EC 17 BD 66 90 85 83 
EA 01 A8 B3 F1 97 8F 0A FB 13 76 D0 2D 26 53 93 DB 67 D2 AF 33 95 F2 5B 03 26 13 FF 02 6A 50 07 
87 D5 38 89 BB CD D4 EF EB 8A 26 80 2E 28 1E 14 00 74 3E 92 17 02 04 7C 8D C6 20 6A 15 E5 AC 43 
AC 68 92 D2 14 89 95 62 05 66 43 57 DF D0 D5 2A 16 65 E2 81 2F 9B C6 20 6F 15 57 B7 A1 E2 12 43 
4E 9E 32 4B 94 53 2E 35 C8 E5 49 55 34 02 BD B2 A5 31 09 D4 43 47 44 D7 69 33 BA 32 C5 B9 68 1F 
96 86 86 FA F4 4A E5 20 E4 5A 32 12 B2 D6 64 B5 D6 7A 80 AE 56 16 E2 AB 42 51 76 49 7F 8E 24 B3 
A1 3A 35 55 C5 C1 A1 14 65 6B AB 21 0F 13 5D 64 A8 93 AD C9 2C 84 EB C4 75 E8 D8 CC E9 6B B2 B2 
32 CC 8C 1D 74 7D 4B 41 6B 65 73 7A 95 03 F3 22 83 3C 6B 4D FE 00 84 FD 39 E8 09 03 BE F0 40 99 
32 2F 27 31 AB B9 D0 AC 50 66 75 E5 D4 78 FF 15 04 D0 05 C5 87 02 80 AE C1 A4 19 CB 80 19 D2 29 
C0 20 D5 18 70 23 9E CA 01 95 49 52 69 22 6E D8 EB AA 44 20 AD B8 A5 0C 8F 70 73 32 90 51 58 54 
06 D2 8D 18 52 90 94 97 96 08 12 13 93 35 D9 A0 4C 8F 40 97 D4 A1 D2 0C 8B 23 A2 AB 95 59 75 E6 
64 90 C7 C1 01 31 10 CB 33 B2 29 74 41 E9 AA 2B AE 53 4A 3C 23 7A 39 48 43 3F B9 3C 49 B9 3A 03 
00 65 52 86 41 C3 1A 93 41 59 51 4B 22 A8 A3 70 C7 A2 35 2B 23 49 05 B5 20 17 0F F4 81 9C BA 64 
A0 6C B4 83 5E 0C 92 8A 54 B9 A0 85 DF 23 53 04 BA 64 9A A4 0C 2B AC C8 06 0A 55 61 02 28 42 57 
84 74 90 D0 20 CD 69 CD 14 65 E4 4A 95 A0 4E 00 5D 50 7C CA 3F E8 AD 0D E5 DA 12 55 03 50 D8 50 
1F DB 6C 63 A0 29 31 63 10 52 A9 09 C5 36 5A 57 95 99 C4 C1 D2 82 CA 5A 44 63 AD 44 83 A1 52 A0 
46 B2 5E 01 8A 71 FF BA BA 89 A1 CB 81 01 B5 85 87 94 A8 6F AE 33 67 6A A0 2E 1D 5F 10 08 E8 FA 
06 A0 45 F8 A6 82 12 58 AA 04 29 6B 6D 03 50 0D 94 FD 88 2A 99 57 D3 BD 0A C8 30 E8 B2 AE 2A A6 
6D 8D BC DC 52 5A 4A 41 0D 90 A1 60 DE 58 06 50 F0 AF 03 49 5A 9B 4D 8F 5E 8E 2E 08 43 45 A8 0B 
40 E5 E3 43 40 A0 D3 B0 01 98 70 1F 81 6F E4 43 13 50 0E D1 3A CB 30 64 53 40 21 EA 8D F4 17 64 
A1 A7 73 40 31 45 A3 AB 54 B5 91 A1 6B 81 62 79 E3 5D 00 5D 50 3C C8 2F E8 E6 04 90 D0 B5 06 80 
64 3C D4 4D 7A E7 5C 99 A1 06 45 F4 66 DC 68 1F 10 23 D0 CB 41 0E 83 9B E1 95 32 1A 26 03 D2 E6 
AE 05 29 14 02 5D 85 36 1B 5B 15 08 55 B6 4C DE 48 40 A7 A1 B6 4B A4 C6 A0 53 88 39 05 5F B9 10 
5A 9B C5 15 38 DC A6 91 C0 EB 1A 8C F3 02 5D 5E 05 39 65 57 3F 39 8C 24 40 5A D8 C5 B8 46 1D 79 
2B 1C CC 71 E4 D7 F1 AF 6C B1 83 9E 0E 8A 6C CE CF 43 B7 38 E2 75 A9 58 6C C5 95 35 A0 08 42 05 
D9 99 99 3F 62 89 62 F9 6D 7B 01 74 41 F1 20 FF 11 3D 2B 43 23 4B 00 32 FE 66 18 AD 56 C9 92 BB 
32 1A 11 E8 89 18 B7 8A C4 24 8E 96 B6 E2 5B 66 BA 92 56 0D CD 96 49 D6 E1 7A 35 49 49 35 08 F4 
16 02 7A 3A BA 0C E8 1B 44 0E D0 75 85 A0 41 BF 0E 83 5E 0E 94 69 B9 B9 D2 6C A0 81 D6 44 03 1E 
35 D3 67 48 F0 91 90 DB 6B 7E 40 A7 94 5D 64 D4 7D 50 B9 86 C4 68 53 6B 3A 8E EE B5 6E A0 C3 A6 
FA C2 FC A4 CA 22 7B D3 BD 56 0C 92 64 C5 F6 BB 79 16 85 D8 7E 9F B0 AD 35 89 25 C7 0D 92 39 04 
BA C9 71 71 80 35 F2 74 01 74 41 F1 A9 40 A3 EE 1C 53 08 72 C8 A9 3F A4 11 03 65 46 65 92 07 E8 
4C 72 56 2D 01 26 53 A3 D3 67 CB C9 9E 06 1B 50 0B DC 0F E8 D0 98 04 EA B5 05 08 74 33 28 48 2F 
2B CB 4E CF A9 85 A5 89 4A 3C 26 46 29 B3 9A 02 82 5E EB 04 7D 6D 73 06 19 30 6F 13 97 59 A0 A3 
3E 01 9D 35 97 81 AE 8C 82 2C 07 E8 8C 3A A5 19 80 54 13 A9 D1 54 66 E0 37 74 A6 CC 74 D2 42 57 
67 29 BC 40 4F 10 40 17 14 A7 0A 34 EA CE 40 3D EA 57 63 42 15 A0 BA 76 A8 3F DB E0 09 7A 6A 65 
39 74 46 74 40 DA D5 8D 49 19 7E 23 3A 84 E5 AD 06 99 32 05 83 2E 65 6D 36 9B D5 C6 39 41 37 90 
DB EC 01 41 2F E8 22 A4 0E 2A 13 F9 88 9E 45 22 BA 0B 74 9D 19 28 55 A6 C1 96 CC 16 E7 ED 35 7D 
9B 59 41 C6 07 51 67 A3 41 C9 83 0E D7 56 92 88 0E B5 12 EF 88 2E 80 2E 28 5E 15 E4 3E BA 49 8C 
27 C6 D5 93 51 2A 46 A1 F4 00 1D 75 A8 C9 C0 3C E9 A3 A7 F2 6D E8 92 CC 64 A3 7F D0 59 19 48 94 
E7 1B 61 09 1E 23 E7 35 C0 83 CE 95 F1 13 F0 0A BD 40 AF 25 A0 EB 34 5D AE 88 8E FA E8 E4 A0 EB 
81 54 E7 01 BA 45 29 C7 15 6A 25 2D EE 13 66 6C 19 40 0D 19 0A 52 B9 A0 98 2F B1 26 8A 06 F8 F7 
2A D4 09 A0 0B 7A 36 14 04 74 5D 11 C8 6E 82 45 B8 61 CC 55 AD F1 EC A3 23 BA 70 90 34 16 F2 A3 
EE 0D 15 A8 4E 0E 1E D5 72 80 DE 40 40 EF C2 A0 4B F8 69 76 43 06 00 F2 8C 70 B0 39 A1 04 3D 5E 
AB A6 1D 11 1D 75 12 14 88 BE 0A 85 17 E8 25 20 DD 0A 19 53 59 57 15 D4 67 DB 6F BD C9 F0 2E E0 
50 03 AE EA 0E FA 00 50 0E A2 B7 4D 91 E0 A6 7B 65 21 AD AB 52 A3 5D 70 D9 60 1D 5D 9C A2 46 7B 
6C B0 42 58 AA E6 D8 6A A0 41 EF D9 6F C8 54 43 4F D0 B3 04 D0 05 C5 A9 FC 81 AE 53 81 7C DC C0 
E5 92 41 32 6B 02 AD B2 42 45 22 50 D6 40 2A BD 15 93 31 28 57 EA F1 73 4A 4D 5D 43 26 B9 BF 9E 
0B 92 5A 8A D2 41 03 45 96 8E A1 2A 6B 41 36 DA 81 1E 8F 91 EB 8A 81 8C 5F 5C 56 8C FA CC 46 BC 
62 A6 32 BF 45 D6 65 B0 C2 81 AC 44 32 C9 AE 29 03 34 D4 C9 92 00 99 55 03 71 8D 3C 0C FA 50 36 
48 AF AB 6E 06 92 5A C8 B4 80 24 75 63 FF 3A 7A 00 BD 8B AA C8 00 34 7A 0C 7D BD 1D F4 6A DC CF 
48 2F 94 A2 4B 49 0B 99 C0 AB A3 94 40 AA 52 E5 80 14 66 A8 19 24 43 4B 36 48 D2 68 92 12 D4 70 
28 03 24 AB 0A 9B 41 0B B9 8F AE 26 87 85 E7 E5 B4 E1 7B FE 02 E8 82 E2 51 7E 23 7A 55 83 8A 34 
7E 4D 8A B2 21 A6 50 09 40 59 61 7E 6E 05 D4 D7 E5 90 F9 A2 8A 3C C4 E7 50 75 22 90 E7 68 D2 8B 
51 CD 41 E9 1A 00 0A A4 F8 66 55 49 36 A6 AF A2 01 4F 81 E7 64 8A 0A D4 8D 4F 2F E6 41 37 CA 92 
8A 10 4C 54 71 92 04 64 A5 AB 28 D4 FD 4F E5 EF 5D 97 A4 67 81 82 5C 69 83 96 7F FB 92 0C 15 99 
02 AB 45 15 0D 69 B2 1C 35 EE 65 83 D6 82 C4 6A 3D EC 4F 16 03 90 81 6F A6 C3 E2 24 7E FE 7B 7F 
06 0A E3 6A 74 CD 59 93 5F A8 28 C7 7B 33 EB 38 B3 A2 0B 80 AE DC 1A 68 CC 6D 46 0D 8D FE 7C F4 
32 43 DD 10 D4 69 15 72 00 92 0A F1 15 46 53 86 6F 1F 96 18 F0 11 0F 2B 34 CB D7 E4 0A A0 0B 8A 
07 F9 05 9D B3 D8 A3 1B D5 A4 87 BA 21 AD 49 0F 59 23 0D 75 94 11 F3 4F 5B 8C 84 C3 36 9C 5D C6 
48 6A A2 3A 64 CE 38 EA 8A 97 62 5E E8 52 7C 63 4B 47 59 10 E2 AC 73 19 1A 37 A0 27 77 BB 6D 26 
2D 99 E0 6E DF 11 7E 1F 93 76 10 EA 2C 76 D4 38 AB FD 15 03 6A 3C 95 DD 82 AF 06 D6 F2 3A 4D A1 
9A C1 93 60 B4 6A 2B 79 56 6F E5 2F 13 4C 29 AE 6E 51 E3 D9 F6 78 17 1C D9 0F BB 56 AD 6D C3 A6 
E7 C6 1A 72 43 6D AD 56 CD 27 B0 E1 D6 69 D5 FC 3C 1A AA 14 7F 1C 76 80 3F 16 6A F9 42 58 01 74 
41 F1 20 21 67 5C 10 09 A0 0B 8A 07 09 A0 07 91 00 BA A0 78 90 00 7A 10 09 A0 0B 8A 07 09 A0 07 
91 00 BA A0 78 90 00 7A 10 09 A0 0B 8A 07 09 A0 07 91 00 BA A0 78 90 00 7A 10 09 A0 0B 8A 07 09 
A0 07 91 00 BA A0 78 90 00 7A 10 09 A0 0B 8A 07 09 A0 07 91 00 BA A0 78 90 00 7A 10 09 A0 0B 8A 
07 09 A0 07 91 00 BA A0 78 90 00 7A 10 09 A0 0B 8A 07 AD 0E E8 34 C3 32 C1 0C 8F 75 A8 8E D7 62 
31 9A 65 03 1A 29 E1 97 44 C9 69 29 64 09 A0 0B 8A 07 45 08 3A 55 EA 2E 7E C9 28 6D 2C C9 4B 2F 
4B 4F 51 0D EA F9 34 D1 D4 90 B6 BE 58 65 D6 36 51 CE E5 DE 34 B5 56 83 EA C8 D4 AE 4C 0F 34 55 
9B 5B D6 90 5C 34 E0 C7 EA 8D D1 AB EB D0 4B 52 8B 1A F5 6E B0 33 96 81 52 8F 17 58 06 AC 9E 3B 
60 8C 03 B6 20 EE 71 81 24 80 2E 28 1E 14 19 E8 5C 5A A2 D2 A5 44 92 34 82 56 19 44 12 BC 6B 79 
41 46 15 5E 8B AE 51 16 24 76 C9 E5 5D 89 4A 83 C2 C4 33 CA D5 1B D6 E0 3A AD E2 74 C7 01 70 E8 
65 F8 55 59 4A DF 3E CD 5C 4B 46 62 25 AE 90 50 90 51 E4 BA 3C A8 0D 05 89 2A F7 6A 65 CD 86 42 
8F 17 56 65 14 28 83 18 C2 06 92 00 BA A0 78 50 84 A0 2B 3C 76 86 F3 43 1A 65 78 4B 2E EA C2 54 
62 53 36 AE CC AD 46 56 3A 31 5F A8 45 94 67 89 13 E5 A8 C4 0E A1 11 D7 6A 15 93 4B 44 72 E9 F2 
77 32 25 91 97 77 C9 F1 6E 13 9C 47 4D 6B D0 C3 B2 41 57 3D 7D 17 00 95 EE C6 8A 4C 0E AA 61 0E 
FF 23 0A A0 0B 8A 07 45 08 7A 2A 00 09 19 49 BC 32 48 E2 F4 62 B4 D3 35 F9 B5 EA 92 22 45 57 01 
A6 9A 4B 07 A0 4B 91 9A 9A 53 A6 C4 60 13 2A 2B 72 40 52 71 FF 50 AD 02 71 9D 4E 3A EA 35 12 50 
99 D4 62 52 6B 94 00 48 EA 97 BD 51 1B 2A 06 89 E9 AA AA DA 22 45 22 48 77 5E 09 4C 05 A8 5C D2 
E2 AA A8 4F 44 05 EE 46 CF 55 F8 53 16 87 FF 11 05 D0 05 C5 83 22 07 BD 61 98 D3 DB 85 1A EA 56 
14 79 1B 86 48 B6 29 B6 94 44 6F 0C 7A 83 85 61 59 8E 5B 87 1B 00 75 98 C2 41 13 C9 28 C5 15 65 
02 3E 89 33 2B 2B A8 E2 D0 EB E9 C1 0C 74 31 18 F0 7A 9F 26 03 0A F7 D5 46 56 87 77 6B AC 6D 73 
0E E2 B5 90 0F D1 E0 02 BB 14 B7 FF C5 6D CE C7 B6 64 5C 41 05 C3 96 00 BA A0 78 50 E4 A0 7B FA 
95 A9 33 01 B6 34 73 AF 83 40 77 98 17 1A D1 76 81 C9 ED C9 21 31 AA 4E 86 EC F4 4D 76 7A F3 51 
0B DD 04 3D 77 21 45 47 5A E8 EC BA BB C6 EA 1B 93 80 38 BB 00 D8 7D 99 B0 4C B8 D5 00 52 9D E4 
AB 50 53 5F E2 75 44 2B 92 00 BA A0 78 50 E4 A0 F3 46 28 0E 55 2D 6B 79 63 D0 9D F9 D2 8B D0 5B 
96 BB 3D 59 6A E0 3B F2 6E 6A 69 05 40 ED F9 36 8D 88 DE 32 5F 23 E7 A8 9F 90 D2 58 07 40 9E 63 
17 74 39 6A 22 A0 5E FA 90 EB CD 25 AD 02 E8 82 9E 79 45 1B F4 12 00 40 8B 67 1D 77 D0 6B 13 9D 
99 DB 89 06 13 81 C4 EC 79 C7 BD 4E 02 5A 3D 23 3A 83 1A E8 05 5E EC 13 D9 72 70 F3 41 EB 1C D1 
23 26 E8 20 29 5B 02 A4 F6 1B 79 E5 E8 BD 51 7F C1 87 EF 79 A8 12 40 17 14 0F 8A 02 E8 1E 77 C3 
1A 95 00 AC F1 B8 9B E5 09 BA D8 03 74 A6 48 02 0C 5E 77 D3 92 97 F5 D1 49 BF DF 57 40 AF CF 02 
06 13 6C 42 4F E7 3B DE 4C 83 62 BC 5A 09 44 7C 48 D7 A7 A0 66 3D 82 3D 2D FC 1B E9 02 E8 82 E2 
41 D1 88 E8 3A 9A 17 29 42 0D 69 20 CE 5F EB EA 47 7B 80 5E 08 9C 4D 77 9A E6 D4 D5 72 B0 C6 EB 
D6 97 5A BE 6C D4 7D 08 35 E6 F3 7C 4D B4 43 5D F7 42 1A 1B 2A 81 0C 8B FD CD AA 01 D0 30 E8 5A 
21 23 21 DD 2C 07 05 46 35 00 0A 9B 8F 57 87 26 01 74 41 F1 A0 C8 41 17 2B 52 52 B1 92 53 FE FF 
F6 CE 6E BD 78 26 0A C3 A3 7E AA 45 35 F4 23 2A 69 12 1A 15 AA 4A 04 6D 94 D6 11 38 0D D7 DB 7D 
76 BA 61 CB 69 7F B3 26 91 22 54 4B 5A 57 75 DD DD 41 93 09 C6 33 B3 66 CD 33 13 96 64 2F B3 A9 
F5 B3 0B 27 3F C6 84 6E 47 D2 D7 05 27 19 D7 34 92 69 3A 40 E7 1B 8B 23 F4 27 7A 7A 7A 69 1E FD 
81 8E FB 85 15 42 7F E6 C9 1D 5C C6 F4 3B 79 F5 3A 3D 3D AB 49 7E E2 67 73 E9 F4 ED 65 21 B4 67 
B7 63 D9 0E 14 3A 72 08 EC 2E F4 77 2C 6D CB A7 2F F0 24 1E B3 D3 E4 2C EB 5E 51 54 4D FD D7 03 
D7 8B 60 29 BB 9C 61 E7 64 6E 16 0A 94 A9 50 03 D6 E4 98 EA C4 09 54 E8 83 96 FB 1E 2A 90 D9 3B 
81 6B D4 69 BC 9E B4 82 73 99 B6 24 A2 AA A6 AD CB E4 E2 44 1F 42 8C A0 AF 1A E1 7F 0E 14 3A 72 
08 78 28 F4 73 5B B3 F2 4D D8 7A 7E CC 5E 00 A1 77 2F 4E A3 D1 FB 36 B4 00 31 3B 8A 96 23 3C 78 
5B 88 3E 3F C7 2D 83 AD CE 8A E5 C7 C6 7D 8A 72 9F 1F 32 A1 97 DC 42 1F 1D CF 3A 72 DA 67 DB 52 
6E D2 A6 A4 A4 2A B9 01 E1 27 70 0B 46 22 DC 2A 66 97 74 B7 F7 C0 A2 D0 91 43 60 77 A1 27 A4 F1 
03 50 1B 3B 4B 56 2A E3 6A 9B A3 85 C7 73 9A 25 74 87 B8 E1 E4 E8 EB D7 E5 71 0E 8C AF 2D 27 2A 
1F 81 5D D5 8E F9 AB B3 53 AE 40 E8 DC 95 3B 74 BF 7A 99 0D 03 26 3C 21 61 F6 A8 A9 B3 94 BD D6 
86 9C 9F A9 93 73 1A B3 D7 74 12 6F B8 CE FE 2C 28 74 E4 10 F0 C0 30 B3 32 A3 FD 56 05 0D 43 46 
FE 5D E8 77 89 9E B4 74 5F E2 21 0D B2 DB B3 06 A2 0E BE 98 D9 4C D8 CD C0 3A 89 2B 29 63 78 D9 
2D 74 7A 74 B2 36 9A 4C 26 D3 72 2A 48 12 AC E4 11 4F 38 F0 D8 8A 1C 89 55 7A 84 A4 E8 69 6F 89 
55 A6 DA CF A2 55 B9 BD 54 0C 82 78 C9 F3 D6 0A 00 DC F3 E8 EF 4C E8 C8 F9 5C B0 84 1E CA 0D 4D 
F3 F9 61 E4 3E 6A 18 24 47 76 1A FE F6 82 CC CD BD 55 1E 25 93 22 F5 65 A5 EC A7 CD 89 6B 1D 7A 
8D 76 E3 7C 81 B9 EC 0B 7A D0 8E E2 47 5D E2 83 F7 53 6F 93 60 B6 40 7C 30 78 18 C5 76 31 BB 6B 
8D BB 7D D7 11 82 EC CC F6 59 2A E0 23 A1 2B 63 AA BE B4 9D 8C 5B BB 0B C5 B5 9F 9C 47 AC 87 E0 
9A CB AE C8 B9 31 E3 6C C8 B5 76 55 5C FA 24 61 38 75 14 20 03 D6 B5 67 83 C4 EF 23 61 68 5A 20 
C1 B7 BD D9 5D ED 04 F7 50 2D 08 E2 2D A5 4D 1B C1 7C C8 87 42 6F D2 2E B7 A0 2D CE A3 BB F8 17 
20 C1 28 7B D4 A2 82 12 56 E9 9C F9 DB 5E B2 4B AF C9 61 42 F4 64 DA 22 99 A0 4F 20 38 99 F8 C9 
80 8D 04 46 6C 59 AB 95 0D 0C 2F DB EF BF 82 9A DD 73 0D 21 88 07 F4 2A 9B 7F EB EB 71 3B E3 E6 
90 33 9F 10 7A 99 23 3E 66 99 95 A9 56 C3 6B 0C 6C 6F 01 42 BA 4B 53 E1 0D DA 8C 88 D3 32 E3 6D 
02 16 FB 3C 7D 75 7C 44 8E AC 4F 14 A5 1F 2E C4 32 FC 6A 74 D9 95 FB 15 8A 17 7B AE 21 04 F1 80 
F6 64 6B 09 28 76 32 6E A1 A9 B8 1D 3A 1D 3C D8 DE 53 CA 4A A1 AB B3 9E 1B D6 A5 F1 CC AE 7A C5 
91 B3 75 EF A5 08 61 7A C1 99 22 AB 4C 55 26 E4 B3 B2 73 04 34 13 05 3A 8C 37 07 C4 6F BD 9F 47 
DE D9 6F 22 0F B6 99 6D 99 26 F6 5C 43 08 E2 05 FD CD BF F5 F5 80 D0 75 A1 65 D1 E9 34 46 CA 50 
4F 76 72 8F 4F 93 B1 24 D0 E0 39 60 AE 16 BA 14 69 49 4F A3 E9 43 15 FA 5D C8 8C 2B 15 AA A7 50 
2B 57 05 1A A5 E7 A5 AE 1D 9C AD E4 52 A8 D6 CA AF FD 9C 78 F1 DF 84 1D 3F 3F A0 A7 23 E9 AE C4 
2C 32 01 BB E1 B9 B9 EA D8 B1 46 76 17 A1 57 33 FB AE 21 04 F1 80 55 96 B3 4F 53 39 5E 28 8B CB 
B1 14 D9 20 91 4E B6 99 3E 44 75 A5 D0 B5 08 ED C7 D3 C7 C9 04 CC 5C 85 D8 46 50 75 9E 04 7D 3E 
8E 71 47 D2 E5 A5 0B 8D 98 07 C7 17 8A C5 42 03 1A A5 9B 30 6C 0F CE BB 60 FA 71 DA 62 68 B0 CC 
25 E0 1A 8C 08 BB 2C 5F 8B FE 78 8D 20 C8 37 10 DE 7E BD 87 65 2D 9F A7 A5 48 FC FB 33 5D 9C F5 
D5 89 C5 71 BC 16 71 8E 79 39 1D 5A 25 2D CC 56 F3 B5 E5 2B C9 E2 7C C1 63 85 6D 6D 33 F7 7F F0 
DA 74 9B B0 E3 0C E7 12 3A ED D1 2F B6 FD 84 B7 A1 EF F8 D2 11 E4 A7 09 DC 6C FE B5 AF A5 58 35 
B2 73 F4 C6 8A 26 09 F9 E4 D9 65 97 4F A4 B2 26 0B 16 8A 25 23 5B 5A 0C C5 B5 A1 10 49 EB DD 4B 
3D 9D 6F D9 7D 7D 51 9C 2B C9 68 AD 48 F0 49 42 2A 91 09 64 CE D2 79 41 BA D5 1A 46 DE 9C 9F 30 
D0 FA 86 21 36 15 B3 67 88 AE 19 77 D3 30 B6 B6 C0 E6 E2 FB AE 20 04 F1 84 F4 DA 8C F8 B6 D4 6B 
92 64 BE AA CA 87 83 02 B9 2F 81 19 E6 2B 68 6F B4 DC 9A AC 7C 5C B0 A7 34 63 1B BF 3F 04 F9 1D 
EC D2 A5 1F 3A 1D EC D0 91 43 21 B6 9C F9 42 66 C0 EE B3 08 72 18 04 F3 3F 7D 3F B3 DF 42 25 B2 
F9 DB 43 90 5F C3 AA ED 5B 10 A5 68 EC BB 62 10 C4 4B 2E B7 5F AE 7D C8 34 06 FB AE 18 04 F1 14 
7F 07 A3 F7 65 2A 57 98 88 43 0E 8D 78 CF F3 49 B6 5F 8E 6C E0 86 13 C8 01 12 7E C0 4E FD 9D A2 
79 B2 F9 2B 43 90 5F 08 2F 4C 30 27 67 A1 BD F6 8E F6 5D 1D 08 F2 5D 9C 89 E3 26 6A BD D8 AC 89 
B8 62 0D 39 68 8E 0A E2 70 DA AC D7 EB 95 BF 48 BD 2E 37 A7 C3 5E DB 87 9B 47 21 87 CE 39 C7 C7 
4E 52 D1 D3 3F F9 97 3A 69 67 38 54 39 82 20 08 82 20 08 82 20 08 82 20 7F 95 FF 01 48 45 9D A0 
03 60 72 3B 00 00 00 00 49 45 4E 44 AE 42 60 82 
EndData
$EndBitmap
Wire Wire Line
	22150 18750 22050 18750
Wire Wire Line
	22050 18750 22050 19500
Wire Wire Line
	24600 3500 25350 3500
Text Label 24750 3400 0    40   ~ 0
ABUS_3V_A3
Wire Wire Line
	22450 4800 23200 4800
Text Label 22650 5800 0    40   ~ 0
SSEL_3V
$Comp
L Device:LED D3
U 1 1 600B58C6
P 25250 11300
F 0 "D3" V 25288 11183 50  0000 R CNN
F 1 "LED" V 25197 11183 50  0000 R CNN
F 2 "LED_THT:LED_D3.0mm" H 25250 11300 50  0001 C CNN
F 3 "~" H 25250 11300 50  0001 C CNN
	1    25250 11300
	0    -1   -1   0   
$EndComp
Wire Wire Line
	15400 9400 15400 9250
Wire Wire Line
	15400 9400 16350 9400
Wire Wire Line
	15100 9050 14450 9050
Wire Wire Line
	15700 9050 16550 9050
Text Label 14900 9050 2    40   ~ 0
+5V_SATURN
Text Label 16250 9050 2    40   ~ 0
+5V_USB
Text Label 3550 2100 2    40   ~ 0
+5V_SATURN
Text Label 6250 2650 2    40   ~ 0
+5V_SATURN
Text Label 8600 1600 2    40   ~ 0
+5V_SATURN
Text Label 7650 5550 2    40   ~ 0
+5V_SATURN
Text Label 7650 10500 2    40   ~ 0
+5V_SATURN
Text Label 2850 14300 2    40   ~ 0
+5V_SATURN
Text Label 2800 16200 2    40   ~ 0
+5V_SATURN
Text Label 7100 17300 2    40   ~ 0
+5V_SATURN
Text Label 7100 15900 2    40   ~ 0
+5V_SATURN
Text Label 7100 14450 2    40   ~ 0
+5V_SATURN
Text Label 15300 17300 2    40   ~ 0
+5V_USB
Text Label 20350 18650 2    40   ~ 0
+5V_SYS
Text Label 12650 17250 2    40   ~ 0
+5V_USB
Text Label 13500 17250 2    40   ~ 0
VBUS_SENSE
Wire Wire Line
	22400 9700 23200 9700
Text Label 22950 9700 2    40   ~ 0
VBUS_SENSE
$Comp
L Diode:BAT54C D4
U 1 1 61164E19
P 15400 9050
F 0 "D4" H 15400 9275 50  0000 C CNN
F 1 "BAT54C" H 15400 9184 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 15475 9175 50  0001 L CNN
F 3 "http://www.diodes.com/_files/datasheets/ds11005.pdf" H 15320 9050 50  0001 C CNN
	1    15400 9050
	1    0    0    -1  
$EndComp
Wire Wire Line
	25250 10600 25250 11150
Wire Wire Line
	24600 10700 25100 10700
Wire Wire Line
	24600 10100 25100 10100
Text Label 13700 12250 2    40   ~ 0
+5V_SYS
$Comp
L Device:R R16
U 1 1 5FD33C50
P 29050 16850
F 0 "R16" V 29130 16850 50  0000 C CNN
F 1 "33K" V 29050 16850 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 28980 16850 30  0001 C CNN
F 3 "" H 29050 16850 30  0000 C CNN
	1    29050 16850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R15
U 1 1 5FD34669
P 28850 16850
F 0 "R15" V 28930 16850 50  0000 C CNN
F 1 "33K" V 28850 16850 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 28780 16850 30  0001 C CNN
F 3 "" H 28850 16850 30  0000 C CNN
	1    28850 16850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R9
U 1 1 5FE1459F
P 28650 16850
F 0 "R9" V 28730 16850 50  0000 C CNN
F 1 "33K" V 28650 16850 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 28580 16850 30  0001 C CNN
F 3 "" H 28650 16850 30  0000 C CNN
	1    28650 16850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 5FEF44DC
P 28450 16850
F 0 "R8" V 28530 16850 50  0000 C CNN
F 1 "33K" V 28450 16850 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 28380 16850 30  0001 C CNN
F 3 "" H 28450 16850 30  0000 C CNN
	1    28450 16850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R17
U 1 1 5FFD4422
P 29250 16850
F 0 "R17" V 29330 16850 50  0000 C CNN
F 1 "33K" V 29250 16850 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 29180 16850 30  0001 C CNN
F 3 "" H 29250 16850 30  0000 C CNN
	1    29250 16850
	1    0    0    -1  
$EndComp
Text Label 27850 16700 0    40   ~ 0
+3_3V
Wire Wire Line
	27850 16700 28450 16700
Connection ~ 28450 16700
Wire Wire Line
	28450 16700 28650 16700
Connection ~ 28650 16700
Wire Wire Line
	28650 16700 28850 16700
Connection ~ 28850 16700
Wire Wire Line
	28850 16700 29050 16700
Connection ~ 29050 16700
Wire Wire Line
	29050 16700 29250 16700
Wire Wire Line
	29250 17000 29250 17200
Connection ~ 29250 17200
Wire Wire Line
	29250 17200 29700 17200
Wire Wire Line
	29050 17000 29050 17300
Wire Wire Line
	28700 17300 29050 17300
Connection ~ 29050 17300
Wire Wire Line
	29050 17300 29700 17300
Wire Wire Line
	28850 17000 28850 17400
Connection ~ 28850 17400
Wire Wire Line
	28850 17400 29700 17400
Wire Wire Line
	28650 17000 28650 17800
Wire Wire Line
	28650 17800 29700 17800
Wire Wire Line
	28450 17000 28450 17900
Wire Wire Line
	28450 17900 29700 17900
$Comp
L wasca:TFP09-2-12B CN2
U 1 1 60B5BB63
P 30550 17550
F 0 "CN2" H 30525 18317 50  0000 C CNN
F 1 "TFP09-2-12B" H 30525 18226 50  0000 C CNN
F 2 "wasca:TFP09212B" H 32200 17650 50  0001 L CNN
F 3 "http://images.100y.com.tw/pdf_file/10-TFP09-2-12B.pdf" H 32200 17550 50  0001 L CNN
F 4 "Micro SD Card Connector" H 32200 17450 50  0001 L CNN "Description"
F 5 "2.45" H 32200 17350 50  0001 L CNN "Height"
F 6 "100y" H 32200 17250 50  0001 L CNN "Manufacturer_Name"
F 7 "TFP09-2-12B" H 32200 17150 50  0001 L CNN "Manufacturer_Part_Number"
	1    30550 17550
	1    0    0    -1  
$EndComp
Wire Wire Line
	31400 18000 31550 18000
Wire Wire Line
	31550 18000 31550 18100
Wire Wire Line
	31400 18200 31550 18200
Connection ~ 31550 18200
Wire Wire Line
	31550 18200 31550 18350
Wire Wire Line
	31400 18100 31550 18100
Connection ~ 31550 18100
Wire Wire Line
	31550 18100 31550 18200
$Comp
L segata:LOGO SEGATA1
U 1 1 5FF1DCB3
P 1850 20000
F 0 "SEGATA1" H 1850 18153 60  0001 C CNN
F 1 "LOGO" H 1850 21847 60  0001 C CNN
F 2 "wasca:Segata_Sanshiro" H 1850 20000 50  0001 C CNN
F 3 "" H 1850 20000 50  0001 C CNN
	1    1850 20000
	1    0    0    -1  
$EndComp
$Comp
L wasca:KICAD_LOGO KICAD1
U 1 1 5FF2449A
P 16650 7200
F 0 "KICAD1" H 16978 7246 50  0000 L CNN
F 1 "KICAD_LOGO" H 16978 7155 50  0000 L CNN
F 2 "wasca:DESIGNED_WITH_KICAD_10X05" H 16650 7200 50  0001 C CNN
F 3 "" H 16650 7200 50  0001 C CNN
	1    16650 7200
	1    0    0    -1  
$EndComp
$Comp
L Device:R R18
U 1 1 5FE58528
P 21850 7100
F 0 "R18" V 21930 7100 50  0000 C CNN
F 1 "470" V 21850 7100 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 21780 7100 30  0001 C CNN
F 3 "" H 21850 7100 30  0000 C CNN
	1    21850 7100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR089
U 1 1 5FE5852F
P 21850 7250
F 0 "#PWR089" H 21850 7000 50  0001 C CNN
F 1 "GND" H 21850 7100 50  0001 C CNN
F 2 "" H 21850 7250 60  0000 C CNN
F 3 "" H 21850 7250 60  0000 C CNN
	1    21850 7250
	1    0    0    -1  
$EndComp
Wire Wire Line
	21850 6750 21850 6950
$Comp
L Device:LED D5
U 1 1 5FE58536
P 21850 6600
F 0 "D5" V 21888 6483 50  0000 R CNN
F 1 "LED" V 21797 6483 50  0000 R CNN
F 2 "LED_THT:LED_D3.0mm" H 21850 6600 50  0001 C CNN
F 3 "~" H 21850 6600 50  0001 C CNN
	1    21850 6600
	0    -1   -1   0   
$EndComp
Wire Wire Line
	21850 5900 21850 6450
Wire Wire Line
	21850 5900 23200 5900
Text Label 22050 5900 0    40   ~ 0
HEARTBEAT
$Comp
L Connector_Generic:Conn_02x02_Odd_Even CN3
U 1 1 6001F517
P 13150 12150
F 0 "CN3" H 13200 12367 50  0000 C CNN
F 1 "Conn_02x02_Odd_Even" H 13200 12276 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x02_P2.54mm_Vertical" H 13150 12150 50  0001 C CNN
F 3 "~" H 13150 12150 50  0001 C CNN
	1    13150 12150
	1    0    0    -1  
$EndComp
$Comp
L vache:LOGO VACHE1
U 1 1 60BA9417
P 3050 21800
F 0 "VACHE1" H 3050 21464 60  0001 C CNN
F 1 "LOGO" H 3050 22136 60  0001 C CNN
F 2 "wasca:LOGO_VACHE_SIM" H 3050 21800 50  0001 C CNN
F 3 "" H 3050 21800 50  0001 C CNN
	1    3050 21800
	1    0    0    -1  
$EndComp
$Comp
L Device:R R19
U 1 1 5FDF3779
P 22950 11150
F 0 "R19" V 23030 11150 50  0000 C CNN
F 1 "470" V 22850 11150 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" V 22880 11150 30  0001 C CNN
F 3 "" H 22950 11150 30  0000 C CNN
	1    22950 11150
	-1   0    0    -1  
$EndComp
Wire Wire Line
	22550 10600 22550 10800
Wire Wire Line
	22750 10700 22750 10900
Wire Wire Line
	23200 10800 22950 10800
Wire Wire Line
	22950 10800 22950 11000
Text Label 23000 10800 0    40   ~ 0
LEDB
Wire Wire Line
	24600 7700 25350 7700
Text Label 24800 7700 0    40   ~ 0
DBG_UART_TX
Wire Wire Line
	24600 7800 25350 7800
Text Label 24800 7800 0    40   ~ 0
DBG_UART_RX
$Comp
L Device:LED_BCGR D1
U 1 1 6147A2B8
P 22750 11550
F 0 "D1" V 22796 11220 50  0000 R CNN
F 1 "LED_BCGR" V 22705 11220 50  0000 R CNN
F 2 "LED_THT:LED_D5.0mm-4_RGB" H 22750 11500 50  0001 C CNN
F 3 "~" H 22750 11500 50  0001 C CNN
	1    22750 11550
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED_RGB D2
U 1 1 6149E2CF
P 21650 11550
F 0 "D2" V 21696 11220 50  0000 R CNN
F 1 "LED_RGB" V 21605 11220 50  0000 R CNN
F 2 "LED_SMD:LED_RGB_5050-6" H 21650 11500 50  0001 C CNN
F 3 "~" H 21650 11500 50  0001 C CNN
	1    21650 11550
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 61B36588
P 21850 11750
F 0 "#PWR0102" H 21850 11500 50  0001 C CNN
F 1 "GND" H 21850 11600 50  0001 C CNN
F 2 "" H 21850 11750 60  0000 C CNN
F 3 "" H 21850 11750 60  0000 C CNN
	1    21850 11750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 61C25E80
P 21650 11750
F 0 "#PWR0103" H 21650 11500 50  0001 C CNN
F 1 "GND" H 21650 11600 50  0001 C CNN
F 2 "" H 21650 11750 60  0000 C CNN
F 3 "" H 21650 11750 60  0000 C CNN
	1    21650 11750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0104
U 1 1 61D1577B
P 21450 11750
F 0 "#PWR0104" H 21450 11500 50  0001 C CNN
F 1 "GND" H 21450 11600 50  0001 C CNN
F 2 "" H 21450 11750 60  0000 C CNN
F 3 "" H 21450 11750 60  0000 C CNN
	1    21450 11750
	1    0    0    -1  
$EndComp
Wire Wire Line
	22550 11100 22550 11350
Wire Wire Line
	22750 11200 22750 11350
Wire Wire Line
	22950 11300 22950 11350
Wire Wire Line
	22950 11300 21850 11300
Wire Wire Line
	21850 11300 21850 11350
Connection ~ 22950 11300
Wire Wire Line
	22750 11200 21650 11200
Wire Wire Line
	21650 11200 21650 11350
Connection ~ 22750 11200
Wire Wire Line
	22550 11100 21450 11100
Wire Wire Line
	21450 11100 21450 11350
Connection ~ 22550 11100
Text Notes 21300 12100 0    60   ~ 0
ONLY 1 OF THE RGB LEDS SHOULD BE PLACED
$Comp
L Connector:USB_C_Receptacle_USB2.0 CN6
U 1 1 600FABF6
P 10700 17850
F 0 "CN6" H 10807 18717 50  0000 C CNN
F 1 "USB_C_Receptacle_USB2.0" H 10807 18626 50  0000 C CNN
F 2 "wasca:DX07S016JA1R1500" H 10850 17850 50  0001 C CNN
F 3 "https://www.usb.org/sites/default/files/documents/usb_type-c.zip" H 10850 17850 50  0001 C CNN
	1    10700 17850
	1    0    0    -1  
$EndComp
Wire Wire Line
	11300 17250 12650 17250
Wire Wire Line
	10400 18750 10400 18800
Wire Wire Line
	10400 18800 10700 18800
Wire Wire Line
	10700 18800 10700 18750
Wire Wire Line
	10700 18900 10700 18800
Connection ~ 10700 18800
Wire Wire Line
	11400 17750 11400 17850
Connection ~ 11400 17850
Wire Wire Line
	11400 17850 13650 17850
Wire Wire Line
	11300 17750 11400 17750
Wire Wire Line
	11400 18050 11400 17950
Connection ~ 11400 17950
Wire Wire Line
	11400 17950 13650 17950
Wire Wire Line
	11300 18050 11400 18050
$Comp
L Device:R R20
U 1 1 609A0C4E
P 11700 17450
F 0 "R20" V 11780 17450 50  0000 C CNN
F 1 "5K1" V 11700 17450 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" V 11630 17450 30  0001 C CNN
F 3 "" H 11700 17450 30  0000 C CNN
	1    11700 17450
	0    1    -1   0   
$EndComp
$Comp
L power:GND #PWR0105
U 1 1 60A97828
P 12050 17500
F 0 "#PWR0105" H 12050 17250 50  0001 C CNN
F 1 "GND" H 12050 17350 50  0001 C CNN
F 2 "" H 12050 17500 60  0000 C CNN
F 3 "" H 12050 17500 60  0000 C CNN
	1    12050 17500
	1    0    0    -1  
$EndComp
Wire Wire Line
	12050 17450 12050 17500
Wire Wire Line
	11850 17450 12050 17450
Wire Wire Line
	11550 17450 11400 17450
Wire Wire Line
	11300 17550 11400 17550
Wire Wire Line
	11400 17550 11400 17450
Connection ~ 11400 17450
Wire Wire Line
	11400 17450 11300 17450
Text Notes 10300 16700 0    39   ~ 0
Compatible connectors:\nJAE DX07S016JA1R1500\nJAE DX07S016JA3R1500\nHROPARTS TYPE-C-31-M-12\nHROPARTS TYPE-C-31-M-14\nXKB U262-161N-4BVC11\nJing Ext. C167321
Wire Notes Line
	10200 16200 10200 16750
Wire Notes Line
	10200 16750 11300 16750
Wire Notes Line
	11300 16750 11300 16200
Wire Notes Line
	11300 16200 10200 16200
$Comp
L esp32-devkitc:ESP32_CAM_HALF U13
U 1 1 612CF960
P 22950 19000
F 0 "U13" H 23580 19021 50  0000 L CNN
F 1 "ESP32_CAM_HALF" H 23580 18930 50  0000 L CNN
F 2 "wasca:MODULE_ESP32-CAM-HALF" H 22900 18450 50  0001 C CNN
F 3 "" H 22900 18450 50  0001 C CNN
	1    22950 19000
	1    0    0    -1  
$EndComp
Text Notes 29500 16500 0    39   ~ 0
Compatible connectors:\nHroparts TF-01A\nSOFNG TF-15x15\nSOFNG TF-015\nXUNPU TF-115K\nXUNPU TF-109\nHOAUC HYC77-TF09-200
Wire Notes Line
	29400 16000 29400 16550
Wire Notes Line
	29400 16550 30500 16550
Wire Notes Line
	30500 16550 30500 16000
Wire Notes Line
	30500 16000 29400 16000
Text Notes 30750 16450 0    39   ~ 0
Partially compatible\n(signals only)\n\nHirose DM3AT-SF-PEJM5\nKyocera 045138008100858+\nYamaichi PJS008-4100-0-VE
Wire Notes Line
	30650 16000 30650 16550
Wire Notes Line
	30650 16550 31750 16550
Wire Notes Line
	31750 16550 31750 16000
Wire Notes Line
	31750 16000 30650 16000
$Comp
L wasca:CHAMFER_WARNING CHAMFER_WARN1
U 1 1 617D53EE
P 15800 7700
F 0 "CHAMFER_WARN1" H 16228 7721 50  0000 L CNN
F 1 "CHAMFER_WARNING" H 16228 7630 50  0000 L CNN
F 2 "wasca:CHAMFER_WARNING" H 15750 7600 50  0001 C CNN
F 3 "" H 15750 7600 50  0001 C CNN
	1    15800 7700
	1    0    0    -1  
$EndComp
$Comp
L wasca:CHAMFER_WARNING CHAMFER_WARN2
U 1 1 618E2958
P 17600 7750
F 0 "CHAMFER_WARN2" H 18028 7771 50  0000 L CNN
F 1 "CHAMFER_WARNING" H 18028 7680 50  0000 L CNN
F 2 "wasca:CHAMFER_WARNING" H 17550 7650 50  0001 C CNN
F 3 "" H 17550 7650 50  0001 C CNN
	1    17600 7750
	1    0    0    -1  
$EndComp
$Comp
L Device:R R21
U 1 1 5FEDA19E
P 4050 16850
F 0 "R21" V 4130 16850 50  0000 C CNN
F 1 "0" V 3950 16850 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" V 3980 16850 30  0001 C CNN
F 3 "" H 4050 16850 30  0000 C CNN
	1    4050 16850
	0    1    -1   0   
$EndComp
Wire Wire Line
	3700 16850 3900 16850
Wire Wire Line
	4200 16850 5200 16850
Text Label 25050 9800 0    40   ~ 0
SSEL_3V
Wire Wire Line
	24600 9800 25600 9800
Text Label 22850 10000 0    40   ~ 0
JTAG_TDO
Wire Wire Line
	22800 10000 23200 10000
Wire Wire Line
	24600 10800 25000 10800
Text Label 24700 10800 0    40   ~ 0
JTAG_TDI
Text Label 24750 10100 0    40   ~ 0
JTAG_TCK
Text Label 24750 10700 0    40   ~ 0
JTAG_TMS
Wire Wire Line
	10150 1900 10850 1900
Wire Wire Line
	10150 3000 10850 3000
Wire Wire Line
	9200 5850 10800 5850
Wire Wire Line
	9200 6950 10800 6950
$Comp
L power:GND #PWR0106
U 1 1 610023A1
P 7700 6050
F 0 "#PWR0106" H 7700 5800 50  0001 C CNN
F 1 "GND" H 7700 5900 50  0001 C CNN
F 2 "" H 7700 6050 60  0000 C CNN
F 3 "" H 7700 6050 60  0000 C CNN
	1    7700 6050
	1    0    0    -1  
$EndComp
Text Label 9400 5950 0    40   ~ 0
BUFFERS_OE
Wire Wire Line
	9200 5950 9950 5950
Text Label 9400 7050 0    40   ~ 0
BUFFERS_OE
Wire Wire Line
	9200 7050 9950 7050
Text Label 10350 2000 0    40   ~ 0
BUFFERS_OE
Wire Wire Line
	10150 2000 10900 2000
Text Label 10350 3100 0    40   ~ 0
BUFFERS_OE
Wire Wire Line
	10150 3100 10900 3100
Text Label 9400 10900 0    40   ~ 0
BUFFERS_OE
Wire Wire Line
	9200 10900 9950 10900
Text Label 9400 12000 0    40   ~ 0
BUFFERS_OE
Wire Wire Line
	9200 12000 9950 12000
Text Label 24800 7900 0    40   ~ 0
BUFFERS_OE
Wire Wire Line
	24600 7900 25350 7900
$Comp
L Device:R R24
U 1 1 619FFABF
P 25750 8000
F 0 "R24" V 25830 8000 50  0000 C CNN
F 1 "470" V 25650 8000 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" V 25680 8000 30  0001 C CNN
F 3 "" H 25750 8000 30  0000 C CNN
	1    25750 8000
	0    1    -1   0   
$EndComp
Wire Wire Line
	25600 8000 24600 8000
Wire Wire Line
	25900 8000 26800 8000
Text Label 26600 8000 2    40   ~ 0
+5V_SATURN
Text Label 25250 8000 2    40   ~ 0
5V_SATURN_DETECT
$Comp
L Connector:SODIMM-200 CN4
U 1 1 61FE67FC
P 28650 6650
F 0 "CN4" H 28650 7815 50  0000 C CNN
F 1 "SODIMM-200" H 28650 7724 50  0000 C CNN
F 2 "wasca:Conn_TE-DDR2-SODIMM-0.6-200P-doublesided" H 30050 10500 50  0001 C CNN
F 3 "~" H 30050 10500 50  0001 C CNN
	1    28650 6650
	1    0    0    -1  
$EndComp
$Comp
L Connector:SODIMM-200 CN4
U 2 1 61FEDFB1
P 23900 6800
F 0 "CN4" H 23900 10965 50  0000 C CNN
F 1 "SODIMM-200" H 23900 10874 50  0000 C CNN
F 2 "wasca:Conn_TE-DDR2-SODIMM-0.6-200P-doublesided" H 25300 10650 50  0001 C CNN
F 3 "~" H 25300 10650 50  0001 C CNN
	2    23900 6800
	1    0    0    -1  
$EndComp
Text Notes 21850 10200 0    60   ~ 0
5V Tolerant pin
Wire Bus Line
	2150 1400 2150 5850
Wire Bus Line
	6200 8300 6200 10600
Wire Bus Line
	3150 8300 3150 10600
Wire Bus Line
	6850 10600 6850 12900
Wire Bus Line
	6850 5350 6850 7750
Wire Bus Line
	6200 5450 6200 7500
Wire Bus Line
	2950 5850 2950 7700
Wire Bus Line
	7800 1400 7800 3800
Text Notes 23800 2250 0    50   ~ 0
MFG P/N : \n1473005-4\n1565917-4
$EndSCHEMATC
