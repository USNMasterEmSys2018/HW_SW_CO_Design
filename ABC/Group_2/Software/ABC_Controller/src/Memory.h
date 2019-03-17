/*
 * Memory.h
 *
 *  Created on: Mar 15, 2019
 *      Author: Bozhao Liu
 */

#ifndef SRC_MEMORY_H_
#define SRC_MEMORY_H_

#include "xil_types.h"
#include "xparameters.h"

class Addr
{
private:
	const long int StartAddr = XPAR_BRAM_1_BASEADDR;
	const long int EndAddr = XPAR_BRAM_1_HIGHADDR;
	long int CurrentAddr;
public:
	Addr()
	{
		CurrentAddr = StartAddr;
	}
	long int Address()
	{
		return CurrentAddr;
	}
	void Increment()
	{
		CurrentAddr = CurrentAddr + 8;
		if(CurrentAddr >= EndAddr - 7)
		{
			CurrentAddr = StartAddr;
		}
	}
	bool operator!= (const Addr & rhs) const
	{
		return CurrentAddr != rhs.CurrentAddr;
	}
};


class Memory
{
private:
	const long int StartAddr = XPAR_BRAM_1_BASEADDR;
	const long int EndAddr = XPAR_BRAM_1_HIGHADDR;
	Addr CurrentAddr, StopAddr;
public:
	u8 ReadNextNote();
	void SaveNote(char Note);
	void SaveNote(char Notes[], int length);
};


#endif /* SRC_MEMORY_H_ */
