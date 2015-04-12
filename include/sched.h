#ifndef _SCHED_H
#define _SCHED_H

#include "global.h"

#define NR_TASKS 8	//系统中最多的进程数

//任务状态段数据结构
struct tss_struct
{
	t_32	backlink;
	t_32	esp0;		/* stack pointer to use during interrupt */
	t_32	ss0;		/*   "   segment  "  "    "        "     */
	t_32	esp1;
	t_32	ss1;
	t_32	esp2;
	t_32	ss2;
	t_32	cr3;
	t_32	eip;
	t_32	flags;
	t_32	eax;
	t_32	ecx;
	t_32	edx;
	t_32	ebx;
	t_32	esp;
	t_32	ebp;
	t_32	esi;
	t_32	edi;
	t_32	es;
	t_32	cs;
	t_32	ss;
	t_32	ds;
	t_32	fs;
	t_32	gs;
	t_32	ldt;
	t_16	trap;
	t_16	iobase;	/* I/O位图基址大于或等于TSS段界限，就表示没有I/O许可位图 */
};

//进程表
struct task_struct
{
	long	pid;	//进程id
	struct tss_struct	tss;

};

//
struct task_struct task[NR_TASKS];

#endif
