Project:      output/box_slave
Build Number: 0
Date:         Fri Jul 23 03:57:52 2010
Compiler:     ICCM8C
Version:      7.02.004

  ROM 5% full. 1484 out of 32768 bytes used (does not include absolute areas).
  RAM 2% full. 30 bytes used (does not include stack usage).

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   01A0   0253 =    595. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       01A0  LoadConfigTBL_box_slave_Bank0
       0289  LoadConfigTBL_box_slave_Bank1
       0308  LoadConfigTBL_box_slave_Ordered
       03F3  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   03F3   0002 =      2. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       03F3  __func_lit_start
       03F5  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     psoc_config   03F5   0062 =     98. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       03F5  _LoadConfigInit
       03F5  LoadConfigInit
       03FC  _LoadConfig_box_slave
       03FC  LoadConfig_box_slave
       0457  __psoc_config_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     UserModules   0457   030D =    781. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0457  _TX8_ISR
       0458  _Timer16_1_ISR
       0459  I2CHW_Poll
       0459  _I2CHW_Poll
       045A  _I2CHW_ISR
       057E  _ADCINCVR_4_CNT_ISR
       0581  _ADCINCVR_4_PWM16_ISR
       05FB  _ADCINCVR_3_CNT_ISR
       05FE  _ADCINCVR_3_PWM16_ISR
       0678  _ADCINCVR_2_CNT_ISR
       067B  _ADCINCVR_2_PWM16_ISR
       06F5  _ADCINCVR_1_CNT_ISR
       06F8  _ADCINCVR_1_PWM16_ISR
       0764  __UserModules_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0764   0008 =      8. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0764  _main
       0764  __text_start
       076B  PSoC_GPIO_ISR
       076C  __text_end
       076E  __xidata_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             TOP   0068   013D =    317. bytes (abs,ovr,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0068  __Start
       013A  bGetPowerSetting
       013A  _bGetPowerSetting

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                    InterruptRAM   0000   001C =     28. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  I2CHW_bStatus
       0000  _I2CHW_bStatus
       0000  _NO_SHADOW
       0000  NO_SHADOW
       0001  I2CHW_RsrcStatus
       0001  _I2CHW_RsrcStatus
       0002  _I2CHW_Write_Count
       0002  I2CHW_Write_Count
       0003  _pI2CHW_Write_BufHI
       0003  pI2CHW_Write_BufHI
       0004  _pI2CHW_Write_Buf
       0004  pI2CHW_Write_Buf
       0004  pI2CHW_Write_BufLO
       0004  _pI2CHW_Write_BufLO
       0005  pI2CHW_Read_BufHI
       0005  _pI2CHW_Read_BufHI
       0006  _pI2CHW_Read_Buf
       0006  pI2CHW_Read_BufLO
       0006  _pI2CHW_Read_BufLO
       0006  pI2CHW_Read_Buf
       0007  I2CHW_Read_Count
       0007  _I2CHW_Read_Count
       0008  ADCINCVR_4_cCounterU
       0009  ADCINCVR_4_iResult
       0009  _ADCINCVR_4_iResult
       000B  ADCINCVR_4_bfStatus
       000B  _ADCINCVR_4_bfStatus
       000C  ADCINCVR_4_bSampC
       000D  ADCINCVR_3_cCounterU
       000E  ADCINCVR_3_iResult
       000E  _ADCINCVR_3_iResult
       0010  ADCINCVR_3_bfStatus
       0010  _ADCINCVR_3_bfStatus
       0011  ADCINCVR_3_bSampC
       0012  ADCINCVR_2_cCounterU
       0013  _ADCINCVR_2_iResult
       0013  ADCINCVR_2_iResult
       0015  ADCINCVR_2_bfStatus
       0015  _ADCINCVR_2_bfStatus
       0016  ADCINCVR_2_bSampC
       0017  ADCINCVR_1_cCounterU
       0018  _ADCINCVR_1_iResult
       0018  ADCINCVR_1_iResult
       001A  _ADCINCVR_1_bfStatus
       001A  ADCINCVR_1_bfStatus
       001B  ADCINCVR_1_bSampC

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
               virtual_registers   001C   0002 =      2. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       001C  __r1
       001D  __r0

Files Linked      [ module(s) ]

./obj/boot.o	[ boot.asm ]
./obj/main.o	[ main.c ]
<library>	[ tx8int.asm, timer16_1int.asm, psocgpioint.asm, psocconfigtbl.asm, psocconfig.asm, i2chwint.asm ]
[ adcincvr_4int.asm, adcincvr_3int.asm, adcincvr_2int.asm, adcincvr_1int.asm, r1.asm, r0.asm ]


Area Definitions

-blit:0x1a0.0x7fff
-bdata:0.0x6ff
-BInterruptRAM:0	allocated at: 0
-Bvirtual_registers	allocated at: 0x1c
-Bbox_slave_RAM

