/*
 * Buzzer.h
 *
 *  Created on: Mar 13, 2019
 *      Author: Bozhao Liu
 */

#ifndef __BUZZER_H_
#define __BUZZER_H_

#include "PmodACL2.h"
#include "xparameters.h"

class Buzzer {
private:
	PmodACL2 Buzz;
public:
	Buzzer();
	void Sing(int Freq);
	virtual ~Buzzer();
};

#endif
