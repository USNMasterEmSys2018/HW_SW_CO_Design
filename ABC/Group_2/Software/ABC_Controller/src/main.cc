/*
 * Empty C++ Application
 */
#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"


int main()
{
    init_platform();

    printf("Hello World\n\r");

    cleanup_platform();
    return 0;
}
