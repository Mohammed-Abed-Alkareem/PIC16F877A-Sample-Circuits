        LIST      P=16F877A
        INCLUDE   <P16F877A.INC>         ; SFR definitions for PIC16F877A

;---------------------------------------------------------------------
;  CONFIGURATION BITS
;---------------------------------------------------------------------
        __CONFIG  0x3F7A     ; HS Oscillator, WDT OFF, LVP OFF, PBOR ON

;---------------------------------------------------------------------
;  VARIABLE DEFINITIONS
;---------------------------------------------------------------------
LED     EQU 0x20        ; LED position store
TEMP    EQU 0x21        ; Temporary storage
TEMP2   EQU 0x22        ; Temporary storage

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

;---------------------------------------------------------------------
;  MAIN PROGRAM
;---------------------------------------------------------------------
Start:
        ;--- Disable analog inputs ---
        BANKSEL ADCON1
        MOVLW   0x06       ; Configure all pins as digital
        MOVWF   ADCON1

        ;--- Set PORTD as output ---
        BANKSEL TRISD
        CLRW                ; Clear WREG
        MOVWF   TRISD       ; Configure PORTD as output

        ;--- Clear PORTD (ensure all LEDs are off) ---
        BANKSEL PORTD
        CLRW
        MOVWF   PORTD

        ;--- Initialize LED position ---
        MOVLW   0x01        ; Start with LED0 (binary 0000_0001)
        MOVWF   LED

MainLoop:
        ;--- Output LED state to PORTD ---
        MOVF    LED, W      ; Load current LED state into W
        MOVWF   PORTD       ; Output to PORTD (turn on the current LED)

        ;--- 2-second delay ---
        MOVLW   0xC8        ; 200 loops of 10 ms = 2 seconds
        CALL    DELAY_W_10_MS

        ;--- Rotate LED position ---
        RLF     LED, F      ; Rotate left (shift to next LED)
        MOVF    LED, W
        ANDLW   b'00000111' ; Keep only bits 0, 1, 2 (for RD0, RD1, RD2)
        MOVWF   LED         ; Update LED state

        ;--- Reset to RD0 if LED becomes zero ---
        BTFSC   STATUS, Z   ; If zero after masking
        MOVLW   0x01        ; Reset to LED0 (binary 0000_0001)
        MOVWF   LED

        GOTO    MainLoop    ; Repeat the loop

;---------------------------------------------------------------------
;  DELAY ROUTINES
;---------------------------------------------------------------------
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
