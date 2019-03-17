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
#include "xil_cache.h"
#include "xil_printf.h"
#include <unistd.h>

Buzzer::Buzzer() {
	// TODO Auto-generated constructor stub
	//PmodACL2 Buzz;
	GPIO_begin( &Buzz, XPAR_PMODGPIO_0_AXI_LITE_GPIO_BASEADDR, 0);

}

int Buzzer::Get100Freq(char note)
{

	{
		int index = 15;
		for(int i = 0; i <14; i++)
		{
			if(NOTES[i] == note)
			{
				index = i;
			}
		}
		return Freqs[index];
	}
}

void Buzzer::Sing(char note)
{
	int Freq = Get100Freq(note);
	int delay = (100000000/Freq) >> 1; //us
	int en = 1;

	for(int i = 0; i < Freq*2/100; i++)
	{
		GPIO_setPin(&Buzz, 2, en);
		usleep(delay);
		en = 1 - en;
	}
}

Buzzer::~Buzzer() {
	// TODO Auto-generated destructor stub
}

