/*
 * Pmods.cpp
 *
 *  Created on: 28. mar. 2019
 *      Author: eitah
 */

#include "Pmods.h"


Pmods::Pmods() {
	// TODO Auto-generated constructor stub
	GPIO_begin(&jb, XPAR_PMODGPIO_0_AXI_LITE_GPIO_BASEADDR, 0xF0);
}

void Pmods::setOutput(u8 pinNum, u8 value) {
	GPIO_setPin(&jb, pinNum, value);
}

u8 Pmods::getInput(u8 pinNum) {
	return GPIO_getPin(&jb, pinNum);
}

Pmods::~Pmods() {
	// TODO Auto-generated destructor stub
}
