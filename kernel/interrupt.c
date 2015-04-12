#include "global.h"
#include "interrupt.h"

// 0~16号中断异常处理程序原型，函数代码在kernel/asm/irp.s中
void divide_error(void);
void debug(void);
void nmi(void);
void breakpoint_exception(void);
void overflow(void);
void bounds_check(void);
void inval_op(void);
void copr_not_availabile(void);
void double_fault(void);
void copr_seg_overrun(void);
void inval_tss(void);
void segment_not_present(void);
void stack_exception(void);
void general_protection(void);
void page_fault(void);
void copr_error(void);

void timer_interrupt(void);

//用于显示中断异常的信息
void exception_handler(int vec_no, int err_code, int eip, int cs, int eflags)
{
	int i, temp;
	char err_description[][64] = {
					"#DE Divide Error",
					"#DB RESERVED",
					"—  NMI Interrupt",
					"#BP Breakpoint",
					"#OF Overflow",
					"#BR BOUND Range Exceeded",
					"#UD Invalid Opcode (Undefined Opcode)",
					"#NM Device Not Available (No Math Coprocessor)",
					"#DF Double Fault",
					"    Coprocessor Segment Overrun (reserved)",
					"#TS Invalid TSS",
					"#NP Segment Not Present",
					"#SS Stack-Segment Fault",
					"#GP General Protection",
					"#PF Page Fault",
					"—  (Intel reserved. Do not use.)",
					"#MF x87 FPU Floating-Point Error (Math Fault)",
					"#AC Alignment Check",
					"#MC Machine Check",
					"#XF SIMD Floating-Point Exception"
				};

	/* 通过打印空格的方式清空屏幕的前五行，并把 disp_pos 清零 */
	temp = disp_pos;
	disp_pos = 0;
	for(i=0;i<80*3;i++){
		disp_str(" ");
	}
	disp_pos = 0;

	disp_str("Exception! --> ");
	disp_str(err_description[vec_no]);
	disp_str("\n\n");
	disp_str("EFLAGS:");
	disp_int(eflags);
	disp_str("    CS:");
	disp_int(cs);
	disp_str("    EIP:");
	disp_int(eip);

	if(err_code != 0xFFFFFFFF){
		disp_str("Error code:");
		disp_int(err_code);
	}
	disp_pos = temp;
}

//设置门描述符
void set_gate(t_32 gate_addr, t_8 type, t_8 dpl, t_32 h_addr)
{
	GATE* p_gate = (GATE*)gate_addr;
	p_gate->offset_low = h_addr & 0xFFFF;
	p_gate->selector = 0x0008;
	p_gate->dcount = 0;
	p_gate->attr = type | (dpl<<5);
	p_gate->offset_high = (h_addr >> 16) & 0xFFFF;
}

//设置中断门函数
void set_idt_gate(t_8 n, t_32 addr)
{
	set_gate( (t_32)&_idt[n], (t_8)0x8E, (t_8)0, addr);
}

//设置陷阱门函数
void set_trap_gate(t_8 n, t_32 addr)
{
	set_gate( (t_32)&_idt[n], (t_8)0x8F, (t_8)0, addr);
}


//中断门、陷阱门初始化函数
void interrupt_init(void)
{
	set_idt_gate(0, (t_32)&divide_error);
	set_idt_gate(1, (t_32)&debug);
	set_trap_gate(2, (t_32)&nmi);
	set_trap_gate(3, (t_32)&breakpoint_exception);
	set_trap_gate(4, (t_32)&overflow);
	set_idt_gate(5, (t_32)&bounds_check);
	set_idt_gate(6, (t_32)&inval_op);
	set_idt_gate(7, (t_32)&copr_not_availabile);
	set_idt_gate(8, (t_32)&double_fault);
	set_idt_gate(9, (t_32)&copr_seg_overrun);
	set_idt_gate(10, (t_32)&inval_tss);
	set_idt_gate(11, (t_32)&segment_not_present);
	set_idt_gate(12, (t_32)&stack_exception);
	set_idt_gate(13, (t_32)&general_protection);
	set_idt_gate(14, (t_32)&page_fault);
	set_idt_gate(16, (t_32)&copr_error);
	set_idt_gate(0x20, (t_32)&timer_interrupt);

}
