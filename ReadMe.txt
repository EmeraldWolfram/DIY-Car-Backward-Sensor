This is a DIY project for a car backward sensor.

Follow this steps.

1. Connect the circuit as shown in CircuitBuild.jpg
2. Connect the circuit as shown in ArduinoAsPIC18_Programmer_ICD3
3. Upload the program to the PIC

Due to equipment limitation, PIC18F4520 was used. (A less powerful PIC is recommended as many pin wasted here)
Program was written in Assembly.

UPLOAD THE PROGRAM TO THE PIC
   The hex code can be downloaded to the PIC through the Arduino by: (As I don't have ICD)
   1. Upload the the code in ArduinoToPIC to the Arduino.
   2. Generate a hex file for CarSensor_PIC18.asm
   3. Double click the ComputerToArduino.exe and type in my hex file name (CarSensor_PIC18.hex)
