;;*****************************************************************************
;;*****************************************************************************
;;  ADCINCVR_2.asm
;;  Version: 3.1, Updated on 2009/10/15 at 17:11:37
;;  Generated by PSoC Designer 5.0.1127.0
;;
;;  DESCRIPTION: ADCINCVR User Module software implementation file.
;;
;;  NOTE: User Module APIs conform to the fastcall16 convention for marshalling
;;        arguments and observe the associated "Registers are volatile" policy.
;;        This means it is the caller's responsibility to preserve any values
;;        in the X and A registers that are still needed after the API functions
;;        returns. For Large Memory Model devices it is also the caller's 
;;        responsibility to perserve any value in the CUR_PP, IDX_PP, MVR_PP and 
;;        MVW_PP registers. Even though some of these registers may not be modified
;;        now, there is no guarantee that will remain the case in future releases.
;;-----------------------------------------------------------------------------
;;  Copyright (c) Cypress Semiconductor 2009. All Rights Reserved.
;;*****************************************************************************
;;*****************************************************************************

include "ADCINCVR_2.inc"
include "m8c.inc"
include "memory.inc"

;-----------------------------------------------
;  Global Symbols
;-----------------------------------------------
export  ADCINCVR_2_Start
export _ADCINCVR_2_Start
export  ADCINCVR_2_SetPower
export _ADCINCVR_2_SetPower
export  ADCINCVR_2_Stop
export _ADCINCVR_2_Stop
export  ADCINCVR_2_GetSamples
export _ADCINCVR_2_GetSamples
export  ADCINCVR_2_StopAD
export _ADCINCVR_2_StopAD
export  ADCINCVR_2_fIsData
export _ADCINCVR_2_fIsData
export  ADCINCVR_2_fIsDataAvailable
export _ADCINCVR_2_fIsDataAvailable
export  ADCINCVR_2_iGetData
export _ADCINCVR_2_iGetData
export  ADCINCVR_2_ClearFlag
export _ADCINCVR_2_ClearFlag
export  ADCINCVR_2_iGetDataClearFlag
export _ADCINCVR_2_iGetDataClearFlag
export  ADCINCVR_2_SetResolution
export _ADCINCVR_2_SetResolution

;-----------------------------------------------
;  EQUATES
;-----------------------------------------------
LowByte:       equ 1
HighByte:      equ 0

; Calctime parameters
wCalcTime:     equ   ADCINCVR_2_bCALCTIME

AREA UserModules (ROM, REL)

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADCINCVR_2_Start
;  FUNCTION NAME: ADCINCVR_2_SetPower
;
;  DESCRIPTION:
;  Applies power setting to the module's analog PSoc block.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:
;   A  Contains power level setting 0 to 3
;
;  RETURNS:  NA
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;          
;    Currently only the page pointer registers listed below are modified:
;          CUR_PP
;
 ADCINCVR_2_Start:
_ADCINCVR_2_Start:
 ADCINCVR_2_SetPower:
_ADCINCVR_2_SetPower:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_PROLOGUE RAM_USE_CLASS_2
   RAM_SETPAGE_CUR >ADCINCVR_2_bfStatus
   
   mov   X, SP                                       ; Get location of next location on stack
   and   A,ADCINCVR_2_bfPOWERMASK                    ; Mask only the valid power setting bits
   push  A                                           ; Save power value on temp location
   mov   A, reg[ADCINCVR_2_bfAtoDcr3]                ; Get current value of AtoDcr3
   and   A, ~ADCINCVR_2_bfPOWERMASK                  ; Mask off old power value
   or    A, [X]                                      ; OR in new power value
   or    A, f0h                                      ; Make sure other register is set correctly
   mov   reg[ADCINCVR_2_bfAtoDcr3], A                ; Reload CR with new power value

   tst   reg[ADCINCVR_2_bfAtoDcr2], ADCINCVR_2_fRES_SET
   jz    .DoNotLoadRes
   mov   A,ADCINCVR_2_bNUMBITS - ADCINCVR_2_bMINRES             ; get and set the resolution
   mov   [ADCINCVR_2_bfStatus], A              ; place it in the status variable
.DoNotLoadRes:
   pop   A                                           ; Restore the stack and power value
   RAM_EPILOGUE RAM_USE_CLASS_2
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADCINCVR_2_Stop
;
;  DESCRIPTION:
;  Removes power from the module's analog PSoc block, but the digital
;  blocks keep on running.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: None
;
;  RETURNS:   NA
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;
 ADCINCVR_2_Stop:
_ADCINCVR_2_Stop:
   RAM_PROLOGUE RAM_USE_CLASS_1
   and   reg[ADCINCVR_2_bfAtoDcr3], ~ADCINCVR_2_bfPOWERMASK
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADCINCVR_2_Get_Samples
;
;  DESCRIPTION:
;  Starts the A/D convertor and will place data is memory.  A flag
;  is set whenever a new data value is available.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:
;  A  Number of samples to be taken.  A zero will cause the ADC to run
;     continuously.
;
;  RETURNS:  NA
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;          
;    Currently only the page pointer registers listed below are modified:
;          CUR_PP
;
 ADCINCVR_2_GetSamples:
_ADCINCVR_2_GetSamples:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >ADCINCVR_2_bfStatus
   mov   [ADCINCVR_2_bSampC], A                            ; Store sample count
                                                           ; Interrupts, Put A/D in reset
   mov   A,[ADCINCVR_2_bfStatus]                           ; get and set the resolution
   and   A,ADCINCVR_2_bRES_MASK
   add   A,ADCINCVR_2_bMINRES
   call  ADCINCVR_2_SetResolution

ADCINCVR_2_LoadMSBCounter:                                 ; The PWM has been setup by SetResolution, now set the upper
                                                           ; counter which will be the same as the period.
                                                           ; Reset MSB of counter to most negative value

   mov   A,reg[ADCINCVR_2_bPWM_IntTime_MSB]                ; Get MSB of PWM and move it into RAM
   mov   [ADCINCVR_2_cCounterU], A                         ; Use counter as temp location
   mov   A, 00h                                            ; Load A with zero for the calculation
   sub   A, [ADCINCVR_2_cCounterU]                         ; 0 - MSB_PWM = MSB_of_most_neg_value
   asr   A                                                 ; Half the range (+ and -)
IF (ADCINCVR_2_DATA_FORMAT)
   mov   [ADCINCVR_2_cCounterU], A                         ; Place result back into MSB of counter
ELSE
   mov   [ADCINCVR_2_cCounterU], 00h                       ; Always start at zero for unsigned values
ENDIF
   mov   A, reg[ADCINCVR_2_bPWM_IntTime_LSB]               ; Dummy Read  - required do not remove
   mov   reg[ADCINCVR_2_bPeriod], FFh                      ; Make sure counter starts at FF

   and   reg[ADCINCVR_2_bfAtoDcr3],~ADCINCVR_2_fFSW0       ; Take Integrator out of reset
IF ADCINCVR_2_NoAZ
    and  reg[ADCINCVR_2_bfAtoDcr2],~ADCINCVR_2_fAutoZero   ; Take Integrator out of AutoZero
ENDIF

                                                               ; Enable the A/D and Start it!
   or    reg[ADCINCVR_2_bCounter_CR0], (ADCINCVR_2_fDBLK_ENABLE|ADCINCVR_2_fPULSE_WIDE)   ; Enable the Counter
   or    reg[ADCINCVR_2_fPWM_LSB_CR0], ADCINCVR_2_fDBLK_ENABLE          ; Enable PWM
   or    reg[ADCINCVR_2_bfPWM16_INT_REG], ADCINCVR_2_bfPWM16_Mask    ; Enable Counter interrupts
   or    reg[ADCINCVR_2_bfCounter_INT_REG], ADCINCVR_2_bfCounter_Mask
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADCINCVR_2_StopAD
;
;  DESCRIPTION:
;  Completely shuts down the A/D is an orderly manner.  Both the
;  Timer and Counter are disabled and their interrupts are deactivated.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:  None
;
;  RETURNS: NA
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;
 ADCINCVR_2_StopAD:
_ADCINCVR_2_StopAD:
   RAM_PROLOGUE RAM_USE_CLASS_1
   and   reg[ADCINCVR_2_fPWM_LSB_CR0], ~ADCINCVR_2_fDBLK_ENABLE     ; Disable the PWM

   and   reg[ADCINCVR_2_bCounter_CR0], ~ADCINCVR_2_fDBLK_ENABLE           ; Disable the Counter

IF ADCINCVR_2_NoAZ
   or   reg[ADCINCVR_2_bfAtoDcr2], ADCINCVR_2_fAutoZero        ; Put the Integrator into Autozero mode
ENDIF

   or   reg[ADCINCVR_2_bfAtoDcr3], ADCINCVR_2_fFSW0            ; Put Integrator into reset
   push A
   M8C_DisableIntMask ADCINCVR_2_bfPWM16_INT_REG, ADCINCVR_2_bfPWM16_Mask      ; Disable interrupts
   M8C_DisableIntMask ADCINCVR_2_bfCounter_INT_REG, ADCINCVR_2_bfCounter_Mask
   pop  A
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADCINCVR_2_fIsData
;  FUNCTION NAME: ADCINCVR_2_fIsDataAvailable
;
;  DESCRIPTION:
;  Returns the status of the A/D Data is set whenever a new data
;  value is available.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: None
;
;  RETURNS:
;  A  Returns data status  A == 0 no data available
;                          A != 0 data available
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;          
;    Currently only the page pointer registers listed below are modified: 
;          CUR_PP
;
 ADCINCVR_2_fIsData:
_ADCINCVR_2_fIsData:
 ADCINCVR_2_fIsDataAvailable:
