; Generated by PSoC Designer 5.0.1127.0
;
include "m8c.inc"
;  Personalization tables 
export LoadConfigTBL_box_slave_Bank1
export LoadConfigTBL_box_slave_Bank0
export LoadConfigTBL_box_slave_Ordered
AREA lit(rom, rel)
LoadConfigTBL_box_slave_Bank0:
;  Instance name ADCINC, User Module ADCINC
;       Instance name ADCINC, Block Name ADC(ASD11)
	db		84h, 90h		;ADCINC_AtoDcr0(ASD11CR0)
	db		85h, 00h		;ADCINC_AtoDcr1(ASD11CR1)
	db		86h, 60h		;ADCINC_AtoDcr2(ASD11CR2)
	db		87h, fch		;ADCINC_AtoDcr3(ASD11CR3)
;       Instance name ADCINC, Block Name PWM(DBB00)
	db		23h, 00h		;ADCINC_PWMcr0(DBB00CR0)
	db		21h, 00h		;ADCINC_PWMdr1(DBB00DR1)
	db		22h, 01h		;ADCINC_PWMdr2(DBB00DR2)
;  Instance name AMUX4, User Module AMUX4
;  Instance name I2CHW, User Module I2CHW
;  Instance name PGA_1, User Module PGA
;       Instance name PGA_1, Block Name GAIN(ACB01)
	db		75h, feh		;PGA_1_GAIN_CR0(ACB01CR0)
	db		76h, 21h		;PGA_1_GAIN_CR1(ACB01CR1)
	db		77h, 20h		;PGA_1_GAIN_CR2(ACB01CR2)
	db		74h, 00h		;PGA_1_GAIN_CR3(ACB01CR3)
;  Instance name TX8, User Module TX8
;       Instance name TX8, Block Name TX8(DCB02)
	db		2bh, 00h		;TX8_CONTROL_REG  (DCB02CR0)
	db		29h, 00h		;TX8_TX_BUFFER_REG(DCB02DR1)
	db		2ah, 00h		;TX8_(DCB02DR2)
;  Instance name Timer16, User Module Timer16
;       Instance name Timer16, Block Name TIMER16_LSB(DBB30)
	db		53h, 00h		;Timer16_CONTROL_LSB_REG(DBB30CR0)
	db		51h, 00h		;Timer16_PERIOD_LSB_REG(DBB30DR1)
	db		52h, 00h		;Timer16_COMPARE_LSB_REG(DBB30DR2)
;       Instance name Timer16, Block Name TIMER16_MSB(DBB31)
	db		57h, 04h		;Timer16_CONTROL_MSB_REG(DBB31CR0)
	db		55h, 00h		;Timer16_PERIOD_MSB_REG(DBB31DR1)
	db		56h, 00h		;Timer16_COMPARE_MSB_REG(DBB31DR2)
