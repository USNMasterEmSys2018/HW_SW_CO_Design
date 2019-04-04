/*
 * Leds.h
 *
 *  Created on: 28. mar. 2019
 *      Author: eitah
 */

#ifndef SRC_LEDS_H_
#define SRC_LEDS_H_

#include "xgpio.h"
#include "xparameters.h"

class Leds {
private:
	XGpio Gpio;
public:

	Leds();
	void ShowLight();
	virtual ~Leds();
};

#endif /* SRC_LEDS_H_ */
