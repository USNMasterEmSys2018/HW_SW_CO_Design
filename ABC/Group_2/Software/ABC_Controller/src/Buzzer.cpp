/*
 * Buzzer.cpp
 *
 *  Created on: Mar 13, 2019
 *      Author: Bozhao Liu
 */

#include <stdio.h>
#include "Buzzer.h"
#include "PmodACL2.h"
#include "xparameters.h"
#include <unistd.h>

Buzzer::Buzzer() {
	// TODO Auto-generated constructor stub
	//PmodACL2 Buzz;
	ACL2_begin( &Buzz, XPAR_PMODACL2_0_AXI_LITE_GPIO_BASEADDR, XPAR_PMODACL2_0_AXI_LITE_SPI_BASEADDR);

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
	ACL2_end( &Buzz);
}