;  Global Register values Bank 0
	db		60h, b0h		; AnalogColumnInputSelect register (AMX_IN)
	db		66h, 00h		; AnalogComparatorControl1 register (CMP_CR1)
	db		63h, 05h		; AnalogReferenceControl register (ARF_CR)
	db		65h, 00h		; AnalogSyncControl register (ASY_CR)
	db		e6h, 02h		; DecimatorControl_0 register (DEC_CR0)
	db		e7h, 42h		; DecimatorControl_1 register (DEC_CR1)
	db		d6h, 00h		; I2CConfig register (I2C_CFG)
	db		b0h, 00h		; Row_0_InputMux register (RDI0RI)
	db		b1h, 00h		; Row_0_InputSync register (RDI0SYN)
	db		b2h, 00h		; Row_0_LogicInputAMux register (RDI0IS)
	db		b3h, 33h		; Row_0_LogicSelect_0 register (RDI0LT0)
	db		b4h, 33h		; Row_0_LogicSelect_1 register (RDI0LT1)
	db		b5h, 00h		; Row_0_OutputDrive_0 register (RDI0SRO0)
	db		b6h, 10h		; Row_0_OutputDrive_1 register (RDI0SRO1)
	db		b8h, 55h		; Row_1_InputMux register (RDI1RI)
	db		b9h, 00h		; Row_1_InputSync register (RDI1SYN)
	db		bah, 10h		; Row_1_LogicInputAMux register (RDI1IS)
	db		bbh, 33h		; Row_1_LogicSelect_0 register (RDI1LT0)
	db		bch, 33h		; Row_1_LogicSelect_1 register (RDI1LT1)
	db		bdh, 00h		; Row_1_OutputDrive_0 register (RDI1SRO0)
	db		beh, 00h		; Row_1_OutputDrive_1 register (RDI1SRO1)
	db		c0h, 00h		; Row_2_InputMux register (RDI2RI)
	db		c1h, 00h		; Row_2_InputSync register (RDI2SYN)
	db		c2h, 20h		; Row_2_LogicInputAMux register (RDI2IS)
	db		c3h, 33h		; Row_2_LogicSelect_0 register (RDI2LT0)
	db		c4h, 33h		; Row_2_LogicSelect_1 register (RDI3LT1)
	db		c5h, 00h		; Row_2_OutputDrive_0 register (RDI2SRO0)
	db		c6h, 00h		; Row_2_OutputDrive_1 register (RDI2SRO1)
	db		c8h, 55h		; Row_3_InputMux register (RDI3RI)
	db		c9h, 00h		; Row_3_InputSync register (RDI3SYN)
	db		cah, 30h		; Row_3_LogicInputAMux register (RDI3IS)
	db		cbh, 33h		; Row_3_LogicSelect_0 register (RDI3LT0)
	db		cch, 33h		; Row_3_LogicSelect_1 register (RDI3LT1)
	db		cdh, 01h		; Row_3_OutputDrive_0 register (RDI3SRO0)
	db		ceh, 00h		; Row_3_OutputDrive_1 register (RDI3SRO1)
	db		6ch, 00h		; TMP_DR0 register (TMP_DR0)
	db		6dh, 00h		; TMP_DR1 register (TMP_DR1)
	db		6eh, 00h		; TMP_DR2 register (TMP_DR2)
	db		6fh, 00h		; TMP_DR3 register (TMP_DR3)
	db		ffh
LoadConfigTBL_box_slave_Bank1:
;  Instance name ADCINC, User Module ADCINC
;       Instance name ADCINC, Block Name ADC(ASD11)
;       Instance name ADCINC, Block Name PWM(DBB00)
	db		20h, 31h		;ADCINC_PWMfn(DBB00FN)
	db		21h, 15h		;ADCINC_PWMsl(DBB00IN)
	db		22h, 40h		;ADCINC_PWMos(DBB00OU)
;  Instance name AMUX4, User Module AMUX4
;  Instance name I2CHW, User Module I2CHW
;  Instance name PGA_1, User Module PGA
;       Instance name PGA_1, Block Name GAIN(ACB01)
;  Instance name TX8, User Module TX8
;       Instance name TX8, Block Name TX8(DCB02)
	db		28h, 1dh		;TX8_FUNC_REG     (DCB02FN)
	db		29h, 01h		;TX8_INPUT_REG    (DCB02IN)
	db		2ah, 87h		;TX8_OUTPUT_REG   (DCB02OU)
;  Instance name Timer16, User Module Timer16
;       Instance name Timer16, Block Name TIMER16_LSB(DBB30)
	db		50h, 00h		;Timer16_FUNC_LSB_REG(DBB30FN)
	db		51h, 17h		;Timer16_INPUT_LSB_REG(DBB30IN)
	db		52h, 40h		;Timer16_OUTPUT_LSB_REG(DBB30OU)
;       Instance name Timer16, Block Name TIMER16_MSB(DBB31)
	db		54h, 20h		;Timer16_FUNC_MSB_REG(DBB31FN)
	db		55h, 37h		;Timer16_INPUT_MSB_REG(DBB31IN)
	db		56h, 40h		;Timer16_OUTPUT_MSB_REG(DBB31OU)
