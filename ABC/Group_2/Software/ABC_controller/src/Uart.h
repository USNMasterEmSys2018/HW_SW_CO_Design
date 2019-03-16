/*
 * Uart.h
 *
 *  Created on: Mar 16, 2019
 *      Author: liubo
 */

#ifndef UART_H_
#define UART_H_

#include "xil_types.h"
#include "xuartlite.h"
#include "xparameters.h"

class Uart {
private:
	XUartLite FUart;
public:
	Uart();
	int Sendbyte(u8 Note);
	int Readbyte(u8 *Note);
	virtual ~Uart();
};

#endif /* UART_H_ */
