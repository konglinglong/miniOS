#ifndef _INTERRUPT_H
#define _INTERRUPT_H

#include "global.h"
#include "const.h"

void init_8259A(void);
void interrupt_init(void);

typedef struct s_gate
{
	unsigned short offset_low;
	unsigned short selector;
	unsigned char dcount;
	unsigned char attr;
	unsigned short offset_high;
}GATE;



#endif
