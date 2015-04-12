#include "global.h"
#include "interrupt.h"
#include "sched.h"

void kernel_main(void)
{
	int i;
	disp_pos = 0;
	for(i=0; i<80*25; i++)
			disp_str(" ");

	disp_pos = (80*4+0)*2;
	disp_str("--- now kernel_main beginning ---\n\n");

	init_8259A();
	interrupt_init();

	//初始化各个任务的进程表
	for(i=0; i<NR_TASKS; i++)
	{
		disp_str("init tasks\n");
	}

	out_byte(0x21, 0xFE);
//	out_byte(0xA1, 0xFF);

	__asm__ __volatile__
	(
//	"ud2\n\t"
	"movw $0x10, %ax\n\t"
	"movw %ax, %gs\n\t"
	"movb	$0xf, %ah\n\t"
	"movb	$'M', %al\n\t"
	"movw	%ax, %gs:0xb8000+((80*3+39)*2)\n\t"
	"sti\n\t"
	"jmp ."
	);

}
