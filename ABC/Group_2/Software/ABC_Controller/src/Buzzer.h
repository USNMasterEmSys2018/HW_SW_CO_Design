/*
 * Buzzer.h
 *
 *  Created on: Mar 13, 2019
 *      Author: Bozhao Liu
 */

#ifndef __BUZZER_H_
#define __BUZZER_H_

#include "PmodGPIO.h"
#include "xparameters.h"

class Buzzer {
private:
	PmodGPIO Buzz;
public:
	Buzzer();
	void Sing(int Freq);
	virtual ~Buzzer();
};

#endif
