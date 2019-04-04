/*
 * Uart.h
 *
 *  Created on: 28. mar. 2019
 *      Author: eitah
 */

#ifndef SRC_UART_H_
#define SRC_UART_H_

#include "xuartps.h"
#include "xparameters.h"

class Uart {
private:
	XUartPs myUart;
public:
	Uart();
	int Readbyte();
	virtual ~Uart();
};

#endif /* SRC_UART_H_ */