_ADCINCVR_2_fIsDataAvailable:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >ADCINCVR_2_bfStatus
   mov   A, [ADCINCVR_2_bfStatus]                     ; Get status byte
   and   A, ADCINCVR_2_fDATA_READY                    ; Mask off other bits
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADCINCVR_2_iGetDataClearFlag
;  FUNCTION NAME: ADCINCVR_2_iGetData
;
;  DESCRIPTION:
;  Returns the data from the A/D.  Does not check if data is available.
;  iGetDataClearFlag clears the result ready flag as well.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: None
;
;  RETURNS:
;  A:X  return the ADC result.
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;          
;    Currently only the page pointer registers listed below are modified: 
;          CUR_PP
;
 ADCINCVR_2_iGetDataClearFlag:
_ADCINCVR_2_iGetDataClearFlag:   
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >ADCINCVR_2_bfStatus
   and   [ADCINCVR_2_bfStatus], ~ADCINCVR_2_fDATA_READY  ; Clear Data ready bit
   mov   X, [(ADCINCVR_2_iResult + HighByte)]
   mov   A, [(ADCINCVR_2_iResult + LowByte)]
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret


 ADCINCVR_2_iGetData:
_ADCINCVR_2_iGetData:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >ADCINCVR_2_iResult
   mov   X, [(ADCINCVR_2_iResult + HighByte)]
   mov   A, [(ADCINCVR_2_iResult + LowByte)]
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADCINCVR_2_ClearFlag
;
;  DESCRIPTION:
;  Clears the data ready flag.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: None
;
;  RETURNS: NA
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;          
;    Currently only the page pointer registers listed below are modified: 
;          CUR_PP
;
 ADCINCVR_2_ClearFlag:
_ADCINCVR_2_ClearFlag:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >ADCINCVR_2_bfStatus
   and   [ADCINCVR_2_bfStatus], ~ADCINCVR_2_fDATA_READY  ; Clear Data ready bit
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADCINCVR_2_SetResolution
;
;  DESCRIPTION:
;  Sets A/D resolution between 7 and 13 bits.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:
;  A  Passes the number of bits of resolution, between 7 and 13.
;
;  RETURNS:  NA
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;          
;    Currently only the page pointer registers listed below are modified: 
;          CUR_PP
;
;     This function halts the PWM and the counter to sync the A/D , but
;     does not re-enable the counter or PWM. To restart the A/D, "Get_Samples"
;     should be called.
;
 ADCINCVR_2_SetResolution:
_ADCINCVR_2_SetResolution:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >ADCINCVR_2_bfStatus
   
   and   reg[ADCINCVR_2_bfAtoDcr2], ~ADCINCVR_2_fRES_SET

   call  ADCINCVR_2_StopAD                         ; Stop the A/D if it is running
   mov   [ADCINCVR_2_bfStatus], 00h                ; and clear status and old resolution

                                                   ; Check for resolution to be within min and max values
   cmp   A,ADCINCVR_2_bMINRES                      ; Check low end of resolution
   jnc   ADCINCVR_2_CHECKHI
   mov   A,ADCINCVR_2_bMINRES                      ; Too low - load legal low value
   jmp   ADCINCVR_2_RES_OK

ADCINCVR_2_CHECKHI:                                ; Check high end of resolution
   cmp   A,ADCINCVR_2_bMAXRES
   jc    ADCINCVR_2_RES_OK
   mov   A,ADCINCVR_2_bMAXRES                      ; Too high - load legal Max value

ADCINCVR_2_RES_OK:
                                                   ; Calculate compare value for the PWM which
                                                   ; computes the integrate time
   sub   A, ADCINCVR_2_bMINRES                     ; Normalize with min resolution
   or    [ADCINCVR_2_bfStatus], A
                                                   ; Since min resolution is 7, 2^^7 = 128, the clock
                                                   ; is running 4x so 128*4=512 or 0x0200
   add   A,01h                                     ; The MSB is 02h.
   mov   X,A
   mov   A,01h

ADCINCVR_2_CALC_INTTIME:                           ; Now shift the MSB left for every bit of resolution of min (7).
   asl   A
   dec   X
   jnz   ADCINCVR_2_CALC_INTTIME

ADCINCVR_2_LOAD_INTTIME:                           ; Load compare value and Calc time into registers
                                                   ; Since minimum resolution is 7 bits, this value will always start at 0
   mov   reg[ADCINCVR_2_bPWM_IntTime_LSB], 00h
   mov   reg[ADCINCVR_2_bPWM_IntTime_MSB], A

                                                   ; Load the CalcTime into the PWM Period
   mov   reg[ADCINCVR_2_bPWM_Period_LSB], <wCalcTime
   add   A, >wCalcTime
   mov   reg[ADCINCVR_2_bPWM_Period_MSB],A
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION
; End of File ADCINCVR_2.asm