;  Global Register values Bank 1
	db		61h, 00h		; AnalogClockSelect1 register (CLK_CR1)
	db		69h, 00h		; AnalogClockSelect2 register (CLK_CR2)
	db		60h, 00h		; AnalogColumnClockSelect register (CLK_CR0)
	db		62h, 00h		; AnalogIOControl_0 register (ABF_CR0)
	db		67h, 33h		; AnalogLUTControl0 register (ALT_CR0)
	db		68h, 33h		; AnalogLUTControl1 register (ALT_CR1)
	db		63h, 00h		; AnalogModulatorControl_0 register (AMD_CR0)
	db		66h, 00h		; AnalogModulatorControl_1 register (AMD_CR1)
	db		d1h, 00h		; GlobalDigitalInterconnect_Drive_Even_Input register (GDI_E_IN)
	db		d3h, 00h		; GlobalDigitalInterconnect_Drive_Even_Output register (GDI_E_OU)
	db		d0h, 00h		; GlobalDigitalInterconnect_Drive_Odd_Input register (GDI_O_IN)
	db		d2h, 00h		; GlobalDigitalInterconnect_Drive_Odd_Output register (GDI_O_OU)
	db		e1h, bfh		; OscillatorControl_1 register (OSC_CR1)
	db		e2h, 00h		; OscillatorControl_2 register (OSC_CR2)
	db		dfh, 19h		; OscillatorControl_3 register (OSC_CR3)
	db		deh, 01h		; OscillatorControl_4 register (OSC_CR4)
	db		ddh, 00h		; OscillatorGlobalBusEnableControl register (OSC_GO_EN)
	db		e7h, 48h		; Type2Decimator_Control register (DEC_CR2)
	db		ffh
