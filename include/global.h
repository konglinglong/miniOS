#ifndef _GLOBAL_H
#define _GLOBAL_H

#include "const.h"

#define PAGE_SIZE 4096

int disp_pos;

void disp_str(char* info);
void disp_int(int input);
void out_byte(int port, char value);
char in_byte(int port);

typedef struct desc_struct
{
	unsigned long a,b;
}desc_table[256];

extern unsigned long pg_dir[1024];	//在kernel_head.s中定义
extern desc_table _idt, _gdt;			//在kernel_head.s中定义

#endif
