;;*****************************************************************************
;;*****************************************************************************
;;  FILENAME:   ADCINCVR_2INT.asm
;;  Version: 3.1, Updated on 2009/10/15 at 17:11:37
;;  Generated by PSoC Designer 5.0.1127.0
;;
;;  DESCRIPTION: ADCINCVR Interrupt Service Routines
;;-----------------------------------------------------------------------------
;;  Copyright (c) Cypress Semiconductor 2009. All Rights Reserved.
;;*****************************************************************************
;;*****************************************************************************

include "m8c.inc"
include "memory.inc"
include "ADCINCVR_2.inc"

;-----------------------------------------------
;  Global Symbols
;-----------------------------------------------
export _ADCINCVR_2_CNT_ISR
export _ADCINCVR_2_PWM16_ISR
export  ADCINCVR_2_cCounterU
export _ADCINCVR_2_iResult
export  ADCINCVR_2_iResult
export _ADCINCVR_2_bfStatus
export  ADCINCVR_2_bfStatus
export  ADCINCVR_2_bSampC

;-----------------------------------------------
; Variable Allocation
;-----------------------------------------------
AREA InterruptRAM(RAM, REL, CON)

 ADCINCVR_2_cCounterU:     BLK   1  ;The Upper byte of the Counter
_ADCINCVR_2_iResult:
 ADCINCVR_2_iResult:       BLK   2  ;A/D value
_ADCINCVR_2_bfStatus:
 ADCINCVR_2_bfStatus:      BLK   1  ;Data Valid Flag
 ADCINCVR_2_bSampC:        BLK   1  ;# of times to run A/D


;-----------------------------------------------
;  EQUATES and TABLES
;-----------------------------------------------
LowByte:   equ 1
HighByte:  equ 0


;@PSoC_UserCode_INIT@ (Do not change this line.)
;---------------------------------------------------
; Insert your custom declarations below this banner
;---------------------------------------------------

;------------------------
; Includes
;------------------------

	
;------------------------
;  Constant Definitions
;------------------------


;------------------------
; Variable Allocation
;------------------------


;---------------------------------------------------
; Insert your custom declarations above this banner
;---------------------------------------------------
;@PSoC_UserCode_END@ (Do not change this line.)

AREA UserModules (ROM, REL)

.LITERAL
ADCINCVR_2MaxNegX4Table:
; Bits  7    8    9   10   11   12   13
   DB  FFh, FEh, FCh, F8h, F0h, E0h, C0h

ADCINCVR_2MaxPosX4Table:
IF (ADCINCVR_2_DATA_FORMAT)
; Bits (signed)    7    8    9   10   11   12   13
              DB  01h, 02h, 04h, 08h, 10h, 20h, 40h
ELSE
; Bits (unsigned)  7    8    9   10   11   12   13
              DB  02h, 04h, 08h, 10h, 20h, 40h, 80h

 ENDIF
.ENDLITERAL

;-----------------------------------------------------------------------------
;  FUNCTION NAME: _ADCINCVR_2_CNT_ISR (Counter8 Interrupt)
;
;
;  DESCRIPTION:
;     Increment the upper (software) half on the counter whenever the
;     lower (hardware) half of the counter underflows.  This counter
;     should start out at the most negative value (0xFF).
;
;-----------------------------------------------------------------------------
;
_ADCINCVR_2_CNT_ISR:
   inc [ADCINCVR_2_cCounterU]
   ;@PSoC_UserCode_BODY_1@ (Do not change this line.)
   ;---------------------------------------------------
   ; Insert your custom code below this banner
   ;---------------------------------------------------
   ;   NOTE: interrupt service routines must preserve
   ;   the values of the A and X CPU registers.

   ;---------------------------------------------------
   ; Insert your custom code above this banner
   ;---------------------------------------------------
   ;@PSoC_UserCode_END@ (Do not change this line.)
   reti


