/*
 * Empty C++ Application
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "LEDs.h"
#include "Buzzer.h"
#include "xuartlite.h"

int main()
{
	init_platform();
	char note;
	while(1)
	{
		//if (XUartPs_IsReceiveData(STDIN_BASEADDRESS))
		{
		    char note = inbyte();

			if ((note < 72 && note > 64)||(note < 104 && note > 96))
			{
				LEDs LED;
				LED.LightUp(note);
				print("hello");
				Buzzer buz;
				buz.Sing(note);
			}
		}
	}
	cleanup_platform();
    return 0;
}
