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
#define BUF_SIZE 8
BYTE buf_rx[BUF_SIZE]; // I2C buffer
BYTE buf_tx[BUF_SIZE] = {'x'};
BYTE i2c_status; // I2C status

int ad;
BYTE ad_pin;
int weights[4];
char buf[6];

// intの桁数を返す
char getDigit(int n){
    char i;
    i = 0;
    while(n>0){
        n /= 10;
        i++;
    }
    return i;
}

// int->String変換
// char buf[6]
char *intToStr(int n, char *buf){ // 変換する数、作業領域
    int i, digit;
    digit = getDigit(n); // 桁数
    for(i = digit-1; i >= 0; i--){ // intは最大5桁
        buf[i] = n%10+'0';
        n /= 10;
    }
    buf[digit] = '\0'; // 行末
    return buf;
}

void wait(int n){
    while(n--);
}

// AMUX4_PORT0_0 => 0x00
// AMUX4_PORT0_2 => 0x01
// AMUX4_PORT0_4 => 0x02
// AMUX4_PORT0_6 => 0x03
int get_adc(BYTE amux_channel){
    AMUX4_InputSelect(amux_channel);
    wait(10);
    ADCINC_GetSamples(0);
    while(!ADCINC_fIsDataAvailable());
    return ADCINC_iClearFlagGetData();
}

void main(void){
    M8C_EnableGInt;
    M8C_EnableIntMask(INT_MSK0, INT_MSK0_GPIO);

    I2CHW_Start();
    I2CHW_EnableSlave();
    I2CHW_EnableInt();
    
    AMUX4_Start();
    PGA_1_Start(PGA_1_HIGHPOWER);
    ADCINC_Start(ADCINC_HIGHPOWER);
    TX8_Start(TX8_PARITY_NONE);
    
    LED_DBG_ON();
    TX8_CPutString("I2C slave addr:0x");
    TX8_PutSHexByte(I2CHW_SLAVE_ADDR);
    TX8_PutCRLF();
    LED_DBG_OFF();

    for(;;){
        // I2C
        i2c_status = I2CHW_bReadI2CStatus();
        if(i2c_status & I2CHW_WR_COMPLETE){ // master->slave
            I2CHW_ClrWrStatus();
            I2CHW_InitWrite(buf_rx, BUF_SIZE);
        }
        if(i2c_status & I2CHW_RD_COMPLETE){ // slave->master
            I2CHW_ClrRdStatus();
            I2CHW_InitRamRead(buf_tx, BUF_SIZE);
        }

        // ADC
        for(ad_pin = 0; ad_pin < 4; ad_pin++){
            ad = get_adc(ad_pin);
            weights[ad_pin] = ad;
            TX8_PutChar(ad_pin+'0');
            TX8_CPutString(":");
            TX8_PutString(intToStr(ad,buf));
            TX8_PutCRLF();
        }
        buf_tx[0] = 'a';
        buf_tx[1] = 'b';
        buf_tx[2] = 'c';
        buf_tx[3] = 'd';
    }
}


// I/Oピン状態変化割り込み
#pragma interrupt_handler INT_GPIO
void INT_GPIO(void){
  if(BTN_PORT & BTN_BIT){ // ボタンが押されている時
    LED_DBG_ON();
    TX8_CPutString("DOWN\r\n");
  }
  else{
    LED_DBG_OFF();
    TX8_CPutString("UP\r\n");
  }
}