;-----------------------------------------------------------------------------
;  FUNCTION NAME: _ADCINCVR_2_PWM16_ISR  (PWM16 Interrupt)
;
;  DESCRIPTION:
;     This ISR is called when the ADC has completed and integrate cycle.
;     The ADC value is calculated and stored in a global location before
;     the end of the ISR.
;
;-----------------------------------------------------------------------------
;
_ADCINCVR_2_PWM16_ISR:
   and   reg[ADCINCVR_2_bCounter_CR0], ~ADCINCVR_2_fDBLK_ENABLE  ; Disable Counter
IF ADCINCVR_2_NoAZ
   or    reg[ADCINCVR_2_bfAtoDcr2], ADCINCVR_2_fAutoZero      ; Put Integrator in AutoZero
ENDIF
   or   reg[ADCINCVR_2_bfAtoDcr3],ADCINCVR_2_fFSW0         ; Put Integrator in reset

                                                           ; Enable interrupts for a short period of time just in case.
                                                           ; Make sure we didn't have a counter interrupt ready to fire
   M8C_EnableGInt
   nop                                                     ; Wait a couple cycles
   M8C_DisableGInt                                         ; Disable interrupt, read to complete processing
   push  A                                                 ; Save the Accumulator
   mov   A,reg[ADCINCVR_2_bCount]                          ; Read counter value  (Bogus read puts value in Period register)
   mov   A,reg[ADCINCVR_2_bCompare]                        ; Read counter value
   dec   A                                                 ; Decrement by one to make sure we didn't miss a count
   cpl   A                                                 ; Invert the value
   jnc   ADCINCVR_2_INT_CALCV                              ; if carry, then inc MSB as well
   inc   [ADCINCVR_2_cCounterU]
ADCINCVR_2_INT_CALCV:
   mov   [(ADCINCVR_2_iResult + LowByte)], A               ; Store LSB value
   mov   A, [ADCINCVR_2_cCounterU]                         ; Store MSB from temp counter
   mov   [(ADCINCVR_2_iResult + HighByte)], A
                                                           ; The new value has been stored,
                                                           ; so get counters ready for next reading first.
   mov   reg[ADCINCVR_2_bPeriod], ffh                      ; Initialize counter to FF - Set to overflow after 256 counts
   or    reg[ADCINCVR_2_bCounter_CR0],ADCINCVR_2_fDBLK_ENABLE  ; Enable Counter

IF (ADCINCVR_2_DATA_FORMAT)                                ; Only check for Negative numbers if SIGNED result
   mov   A, [ADCINCVR_2_bfStatus]                          ; Get Status with Resolution
   and   A, ADCINCVR_2_bRES_MASK                           ; Mask of resolution
   index ADCINCVR_2MaxNegX4Table                           ; Get Maximum negative value from table
   mov   [ADCINCVR_2_cCounterU], A                         ; Place result back into MSB of counter
ELSE
   mov   [ADCINCVR_2_cCounterU], 00h                       ; Place result back into MSB of counter
ENDIF

   ;@PSoC_UserCode_BODY_2@ (Do not change this line.)
   ;---------------------------------------------------
   ; If the input is muxed with multiple inputs
   ; this is a good place to change inputs.
   ; Insert your custom code below this banner
   ;---------------------------------------------------
   ;   NOTE: interrupt service routines must preserve
   ;   the values of the A and X CPU registers. At this
   ;   point A is already preserved and will be restored;
   ;   however, if you use X, you must take care of it
   ;   here!

   ;---------------------------------------------------
   ; Insert your custom code above this banner
   ;---------------------------------------------------
   ;@PSoC_UserCode_END@ (Do not change this line.)

   and   reg[ADCINCVR_2_bfAtoDcr3],~ADCINCVR_2_fFSW0       ; Take Integrator out of reset
IF ADCINCVR_2_NoAZ
   and   reg[ADCINCVR_2_bfAtoDcr2],~ADCINCVR_2_fAutoZero   ; Take Integrator out of AutoZero
ENDIF

   ;****************************************************************************
   ;M8C_EnableGInt            ; May want to re-enable interrupts at this point,
   ;                          ; if stack space isn't at a premium.
   ; NOTE:  this will make system more responsive but, will increase the
   ;        overall processing time of the A/D calctime.  If an interrupt is
   ;        taken, it must return within the specified CalcTime to guarantee
   ;        successful acquisition of the next byte.
   ;****************************************************************************
