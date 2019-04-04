/*
 * Uart.cpp
 *
 *  Created on: 28. mar. 2019
 *      Author: eitah
 */

#include "Uart.h"

Uart::Uart() {

}

Uart::~Uart() {
	// TODO Auto-generated destructor stub
}

int Uart::Readbyte()
{
	/* Flush UART FIFO */
	while (XUartPs_IsReceiveData(XPAR_PS7_UART_1_BASEADDR))
	{
		XUartPs_ReadReg(XPAR_PS7_UART_1_BASEADDR, XUARTPS_FIFO_OFFSET);
	}
	int userInput = 0;

	/* Wait for data on UART */
	while (!XUartPs_IsReceiveData(XPAR_PS7_UART_1_BASEADDR))
	{}
	/* Store the first character in the UART receive FIFO and echo it */
	if (XUartPs_IsReceiveData(XPAR_PS7_UART_1_BASEADDR))
	{
		userInput = XUartPs_ReadReg(XPAR_PS7_UART_1_BASEADDR, XUARTPS_FIFO_OFFSET);
		xil_printf("%c", userInput);
	}
	return userInput;
}
