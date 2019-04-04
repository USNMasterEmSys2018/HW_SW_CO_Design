/*
 * Leds.cpp
 *
 *  Created on: 28. mar. 2019
 *      Author: eitah
 */

#include "Leds.h"
#define LED_CHANNEL 1


Leds::Leds() {
	// TODO Auto-generated constructor stub
	int Status = XGpio_Initialize(&Gpio, XPAR_AXI_GPIO_0_DEVICE_ID);
	if (Status != XST_SUCCESS) {
		xil_printf("LEDS failed!");
	}
	/*Set the direction for the LEDs to output. */
	XGpio_SetDataDirection(&Gpio, LED_CHANNEL, 0x0);
}

Leds::~Leds() {
	// TODO Auto-generated destructor stub
}


void Leds::ShowLight() {
	XGpio_DiscreteWrite(&Gpio, LED_CHANNEL, 0x1);
}
