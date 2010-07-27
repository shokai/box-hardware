// box
// CY8C29466

#include <m8c.h>        // part specific constants and macros
#include "PSoCAPI.h"    // PSoC API definitions for all User Modules

#define _BV(BIT) (1<<BIT)
#define sbi(BYTE,BIT) (BYTE |= _BV(BIT))
#define cbi(BYTE,BIT) (BYTE &= ~_BV(BIT))

#define LED_ON() sbi(PRT2DR, 0) // LED
#define LED_OFF() cbi(PRT2DR, 0)
#define BTN_PORT PRT2DR // push button
#define BTN_BIT _BV(2)


void main(void)
{
    int ad;
    M8C_EnableGInt;
    PGA_1_Start(3);
    ADCINCVR_1_Start(ADCINCVR_1_HIGHPOWER);
    //ADCINCVR_1_SetResolution(13);
    ADCINCVR_1_GetSamples(0);
    LED_ON();

    for(;;){
        while(!ADCINCVR_1_fIsDataAvailable());
        ad = ADCINCVR_1_iGetData();
        ADCINCVR_1_ClearFlag();
    }
}
