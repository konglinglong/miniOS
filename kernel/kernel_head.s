.code32
.text
.global __idt, __gdt, _pg_dir, start_kernel

_pg_dir:

#我们的内核由此开始，让我们为它干杯！！
start_kernel:

#测试内核运行情况用，以后去掉
	movw $0x18, %ax
	movw %ax, %gs
	movb	$0xf, %ah
	movb	$'H', %al
	movw	%ax, %gs:((80*1+39)*2)

#设置各个数据段寄存器和堆栈寄存器

	movl $0x10, %eax
	movw %ax, %ds
	movw %ax, %es
	movw %ax, %fs
	movw %ax, %gs
	#movw %ax, %ss
	#movl $0x7fffff, %esp
	lssl _stack_start, %esp	#在sched.c中定义。在内核初始化过程被用作内核栈，完成后用作任务0用户态堆栈

	call setup_idt	#设置中断描述符表
	call setup_gdt	#设置全局描述符表

#强制使用刚才的设置
	ljmp $0x08, $csinit

csinit:
	movl $0x10, %eax
	movw %ax, %ds
	movw %ax, %es
	movw %ax, %fs
	movw %ax, %gs
	#movw %ax, %ss
	#movl $0x7fffff, %esp
	lssl _stack_start, %esp	#在sched.c中定义。在内核初始化过程被用作内核栈，完成后用作任务0用户态堆栈

#启用分页机制
	movl %cr0, %eax
	andl $0x80000011, %eax
	movl %eax, %cr0

	jmp after_page_tables

setup_idt:
	lea ignore_int, %edx
	movl $0x00080000, %eax
	movw %dx, %ax

	movw $0x8E00, %dx

	lea __idt, %edi
	mov $256, %ecx
rep_sidt:
	movl %eax, (%edi)
	movl %edx, 4(%edi)
	addl $8, %edi
	dec %ecx
	jne rep_sidt
	lidt idt_descr
	ret

setup_gdt:
	lgdt gdt_descr
	ret

.org 0x1000

pg0:
.org 0x2000

pg1:
.org 0x3000

pg2:
.org 0x4000

pg3:
.org 0x5000


after_page_tables:

	pushl $o_no
	pushl $_kernel_main
	jmp setup_paging
o_no:

	movw $0x10, %ax
	movw %ax, %gs
	movb	$0xf, %ah
	movb	$'N', %al
	movw	%ax, %gs:0xb8000+((80*2+39)*2)

	jmp o_no

#空的中断向量句柄
.align 4
ignore_int:
	iret

.align 4
setup_paging:
	movl $1024*5, %ecx	#首先对1页目录和4页页表清零
	xorl %eax, %eax
	xorl %edi, %edi
	cld
	rep
	stosl

#设置页目录中的项，内核只有4个页表，所以只需设置4项
	movl $pg0+7, _pg_dir
	movl $pg1+7, _pg_dir+4
	movl $pg2+7, _pg_dir+8
	movl $pg3+7, _pg_dir+12

#下面设置4个页表中所有的项，共 4*1024 = 4096项
	movl $pg3+4092, %edi
	movl $0xfff007, %eax

	std

1:	stosl
	subl $0x1000, %eax
	jge 1b

	xorl %eax, %eax
	movl %eax, %cr3

	movl %cr0, %eax
	orl $0x80000000, %eax
	movl %eax, %cr0

	ret

.align 4
.word 0

idt_descr:
	.word 256*8-1
	.long __idt

.align 4
.word 0

gdt_descr:
	.word 256*8-1
	.long __gdt

.align 8
__idt:
	.fill 256,8,0

__gdt:
	.quad 0x0000000000000000
	.quad 0x00c09a0000000fff
	.quad 0x00c0920000000fff
	.quad 0x0000000000000000
	.fill 252,8,0


