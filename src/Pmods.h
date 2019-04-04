/*
 * Pmods.h
 *
 *  Created on: 28. mar. 2019
 *      Author: eitah
 */

#ifndef SRC_PMODS_H_
#define SRC_PMODS_H_

#include "PmodGPIO.h"


class Pmods {
private:
	PmodGPIO jb;
public:
	Pmods();
	void setOutput(u8 pinNum, u8 value);
	u8 getInput(u8 pinNum);
	virtual ~Pmods();
};

#endif /* SRC_PMODS_H_ */
