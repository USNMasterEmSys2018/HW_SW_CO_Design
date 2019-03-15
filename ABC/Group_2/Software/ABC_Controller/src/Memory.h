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
	const UINTPTR StartAddr = XPAR_BRAM_1_BASEADDR;
	const UINTPTR EndAddr = XPAR_BRAM_1_HIGHADDR;
	UINTPTR CurrentAddr;
public:
	Addr()
	{
		CurrentAddr = StartAddr;
	}
	UINTPTR Address()
	{
		return CurrentAddr;
	}
	void Increment()
	{
		if(CurrentAddr < EndAddr)
		{
			CurrentAddr++;
		}
		else
		{
			CurrentAddr = StartAddr;
		}
	}
	bool operator!= (const Addr & rhs) const
	{
		return CurrentAddr != rhs.CurrentAddr;
	}
	virtual ~Addr();
};


class Memory
{
private:
	const UINTPTR StartAddr = XPAR_BRAM_1_BASEADDR;
	const UINTPTR EndAddr = XPAR_BRAM_1_HIGHADDR;
	Addr CurrentAddr, StopAddr;
public:
	Memory();
	u8 ReadNextNote();
	void SaveNote(char Note);
	void SaveNote(char Notes[], int length);
	virtual ~Memory();
};


#endif /* SRC_MEMORY_H_ */
