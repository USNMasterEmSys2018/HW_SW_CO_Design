/*
 * Empty C++ Application
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "LEDs.h"
#include "Buzzer.h"
#include "Memory.h"
//#include "xuartlite.h"

int main()
{
	init_platform();
	char note[7] = {'C','D','E','F','G','A','B'};
	Memory BRAM;
	LEDs LED;
	Buzzer buz;
	BRAM.SaveNote(note,7);
	for(int i = 0; i< 7; i++)
	{
		char Note = BRAM.ReadNextNote();
		LED.LightUp(Note);
		buz.Sing(Note);
	}
	cleanup_platform();
    return 0;
}
