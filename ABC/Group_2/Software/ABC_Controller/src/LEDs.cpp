/*
 * LEDs.cpp
 *
 *  Created on: Mar 13, 2019
 *      Author: Bozhao Liu
 */

#include "LEDs.h"
#include "xgpio.h"
#include "xparameters.h"
#define LED_CHANNEL 1

LEDs::LEDs() {
	// TODO Auto-generated constructor stub
	XGpio_Config *led_Config;
	led_Config = XGpio_LookupConfig(XPAR_AXI_GPIO_0_DEVICE_ID);
	XGpio_CfgInitialize(&LED, led_Config, led_Config->BaseAddress);

	XGpio_SetDataDirection(&LED, LED_CHANNEL, 0);
}

void LEDs::LightUp(char Note) {
	int LD = 0;
	if (Note < 72 && Note > 64) {
		LD = 1 << (Note - 65);
	} else if (Note < 104 && Note > 96) {
		LD = 1 << (Note - 96 + 7);
	}

	XGpio_DiscreteWrite(&LED, LED_CHANNEL, LD);
}

LEDs::~LEDs() {
	// TODO Auto-generated destructor stub
}

