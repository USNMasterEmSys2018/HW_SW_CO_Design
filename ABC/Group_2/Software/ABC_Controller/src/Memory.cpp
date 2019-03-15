/*
 * Memory.cpp
 *
 *  Created on: Mar 15, 2019
 *      Author: Bozhao Liu
 */

#include "Memory.h"
#include "xil_io.h"

Memory::Memory() {
	// TODO Auto-generated constructor stub
}

u8 Memory::ReadNextNote()
{
	char note = 'H'; // return an invalid note by default
	if(CurrentAddr != StopAddr)
	{
		note = Xil_In8(CurrentAddr.Address());
		CurrentAddr.Increment();
	}
	return note;
}

void Memory::SaveNote(char Note)
{
	if((Note < 72 && Note > 64) ||(Note < 104 && Note > 96) )
	{
		Xil_Out8(StopAddr.Address(), Note);
		StopAddr.Increment();
	}
}

void Memory::SaveNote(char Notes[], int length)
{
	for(int i; i < length; i++)
	{
		if((Notes[i] < 72 && Notes[i] > 64) ||(Notes[i] < 104 && Notes[i] > 96) )
		{
			Xil_Out8(StopAddr.Address(), Notes[i]);
			StopAddr.Increment();
		}
	}
}
Memory::~Memory() {
	// TODO Auto-generated destructor stub
}

