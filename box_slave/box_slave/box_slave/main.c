// box slave
// work as I2C slave
// get weight by 4 ADC (PORT0 PIN 0,2,4,6)
// UART TX for debug
// CY8C29466

#include <m8c.h>        // part specific constants and macros
#include "PSoCAPI.h"    // PSoC API definitions for all User Modules
#include <string.h>
#include <stdlib.h>

#define _BV(BIT) (1<<BIT)
#define sbi(BYTE,BIT) (BYTE |= _BV(BIT))
#define cbi(BYTE,BIT) (BYTE &= ~_BV(BIT))

#define LED_ON() sbi(PRT2DR, 1) // LED
#define LED_OFF() cbi(PRT2DR, 1)
#define LED_DBG_ON() sbi(PRT2DR, 0) // debug LED
#define LED_DBG_OFF() cbi(PRT2DR, 0)
#define BTN_PORT PRT2DR // push button
#define BTN_BIT _BV(2)

int get_adc(BYTE amux_channel);
int ad;
BYTE ad_pin;
int weights[4];
char buf[6];

void main(void)
{
    M8C_EnableGInt;
    M8C_EnableIntMask(INT_MSK0, INT_MSK0_GPIO);

    AMUX4_Start();
    PGA_1_Start(PGA_1_HIGHPOWER);
    ADCINC_Start(ADCINC_HIGHPOWER);
    TX8_Start(TX8_PARITY_NONE);

    LED_DBG_ON();
    TX8_CPutString("I2C slave addr:");
    TX8_PutSHexByte(I2CHW_SLAVE_ADDR);
    TX8_PutCRLF();
    LED_DBG_OFF();
    for(;;){
        for(ad_pin = 0; ad_pin < 4; ad_pin++){
            ad = get_adc(ad_pin);
            weights[ad_pin] = ad;
            TX8_PutChar(ad_pin);
            TX8_CPutString(":");
            TX8_PutString(itoa(buf, ad, 6));
            TX8_PutCRLF();
        }
    }
}


// AMUX4_PORT0_0 => 0x00
// AMUX4_PORT0_2 => 0x01
// AMUX4_PORT0_4 => 0x02
// AMUX4_PORT0_6 => 0x03
int get_adc(BYTE amux_channel){
    AMUX4_InputSelect(amux_channel);
    ADCINC_GetSamples(0);
    while(!ADCINC_fIsDataAvailable());
    return ADCINC_iClearFlagGetData();
}


// I/Oƒsƒ“ó‘Ô•Ï‰»Š„‚è‚İ
#pragma interrupt_handler INT_GPIO
void INT_GPIO(void){
  if(BTN_PORT & BTN_BIT){ // ƒ{ƒ^ƒ“‚ª‰Ÿ‚³‚ê‚Ä‚¢‚é
    LED_DBG_ON();
    TX8_CPutString("DOWN\r\n");
  }
  else{
    LED_DBG_OFF();
    TX8_CPutString("UP\r\n");
  }
}
