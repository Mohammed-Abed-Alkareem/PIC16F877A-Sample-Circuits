        LIST      P=16F877A
        INCLUDE   <P16F877A.INC>         ; SFR definitions for PIC16F877A

;---------------------------------------------------------------------
;  CONFIGURATION BITS
;---------------------------------------------------------------------
        __CONFIG  0x3F7A     ; HS Oscillator, WDT OFF, LVP OFF, PBOR ON

;---------------------------------------------------------------------
;  VARIABLE DEFINITIONS
;---------------------------------------------------------------------
        CBLOCK  0x20
digit           ; Holds the current digit (0 to 9)
OverflowCount   ; Counter for 3-second delay
        ENDC

;---------------------------------------------------------------------
;  RESET VECTOR
;---------------------------------------------------------------------
        ORG     0x0000
        GOTO    Start

;---------------------------------------------------------------------
;  INTERRUPT VECTOR (not used here, but must exist)
;---------------------------------------------------------------------
        ORG     0x0004
        RETFIE
	
	
;-----------------------------------------------
	; temp
;-----------------------------
	
TEMP	EQU 0x75		; Temp store
TEMP2	EQU 0x76		; Temp2 store

;---------------------------------------------------------------------
;  MAIN PROGRAM
;---------------------------------------------------------------------
Start:
        ;--- Disable analog inputs ---
        BANKSEL ADCON1
        MOVLW   0x06       ; All pins digital
        MOVWF   ADCON1

        ;--- Set PORTC as output ---
        BANKSEL TRISC
        CLRW
        MOVWF   TRISC      ; TRISC = 0, all bits are outputs

        ;--- Clear PORTC ---
        BANKSEL PORTC
        CLRF    PORTC      ; Turn off all segments

        ;--- Initialize digit variable ---
        BANKSEL digit
        CLRF    digit      ; Start with digit = 0

        ;--- Configure Timer1 ---
        BANKSEL T1CON
        MOVLW   0x31       ; Prescaler 1:8, Timer1 ON
        MOVWF   T1CON

MainLoop:
        ;--- Display the current digit ---
        BANKSEL digit
        MOVF    digit, W       ; W = digit (0..9)
        CALL    DigitTable     ; Get the segment pattern for the digit
        BANKSEL PORTC
        MOVWF   PORTC          ; Output the pattern to PORTC

        ;--- Delay for 1 seconds ---
        ; delay 10ms * 100 = 1 s
	MOVLW 0x64
	CALL DELAY_W_10_MS

        ;--- Increment digit ---
        BANKSEL digit
        INCF    digit, F       ; Increment digit

        ;--- Check and reset if digit == 10 ---
        MOVLW   b'00001010'
        SUBWF   digit, W       ; Compare digit with 10
        BTFSC   STATUS, Z      ; If Z flag is set (digit == 10), reset
        CLRF    digit          ; Reset digit to 0 if it reached 10

        ;--- Loop back to display the next digit ---
        GOTO    MainLoop

;---------------------------------------------------------------------
;  DIGIT TABLE: 7-segment codes for digits 0 to 9 (common-cathode)
;---------------------------------------------------------------------
DigitTable:
        ADDWF   PCL, F
        RETLW   b'00111111'  ; 0
        RETLW   b'00000110'  ; 1
        RETLW   b'01011011'  ; 2
        RETLW   b'01001111'  ; 3
        RETLW   b'01100110'  ; 4
        RETLW   b'01101101'  ; 5
        RETLW   b'01111101'  ; 6
        RETLW   b'00000111'  ; 7
        RETLW   b'01111111'  ; 8
        RETLW   b'01101111'  ; 9
	

	
	; instruction delay of 10us * W (each instruction is 1us)
DELAY_W	
	MOVWF	TEMP
    loop_start

	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP

	DECFSZ	TEMP
	GOTO	loop_start
	RETURN
	
; instruction delay of ms * W (each loop is 10ms)
DELAY_W_10_MS	
	MOVWF	TEMP2
	MOVLW	0xFA
    lp_st
    
	CALL DELAY_W
	CALL DELAY_W
	CALL DELAY_W
	CALL DELAY_W

	DECFSZ	TEMP2
	GOTO	lp_st
	RETURN
	
	
;---------------------------------------------------------------------
;  END OF PROGRAM
;---------------------------------------------------------------------
        END