# MPLAB IDE generated this makefile for use with GNU make.
# Project: CarSensor_PIC18.mcp
# Date: Sat Feb 06 19:34:46 2016

AS = MPASMWIN.exe
CC = 
LD = mplink.exe
AR = mplib.exe
RM = rm

CarSensor.cof : CarSensor.o
	$(CC) /p18F4520 "CarSensor.o" /u_DEBUG /z__MPLAB_BUILD=1 /z__MPLAB_DEBUG=1 /o"CarSensor.cof" /M"CarSensor.map" /W /x

CarSensor.o : CarSensor.asm ../../../../../Program\ Files\ (x86)/Microchip/MPASM\ Suite/P18F4520.INC
	$(AS) /q /p18F4520 "CarSensor.asm" /l"CarSensor.lst" /e"CarSensor.err" /d__DEBUG=1

clean : 
	$(CC) "CarSensor.o" "CarSensor.hex" "CarSensor.err" "CarSensor.lst" "CarSensor.cof"

