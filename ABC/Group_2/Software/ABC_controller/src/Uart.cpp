/*
 * Uart.cpp
 *
 *  Created on: Mar 16, 2019
 *      Author: liubo
 */

#include "Uart.h"

#include "xuartlite.h"
#include "xparameters.h"

Uart::Uart() {
	// TODO Auto-generated constructor stub
	XUartLite_Config *uart_config;
	XUartLite_Initialize(&FUart, XPAR_AXI_UARTLITE_0_DEVICE_ID);
	uart_config = XUartLite_LookupConfig(XPAR_AXI_UARTLITE_0_DEVICE_ID);
	XUartLite_CfgInitialize(&FUart, uart_config, uart_config->RegBaseAddr);
}
int Uart::Readbyte(u8 *Note)
{
	return XUartLite_Recv(&FUart, Note, XPAR_BRAM_0_HIGHADDR -  XPAR_BRAM_0_BASEADDR + 1);
}

int Uart::Sendbyte(u8 *Note, int size)
{
	return XUartLite_Send(&FUart, Note, size);
}

Uart::~Uart() {
	// TODO Auto-generated destructor stub
}

