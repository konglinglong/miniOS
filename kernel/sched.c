#include "sched.h"

long user_stack[PAGE_SIZE>>3];
struct
{
	long *a;
	short b;
}stack_start = {&user_stack[PAGE_SIZE>>3], 0x10};

void timer_interrupt(void)
{
	disp_str("timer_interrup \n");
	__asm__ __volatile__
	(
	"movw $0x10, %ax\n\t"
	"movw %ax, %gs\n\t"
	"movb	$0xf, %ah\n\t"
	"movb	$'M', %al\n\t"
	"movw	%ax, %gs:0xb8000+((80*5+39)*2)\n\t"
	"movb $0x20, %al\n\t"
	"outb %al, $0x20\n\t"
	"iret\n\t"
	);
}
