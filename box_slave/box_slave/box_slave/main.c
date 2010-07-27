// box
// CY8C29466

#include <m8c.h>        // part specific constants and macros
#include "PSoCAPI.h"    // PSoC API definitions for all User Modules

#define _BV(BIT) (1<<BIT)
#define sbi(BYTE,BIT) (BYTE |= _BV(BIT))
#define cbi(BYTE,BIT) (BYTE &= ~_BV(BIT))

#define LED_ON() sbi(PRT2DR, 1) // LED
#define LED_OFF() cbi(PRT2DR, 1)
#define LED_DBG_ON() sbi(PRT2DR, 0) // LED
#define LED_DBG_OFF() cbi(PRT2DR, 0)
#define BTN_PORT PRT2DR // push button
#define BTN_BIT _BV(2)

int ad;

// AMUX4_PORT0_0 => 0x00
// AMUX4_PORT0_2 => 0x01
// AMUX4_PORT0_4 => 0x02
// AMUX4_PORT0_6 => 0x03
int get_adc(BYTE amux_pin){
    AMUX4_InputSelect(amux_pin);
    ADCINC_GetSamples(0);
    while(!ADCINC_fIsDataAvailable());
    return ADCINC_iClearFlagGetData();
}

void main(void)
{
    M8C_EnableGInt;
    AMUX4_Start();
    PGA_1_Start(PGA_1_HIGHPOWER);
    ADCINC_Start(ADCINC_HIGHPOWER);
    LED_DBG_ON();
    for(;;){
        ad = get_adc(0);
    }
}
