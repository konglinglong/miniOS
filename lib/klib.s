#include "global.h"

.text

.global _disp_str
.global _out_byte
.global _in_byte

#-----------------void disp_str(char* info)-------------
_disp_str:
	pushl %ebp
	movl %esp, %ebp
	
	movl 8(%ebp), %esi
	movl _disp_pos, %edi
	movb $0xf, %ah
.1:
	cld
	lodsb
	test %al, %al
	jz .2
	cmp $0x0A, %al		#是回车吗?
	jnz .3
	pushl %eax
	movl %edi, %eax
	movb $160, %bl
	divb %bl
	andl $0xff, %eax
	inc %eax
	movb $160, %bl
	mulb %bl
	movl %eax, %edi
	popl %eax
	jmp .1
.3:
	movw %ax, %gs:0xb8000(%edi)
	addl $2, %edi
	jmp .1
.2:
	movl %edi, _disp_pos
	popl %ebp
	ret

#----------void out_byte(t_port port, t_8 value)----------
_out_byte:
	movl 4(%esp), %edx	#port
	movb 8(%esp), %al	#value
	outb %al, %dx
	nop
	nop
	ret
	
#---------t_8 in_byte(t_port port)--------------------------
_in_byte:
	movl 4(%esp), %edx
	xorl %eax, %eax
	inb %dx, %al
	nop
	nop
	ret

