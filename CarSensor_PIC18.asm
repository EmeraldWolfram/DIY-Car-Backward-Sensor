	LIST P=18F4520, F=INHX8M	;directive to define processor
	#include <P18F4520.INC>	;processor specific variable definitions

	CONFIG	OSC = HS		;Crystal frequency 4MHz
	CONFIG	WDT = OFF		;Disable Watchdog Timer

;DECLARATION************************************
;Constant for easy reading in later program
buzzer	EQU	0x00			;Port B,RA0
green	EQU	0x01			;Port B,RA1
sensor  EQU	0x02			;Port B, RB2/AN8
R6  	EQU	0x06			;To store waiting time
;START**************************************
	ORG		0000H
	GOTO	MAIN
;INTERRUPT***********************************
	ORG		0008H
	BTFSC	PIR1,ADIF   ;Check for ADC intterupt
	RCALL	ADC_ISR
	RETFIE
  
MAIN
;I/O CONFIGURATION************************
	ORG		0100H
	BCF		TRISB,buzzer
	BCF		TRISB,green
	BSF		TRISB,sensor
	BCF   INTCON2,RBPU        ;activate internal pull-up
;ANALOGUE/DIGITAL CONFIGURATION*******
  BCF   ADCON1, PCFG3
  BSF   ADCON1, PCFG2
  BSF   ADCON1, PCFG1
  BCF   ADCON1, PCFG0
;ENABLE INTERRUPT****************************
  BCF   PIR1,ADIF
	BSF		PIE1,ADIE
	BSF		INTCON,GIE
  BSF   INTCON,PEIE
;ADC Configuration***************************
  CLRF  ADCON0
  CLRF  ADCON2
  BSF   ADCON0, CHS3        ;AN8 as input
  BCF   ADCON2, ADFM        ;Left justified
  BSF   ADCON2, ADCS2       ;ADC Clock, TAD = Fosc/4
;TIMER CONFIGURATION****************************
	MOVLW	0x47
	MOVWF	T0CON               ;Prescale (Fosc/4) 1 : 256 with 8-bit counter
	RCALL	ONGRN
;MAIN FUNCTION
INFN
  BSF ADCON0,ADON
  BSF ADCON0,GO_DONE
  BRA INFN
  
  
  
;DELAY with Converted time***********************************
DELAY
	ORG		0320H
	MOVFF	R6,TMR0L
	BCF		INTCON,TMR0IF
	BSF		T0CON,TMR0ON
LOP	BTFSS	INTCON,TMR0IF
	BRA		LOP
	BCF		INTCON,TMR0IF
	BCF		T0CON,TMR0ON
	RETURN
  
;ADC_ISR************************************
ADC_ISR
	ORG		0460H
	MOVFF	ADRESH,R6
  	MOVLW   0x8F        ;Assume 0x8F is 2 meter range converted value
  	CPFSGT  R6
  	RETFIE
  	RCALL   SOUND
  	RCALL   DELAY
  	BCF     ADCON0,GO_DONE
  	BCF     ADCON0,ADON
	BCF		PIR1,ADIF
	RETFIE
;ACTIVATE BUZZER FOR 1/5 SEC*************
SOUND
	ORG		0550H
	MOVLW	0xFF
	MOVWF	TMR0L
	BTG		PORTA,buzzer
	BCF		INTCON,TMR0IF
	BSF		T0CON,TMR0ON
LOP_2
	BTFSS	INTCON,TMR0IF
	BRA		LOP_2
	RETURN
;LED CONTROL***********************************
ONGRN
	ORG		0600H
	BCF		PORTB,green
	RETURN
  
OFFGRN
  ORG   0610H
  BSF   PORTB,green
  RETURN
	END