LoadConfigTBL_box_slave_Ordered:
;  Ordered Global Register values
	M8C_SetBank1
	mov	reg[00h], 00h		; Port_0_DriveMode_0 register (PRT0DM0)
	mov	reg[01h], ffh		; Port_0_DriveMode_1 register (PRT0DM1)
	M8C_SetBank0
	mov	reg[03h], ffh		; Port_0_DriveMode_2 register (PRT0DM2)
	mov	reg[02h], 00h		; Port_0_GlobalSelect register (PRT0GS)
	M8C_SetBank1
	mov	reg[02h], 00h		; Port_0_IntCtrl_0 register (PRT0IC0)
	mov	reg[03h], 00h		; Port_0_IntCtrl_1 register (PRT0IC1)
	M8C_SetBank0
	mov	reg[01h], 00h		; Port_0_IntEn register (PRT0IE)
	M8C_SetBank1
	mov	reg[04h], a0h		; Port_1_DriveMode_0 register (PRT1DM0)
	mov	reg[05h], ffh		; Port_1_DriveMode_1 register (PRT1DM1)
	M8C_SetBank0
	mov	reg[07h], ffh		; Port_1_DriveMode_2 register (PRT1DM2)
	mov	reg[06h], 00h		; Port_1_GlobalSelect register (PRT1GS)
	M8C_SetBank1
	mov	reg[06h], 00h		; Port_1_IntCtrl_0 register (PRT1IC0)
	mov	reg[07h], 00h		; Port_1_IntCtrl_1 register (PRT1IC1)
	M8C_SetBank0
	mov	reg[05h], 00h		; Port_1_IntEn register (PRT1IE)
	M8C_SetBank1
	mov	reg[08h], 0fh		; Port_2_DriveMode_0 register (PRT2DM0)
	mov	reg[09h], f4h		; Port_2_DriveMode_1 register (PRT2DM1)
	M8C_SetBank0
	mov	reg[0bh], f0h		; Port_2_DriveMode_2 register (PRT2DM2)
	mov	reg[0ah], 08h		; Port_2_GlobalSelect register (PRT2GS)
	M8C_SetBank1
	mov	reg[0ah], 04h		; Port_2_IntCtrl_0 register (PRT2IC0)
	mov	reg[0bh], 04h		; Port_2_IntCtrl_1 register (PRT2IC1)
	M8C_SetBank0
	mov	reg[09h], 04h		; Port_2_IntEn register (PRT2IE)
	M8C_SetBank1
	mov	reg[0ch], 00h		; Port_3_DriveMode_0 register (PRT3DM0)
	mov	reg[0dh], 00h		; Port_3_DriveMode_1 register (PRT3DM1)
	M8C_SetBank0
	mov	reg[0fh], 00h		; Port_3_DriveMode_2 register (PRT3DM2)
	mov	reg[0eh], 00h		; Port_3_GlobalSelect register (PRT3GS)
	M8C_SetBank1
	mov	reg[0eh], 00h		; Port_3_IntCtrl_0 register (PRT3IC0)
	mov	reg[0fh], 00h		; Port_3_IntCtrl_1 register (PRT3IC1)
	M8C_SetBank0
	mov	reg[0dh], 00h		; Port_3_IntEn register (PRT3IE)
	M8C_SetBank1
	mov	reg[10h], 00h		; Port_4_DriveMode_0 register (PRT4DM0)
	mov	reg[11h], 00h		; Port_4_DriveMode_1 register (PRT4DM1)
	M8C_SetBank0
	mov	reg[13h], 00h		; Port_4_DriveMode_2 register (PRT4DM2)
	mov	reg[12h], 00h		; Port_4_GlobalSelect register (PRT4GS)
	M8C_SetBank1
	mov	reg[12h], 00h		; Port_4_IntCtrl_0 register (PRT4IC0)
	mov	reg[13h], 00h		; Port_4_IntCtrl_1 register (PRT4IC1)
	M8C_SetBank0
	mov	reg[11h], 00h		; Port_4_IntEn register (PRT4IE)
	M8C_SetBank1
	mov	reg[14h], 00h		; Port_5_DriveMode_0 register (PRT5DM0)
	mov	reg[15h], 00h		; Port_5_DriveMode_1 register (PRT5DM1)
	M8C_SetBank0
	mov	reg[17h], 00h		; Port_5_DriveMode_2 register (PRT5DM2)
	mov	reg[16h], 00h		; Port_5_GlobalSelect register (PRT5GS)
	M8C_SetBank1
	mov	reg[16h], 00h		; Port_5_IntCtrl_0 register (PRT5IC0)
	mov	reg[17h], 00h		; Port_5_IntCtrl_1 register (PRT5IC1)
	M8C_SetBank0
	mov	reg[15h], 00h		; Port_5_IntEn register (PRT5IE)
	M8C_SetBank1
	mov	reg[18h], 00h		; Port_6_DriveMode_0 register (PRT6DM0)
	mov	reg[19h], 00h		; Port_6_DriveMode_1 register (PRT6DM1)
	M8C_SetBank0
	mov	reg[1bh], 00h		; Port_6_DriveMode_2 register (PRT6DM2)
	mov	reg[1ah], 00h		; Port_6_GlobalSelect register (PRT6GS)
	M8C_SetBank1
	mov	reg[1ah], 00h		; Port_6_IntCtrl_0 register (PRT6IC0)
	mov	reg[1bh], 00h		; Port_6_IntCtrl_1 register (PRT6IC1)
	M8C_SetBank0
	mov	reg[19h], 00h		; Port_6_IntEn register (PRT6IE)
	M8C_SetBank1
	mov	reg[1ch], 00h		; Port_7_DriveMode_0 register (PRT7DM0)
	mov	reg[1dh], 00h		; Port_7_DriveMode_1 register (PRT7DM1)
	M8C_SetBank0
	mov	reg[1fh], 00h		; Port_7_DriveMode_2 register (PRT7DM2)
	mov	reg[1eh], 00h		; Port_7_GlobalSelect register (PRT7GS)
	M8C_SetBank1
	mov	reg[1eh], 00h		; Port_7_IntCtrl_0 register (PRT7IC0)
	mov	reg[1fh], 00h		; Port_7_IntCtrl_1 register (PRT7IC1)
	M8C_SetBank0
	mov	reg[1dh], 00h		; Port_7_IntEn register (PRT7IE)
	M8C_SetBank0
	ret


; PSoC Configuration file trailer PsocConfig.asm
