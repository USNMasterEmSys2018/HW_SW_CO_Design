/*
 * LEDs.h
 *
 *  Created on: Mar 13, 2019
 *      Author: Bozhao Liu
 */

#ifndef __LEDS_H_
#define __LEDS_H_

#include "xgpio.h"
#include "xparameters.h"

class LEDs {
private:
	XGpio LED;
public:
	LEDs();
	void LightUp(char Note);
	virtual ~LEDs();
};

#endif
