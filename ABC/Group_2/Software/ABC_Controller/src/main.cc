/*
 * Empty C++ Application
 */
#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "LEDs.h"
#include "Buzzer.h"

int main()
{
    init_platform();
    char note = 'H';
    printf("Hello World\n\r");
    LEDs LED;
    LED.LightUp(note);
    printf("%d",(int)note);
    Buzzer buz;
    buz.Sing(440);
    cleanup_platform();
    return 0;
}