IF (ADCINCVR_2_DATA_FORMAT)                      ; Only check for Negative numbers if SIGNED result

                                                 ; Negative Overflow Check
   tst   [(ADCINCVR_2_iResult + HighByte)],80h
   jnz   ADCINCVR_2_NOT_POVFL2

ENDIF
                                                 ; Postive Overflow Check
                                                 ; Get MSB of Max Positive value x4 + 1
   mov   A,[ADCINCVR_2_bfStatus]                 ; Get Status with Resolution
   and   A,ADCINCVR_2_bRES_MASK                  ; Mask of resolution normalized to 0
   index ADCINCVR_2MaxPosX4Table                 ; Get Maximum positive value x4 + 1 from table
   push  A
   and   A, [(ADCINCVR_2_iResult + HighByte)]
   jz    ADCINCVR_2_NOT_POVFL
                                                 ; Positive overflow, fix it - set to Max Positive + 1
   pop   A
   sub   A, 01h

                                                 ; Force most positive * 4 into result
   mov   [(ADCINCVR_2_iResult + HighByte)], A
   mov   [(ADCINCVR_2_iResult + LowByte)], ffh
   jmp   ADCINCVR_2_NOT_POVFL2
ADCINCVR_2_NOT_POVFL:
   pop   A

ADCINCVR_2_NOT_POVFL2:
   asr   [(ADCINCVR_2_iResult + HighByte)]       ; Shift MSB and LSB right twice to divide by four
   rrc   [(ADCINCVR_2_iResult + LowByte)]        ; Remember digital clock 4 times analog clock
   asr   [(ADCINCVR_2_iResult + HighByte)]
   rrc   [(ADCINCVR_2_iResult + LowByte)]

   ;@PSoC_UserCode_BODY_3@ (Do not change this line.)
   ;---------------------------------------------------
   ; Data is ready at this point.
   ; If processing Data at Interrupt level - add
   ; User Code to handle the data below this banner
   ;---------------------------------------------------
   ;   NOTE: interrupt service routines must preserve
   ;   the values of the A and X CPU registers. At this
   ;   point A is already preserved and will be restored;
   ;   however, if you use X, you must take care of it
   ;   here!

   ;---------------------------------------------------
   ; Insert your custom code above this banner
   ;---------------------------------------------------
   ;@PSoC_UserCode_END@ (Do not change this line.)

   pop   A                                       ; Restore A, not used any more

   or    [ADCINCVR_2_bfStatus],ADCINCVR_2_fDATA_READY  ; Set Data ready bit

   tst   [ADCINCVR_2_bSampC], ffh                ; If sample_counter == 0 -->> continuous data collection
   jz    ADCINCVR_2_END_PWM16_ISR

   dec   [ADCINCVR_2_bSampC]                     ; Dec sample counter and check for zero
   jnz   ADCINCVR_2_END_PWM16_ISR

   ;**********************************************
   ; Turn off ADC
   ;**********************************************
   and   reg[ADCINCVR_2_fPWM_LSB_CR0], ~ADCINCVR_2_fDBLK_ENABLE     ; Disable the PWM
   and   reg[ADCINCVR_2_bCounter_CR0], ~ADCINCVR_2_fDBLK_ENABLE           ; Disable the Counter
IF ADCINCVR_2_NoAZ
   or    reg[ADCINCVR_2_bfAtoDcr2], ADCINCVR_2_fAutoZero       ; Put the Integrator into Autozero mode
ENDIF
   or    reg[ADCINCVR_2_bfAtoDcr3], ADCINCVR_2_fFSW0           ; Put Integrator into reset
   and   reg[ADCINCVR_2_bfPWM16_INT_REG], ~ADCINCVR_2_bfPWM16_Mask      ; Disable interrupts
   and   reg[ADCINCVR_2_bfCounter_INT_REG], ~ADCINCVR_2_bfCounter_Mask

ADCINCVR_2_END_PWM16_ISR:
   reti

; End of File ADCINCVR_2INT.asm