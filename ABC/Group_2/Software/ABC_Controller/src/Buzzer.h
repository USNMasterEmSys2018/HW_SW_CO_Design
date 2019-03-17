/*
 * Buzzer.h
 *
 *  Created on: Mar 13, 2019
 *      Author: Bozhao Liu
 */

#ifndef __BUZZER_H_
#define __BUZZER_H_

#include <stdio.h>
//#include 'Buzzer.h'
#include "PmodGPIO.h"
#include "xparameters.h"

#include <unistd.h>

const char NOTES[14] = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'a', 'b', 'c', 'd', 'e', 'f', 'g'};
const int Freqs[15] = {44000/*A 4*/, 49388/*B 4*/, 26163/*C 4*/, 29366/*D 4*/, 32963/*E 4*/, 34923/*F 4*/, 39200/*G 4*/, 88000/*a 5*/, 98777/*b 5*/, 52325/*c 5*/, 58733/*d 5*/, 65925/*e 5*/, 69846/*f 5*/, 78399/*g 5*/, 999999};

class Buzzer {
private:
	PmodGPIO Buzz;
	int Get100Freq(char note);
public:
	Buzzer();
	void Sing(char note);
	virtual ~Buzzer();
};


#endif
