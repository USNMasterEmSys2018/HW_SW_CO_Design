
#include "xparameters.h"
#include <stdio.h>
#include "platform.h"
#include "xstatus.h"
#include <unistd.h>
#include "Pmods.h"

//input
#define TDO_PIN 1

//output
#define TMS_PIN 5
#define TCK_PIN 6
#define TDI_PIN 7

#define NUM_OP 3

Pmods jb_pmod;

u8 ROM[NUM_OP] = {0x00, 0xA0, 0xA3};



void tms1() {
	int tick = 0;
	jb_pmod.setOutput(TMS_PIN, 1);
	for(int i = 0; i < 2; i++) {
		jb_pmod.setOutput(TCK_PIN, tick);
		tick = 1 - tick;
	}
}

void nclk(int iter) {
	int tick = 0;
	jb_pmod.setOutput(TMS_PIN, 0);
	for(int i = 0; i < iter*2; i++) {
		jb_pmod.setOutput(TCK_PIN, tick);
		tick = 1 - tick;
	}
}



void operation(u8 opcode) {
	int index = 0;
	for(int i = 0; i < NUM_OP; i++) {
		if (ROM[i] == opcode) {
			index = i;
		}
	}

	switch(index){
	case 0:
		break;
	case 1:
		tms1();
		break;
	case 2:
		nclk(150);
		break;
	}
}





int main() {
	init_platform();

	//Main program
	while(1) {
		u8 op = jb_pmod.getInput(TDO_PIN);
		operation(op);
	}
	cleanup_platform();
	return 0;
}













/* TMS1 0xA0
 * TMS = 1
 * TMS = 0
 * TCK 1 pulse
 */

/* NCLK 0xA3
 *
 * TMS = 0
 * TCK 20 pulses
 *
 */













































/*
//JB INPUT PMOD
#define TDI_PMOD_PIN_NUMBER 1

//JC OUTPUT PMOD
#define TDO_PMOD_PIN_NUMBER 1
#define TCK_PMOD_PIN_NUMBER 2
#define TMS_PMOD_PIN_NUMBER 3


Pmods pmod_JC_OUT(false);     //Make JB input pmod
Pmods pmod_JB_IN(true);     //Make JB input pmod



//ROM with binary codes :: TMS | NTCK ::
u8 ROM [2] 				= {0xA0, 0xA3};










void nclk() {
	int en = 0;
	pmod_JC_OUT.setOutput(TMS_PMOD_PIN_NUMBER, 0);
	for(int i = 0; i < 20; i++) {
		pmod_JC_OUT.setOutput(TCK_PMOD_PIN_NUMBER, en);
		en = 1 - en;
	}
}

void tms1() {
	int en = 0;
	pmod_JC_OUT.setOutput(TMS_PMOD_PIN_NUMBER, 1);
	for(int i = 0; i < 2; i ++) {
		pmod_JC_OUT.setOutput(TCK_PMOD_PIN_NUMBER, en);
		en = 1 - en;
	}
	pmod_JC_OUT.setOutput(TMS_PMOD_PIN_NUMBER, 0);
}



void operation(u8 opcode) {

	int ind = 0;

	for(int i = 0; i < 2; i+=1) {
		if (ROM[i] == opcode) {
			ind = i;
		}
	}

	switch(ind) {
	case 0:    //TMS1
		tms1();
	break;
	case 1:    //NCLK
		nclk();
	break;
	}
}

int main()
{
	init_platform();


	operation(0xA0);
	operation(0xA3);

    cleanup_platform();
    return 0;
}*/
