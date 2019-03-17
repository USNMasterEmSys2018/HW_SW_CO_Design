/*
 * Empty C++ Application
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "LEDs.h"
#include "Buzzer.h"
#include "Memory.h"
#include "Uart.h"
#include "xil_types.h"
//#include "xuartlite.h"

Uart FUart;
Memory BRAM;
LEDs LED;
Buzzer buz;

int main()
{
	init_platform();
	/*
	char note[7] = {'C','D','E','F','G','A','B'};
	BRAM.SaveNote(note,7);
	for(int i = 0; i< 7; i++)
	{
		char Note = BRAM.ReadNextNote();
		LED.LightUp(Note);
		buz.Sing(Note);
	}*/

	while(1)
	{
		u8 *note;
		int size = FUart.Readbyte(note);
		if(size > 0)
		{
			for(int i = 0; i < size; i++)
			{
				BRAM.SaveNote(*note++);
			}
		}
		char Note = BRAM.ReadNextNote();
		while(Note != 'H')
		{
			LED.LightUp(Note);
			buz.Sing(Note);
			Note = BRAM.ReadNextNote();
		}
	}
	cleanup_platform();
    return 0;
}
