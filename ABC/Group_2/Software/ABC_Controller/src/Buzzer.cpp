/*
 * Buzzer.cpp
 *
 *  Created on: Mar 13, 2019
 *      Author: Bozhao Liu
 */

#include <stdio.h>
#include "Buzzer.h"
#include "PmodGPIO.h"
#include "xparameters.h"
#include <unistd.h>

Buzzer::Buzzer() {
	// TODO Auto-generated constructor stub
	//PmodACL2 Buzz;
	GPIO_begin( &Buzz, XPAR_PMODGPIO_0_AXI_LITE_GPIO_BASEADDR, 0);

}

void Buzzer::Sing(int Freq)
{
	int delay = (1000000000/Freq) >> 1; //us
	int en = 1;

	for(int i = 0; i < Freq*2; i++)
	{

		usleep(delay);
		en = 1 - en;
	}
}

Buzzer::~Buzzer() {
	// TODO Auto-generated destructor stub
}

