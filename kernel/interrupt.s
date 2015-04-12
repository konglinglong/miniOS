	.file	"interrupt.c"
	.text
.globl invalid_opcode
	.type	invalid_opcode, @function
invalid_opcode:
	pushl	%ebp
	movl	%esp, %ebp
#APP
	subl $4, %esp
	pushl $0xFFFFFFFF
	pushl $6
	call exception_handler
	addl $4*2, %esp
	hlt
#NO_APP
	popl	%ebp
	ret
	.size	invalid_opcode, .-invalid_opcode
	.section	.rodata
.LC20:
	.string	" "
.LC21:
	.string	"Exception! --> "
.LC22:
	.string	"\n\n"
.LC23:
	.string	"EFLAGS:"
.LC24:
	.string	"    CS:"
.LC25:
	.string	"    EIP:"
.LC26:
	.string	"Error code:"
.LC0:
	.string	"#DE Divide Error"
	.zero	47
.LC1:
	.string	"#DB RESERVED"
	.zero	51
.LC2:
	.string	"\342\200\224  NMI Interrupt"
	.zero	45
.LC3:
	.string	"#BP Breakpoint"
	.zero	49
.LC4:
	.string	"#OF Overflow"
	.zero	51
.LC5:
	.string	"#BR BOUND Range Exceeded"
	.zero	39
	.align 4
.LC6:
	.string	"#UD Invalid Opcode (Undefined Opcode)"
	.zero	26
	.align 4
.LC7:
	.string	"#NM Device Not Available (No Math Coprocessor)"
	.zero	17
.LC8:
	.string	"#DF Double Fault"
	.zero	47
	.align 4
.LC9:
	.string	"    Coprocessor Segment Overrun (reserved)"
	.zero	21
.LC10:
	.string	"#TS Invalid TSS"
	.zero	48
.LC11:
	.string	"#NP Segment Not Present"
	.zero	40
.LC12:
	.string	"#SS Stack-Segment Fault"
	.zero	40
.LC13:
	.string	"#GP General Protection"
	.zero	41
.LC14:
	.string	"#PF Page Fault"
	.zero	49
	.align 4
.LC15:
	.string	"\342\200\224  (Intel reserved. Do not use.)"
	.zero	29
	.align 4
.LC16:
	.string	"#MF x87 FPU Floating-Point Error (Math Fault)"
	.zero	18
.LC17:
	.string	"#AC Alignment Check"
	.zero	44
.LC18:
	.string	"#MC Machine Check"
	.zero	46
	.align 4
.LC19:
	.string	"#XF SIMD Floating-Point Exception"
	.zero	30
	.text
.globl _exception_handler
	.type	_exception_handler, @function
_exception_handler:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	subl	$1316, %esp
	leal	-1288(%ebp), %edx
	movl	$1280, %eax
	movl	%eax, 8(%esp)
	movl	$0, 4(%esp)
	movl	%edx, (%esp)
	call	memset
	movl	.LC0, %eax
	movl	%eax, -1288(%ebp)
	movl	.LC0+4, %eax
	movl	%eax, -1284(%ebp)
	movl	.LC0+8, %eax
	movl	%eax, -1280(%ebp)
	movl	.LC0+12, %eax
	movl	%eax, -1276(%ebp)
	movzbl	.LC0+16, %eax
	movb	%al, -1272(%ebp)
	leal	-1271(%ebp), %edi
	cld
	movl	$47, %ecx
	movl	$0, %eax
	rep
	stosb
	movl	.LC1, %eax
	movl	%eax, -1224(%ebp)
	movl	.LC1+4, %eax
	movl	%eax, -1220(%ebp)
	movl	.LC1+8, %eax
	movl	%eax, -1216(%ebp)
	movzbl	.LC1+12, %eax
	movb	%al, -1212(%ebp)
	leal	-1211(%ebp), %edi
	cld
	movl	$51, %ecx
	movl	$0, %eax
	rep
	stosb
	movl	.LC2, %eax
	movl	%eax, -1160(%ebp)
	movl	.LC2+4, %eax
	movl	%eax, -1156(%ebp)
	movl	.LC2+8, %eax
	movl	%eax, -1152(%ebp)
	movl	.LC2+12, %eax
	movl	%eax, -1148(%ebp)
	movzwl	.LC2+16, %eax
	movw	%ax, -1144(%ebp)
	movzbl	.LC2+18, %eax
	movb	%al, -1142(%ebp)
	leal	-1141(%ebp), %edi
	cld
	movl	$45, %ecx
	movl	$0, %eax
	rep
	stosb
	movl	.LC3, %eax
	movl	%eax, -1096(%ebp)
	movl	.LC3+4, %eax
	movl	%eax, -1092(%ebp)
	movl	.LC3+8, %eax
	movl	%eax, -1088(%ebp)
	movzwl	.LC3+12, %eax
	movw	%ax, -1084(%ebp)
	movzbl	.LC3+14, %eax
	movb	%al, -1082(%ebp)
	leal	-1081(%ebp), %edi
	cld
	movl	$49, %ecx
	movl	$0, %eax
	rep
	stosb
	movl	.LC4, %eax
	movl	%eax, -1032(%ebp)
	movl	.LC4+4, %eax
	movl	%eax, -1028(%ebp)
	movl	.LC4+8, %eax
	movl	%eax, -1024(%ebp)
	movzbl	.LC4+12, %eax
	movb	%al, -1020(%ebp)
	leal	-1019(%ebp), %edi
	cld
	movl	$51, %ecx
	movl	$0, %eax
	rep
	stosb
	movl	.LC5, %eax
	movl	%eax, -968(%ebp)
	movl	.LC5+4, %eax
	movl	%eax, -964(%ebp)
	movl	.LC5+8, %eax
	movl	%eax, -960(%ebp)
	movl	.LC5+12, %eax
	movl	%eax, -956(%ebp)
	movl	.LC5+16, %eax
	movl	%eax, -952(%ebp)
	movl	.LC5+20, %eax
	movl	%eax, -948(%ebp)
	movzbl	.LC5+24, %eax
	movb	%al, -944(%ebp)
	leal	-943(%ebp), %edi
	cld
	movl	$39, %ecx
	movl	$0, %eax
	rep
	stosb
	movl	.LC6, %eax
	movl	%eax, -904(%ebp)
	movl	.LC6+4, %eax
	movl	%eax, -900(%ebp)
	movl	.LC6+8, %eax
	movl	%eax, -896(%ebp)
	movl	.LC6+12, %eax
	movl	%eax, -892(%ebp)
	movl	.LC6+16, %eax
	movl	%eax, -888(%ebp)
	movl	.LC6+20, %eax
	movl	%eax, -884(%ebp)
	movl	.LC6+24, %eax
	movl	%eax, -880(%ebp)
	movl	.LC6+28, %eax
	movl	%eax, -876(%ebp)
	movl	.LC6+32, %eax
	movl	%eax, -872(%ebp)
	movzwl	.LC6+36, %eax
	movw	%ax, -868(%ebp)
	leal	-866(%ebp), %edi
	cld
	movl	$26, %ecx
	movl	$0, %eax
	rep
	stosb
	movl	.LC7, %eax
	movl	%eax, -840(%ebp)
	movl	.LC7+4, %eax
	movl	%eax, -836(%ebp)
	movl	.LC7+8, %eax
	movl	%eax, -832(%ebp)
	movl	.LC7+12, %eax
	movl	%eax, -828(%ebp)
	movl	.LC7+16, %eax
	movl	%eax, -824(%ebp)
	movl	.LC7+20, %eax
	movl	%eax, -820(%ebp)
	movl	.LC7+24, %eax
	movl	%eax, -816(%ebp)
	movl	.LC7+28, %eax
	movl	%eax, -812(%ebp)
	movl	.LC7+32, %eax
	movl	%eax, -808(%ebp)
	movl	.LC7+36, %eax
	movl	%eax, -804(%ebp)
	movl	.LC7+40, %eax
	movl	%eax, -800(%ebp)
	movzwl	.LC7+44, %eax
	movw	%ax, -796(%ebp)
	movzbl	.LC7+46, %eax
	movb	%al, -794(%ebp)
	movl	$0, -793(%ebp)
	movl	$0, -789(%ebp)
	movl	$0, -785(%ebp)
	movl	$0, -781(%ebp)
	movb	$0, -777(%ebp)
	movl	.LC8, %eax
	movl	%eax, -776(%ebp)
	movl	.LC8+4, %eax
	movl	%eax, -772(%ebp)
	movl	.LC8+8, %eax
	movl	%eax, -768(%ebp)
	movl	.LC8+12, %eax
	movl	%eax, -764(%ebp)
	movzbl	.LC8+16, %eax
	movb	%al, -760(%ebp)
	leal	-759(%ebp), %edi
	cld
	movl	$47, %ecx
	movl	$0, %eax
	rep
	stosb
	movl	.LC9, %eax
	movl	%eax, -712(%ebp)
	movl	.LC9+4, %eax
	movl	%eax, -708(%ebp)
	movl	.LC9+8, %eax
	movl	%eax, -704(%ebp)
	movl	.LC9+12, %eax
	movl	%eax, -700(%ebp)
	movl	.LC9+16, %eax
	movl	%eax, -696(%ebp)
	movl	.LC9+20, %eax
	movl	%eax, -692(%ebp)
	movl	.LC9+24, %eax
	movl	%eax, -688(%ebp)
	movl	.LC9+28, %eax
	movl	%eax, -684(%ebp)
	movl	.LC9+32, %eax
	movl	%eax, -680(%ebp)
	movl	.LC9+36, %eax
	movl	%eax, -676(%ebp)
	movzwl	.LC9+40, %eax
	movw	%ax, -672(%ebp)
	movzbl	.LC9+42, %eax
	movb	%al, -670(%ebp)
	leal	-669(%ebp), %edi
	cld
	movl	$21, %ecx
	movl	$0, %eax
	rep
	stosb
	movl	.LC10, %eax
	movl	%eax, -648(%ebp)
	movl	.LC10+4, %eax
	movl	%eax, -644(%ebp)
	movl	.LC10+8, %eax
	movl	%eax, -640(%ebp)
	movl	.LC10+12, %eax
	movl	%eax, -636(%ebp)
	leal	-632(%ebp), %edi
	cld
	movl	$0, %edx
	movl	$12, %eax
	movl	%eax, %ecx
	movl	%edx, %eax
	rep
	stosl
	movl	.LC11, %eax
	movl	%eax, -584(%ebp)
	movl	.LC11+4, %eax
	movl	%eax, -580(%ebp)
	movl	.LC11+8, %eax
	movl	%eax, -576(%ebp)
	movl	.LC11+12, %eax
	movl	%eax, -572(%ebp)
	movl	.LC11+16, %eax
	movl	%eax, -568(%ebp)
	movl	.LC11+20, %eax
	movl	%eax, -564(%ebp)
	leal	-560(%ebp), %edi
	cld
	movl	$0, %edx
	movl	$10, %eax
	movl	%eax, %ecx
	movl	%edx, %eax
	rep
	stosl
	movl	.LC12, %eax
	movl	%eax, -520(%ebp)
	movl	.LC12+4, %eax
	movl	%eax, -516(%ebp)
	movl	.LC12+8, %eax
	movl	%eax, -512(%ebp)
	movl	.LC12+12, %eax
	movl	%eax, -508(%ebp)
	movl	.LC12+16, %eax
	movl	%eax, -504(%ebp)
	movl	.LC12+20, %eax
	movl	%eax, -500(%ebp)
	leal	-496(%ebp), %edi
	cld
	movl	$0, %edx
	movl	$10, %eax
	movl	%eax, %ecx
	movl	%edx, %eax
	rep
	stosl
	movl	.LC13, %eax
	movl	%eax, -456(%ebp)
	movl	.LC13+4, %eax
	movl	%eax, -452(%ebp)
	movl	.LC13+8, %eax
	movl	%eax, -448(%ebp)
	movl	.LC13+12, %eax
	movl	%eax, -444(%ebp)
	movl	.LC13+16, %eax
	movl	%eax, -440(%ebp)
	movzwl	.LC13+20, %eax
	movw	%ax, -436(%ebp)
	movzbl	.LC13+22, %eax
	movb	%al, -434(%ebp)
	leal	-433(%ebp), %edi
	cld
	movl	$41, %ecx
	movl	$0, %eax
	rep
	stosb
	movl	.LC14, %eax
	movl	%eax, -392(%ebp)
	movl	.LC14+4, %eax
	movl	%eax, -388(%ebp)
	movl	.LC14+8, %eax
	movl	%eax, -384(%ebp)
	movzwl	.LC14+12, %eax
	movw	%ax, -380(%ebp)
	movzbl	.LC14+14, %eax
	movb	%al, -378(%ebp)
	leal	-377(%ebp), %edi
	cld
	movl	$49, %ecx
	movl	$0, %eax
	rep
	stosb
	movl	.LC15, %eax
	movl	%eax, -328(%ebp)
	movl	.LC15+4, %eax
	movl	%eax, -324(%ebp)
	movl	.LC15+8, %eax
	movl	%eax, -320(%ebp)
	movl	.LC15+12, %eax
	movl	%eax, -316(%ebp)
	movl	.LC15+16, %eax
	movl	%eax, -312(%ebp)
	movl	.LC15+20, %eax
	movl	%eax, -308(%ebp)
	movl	.LC15+24, %eax
	movl	%eax, -304(%ebp)
	movl	.LC15+28, %eax
	movl	%eax, -300(%ebp)
	movzwl	.LC15+32, %eax
	movw	%ax, -296(%ebp)
	movzbl	.LC15+34, %eax
	movb	%al, -294(%ebp)
	leal	-293(%ebp), %edi
	cld
	movl	$29, %ecx
	movl	$0, %eax
	rep
	stosb
	movl	.LC16, %eax
	movl	%eax, -264(%ebp)
	movl	.LC16+4, %eax
	movl	%eax, -260(%ebp)
	movl	.LC16+8, %eax
	movl	%eax, -256(%ebp)
	movl	.LC16+12, %eax
	movl	%eax, -252(%ebp)
	movl	.LC16+16, %eax
	movl	%eax, -248(%ebp)
	movl	.LC16+20, %eax
	movl	%eax, -244(%ebp)
	movl	.LC16+24, %eax
	movl	%eax, -240(%ebp)
	movl	.LC16+28, %eax
	movl	%eax, -236(%ebp)
	movl	.LC16+32, %eax
	movl	%eax, -232(%ebp)
	movl	.LC16+36, %eax
	movl	%eax, -228(%ebp)
	movl	.LC16+40, %eax
	movl	%eax, -224(%ebp)
	movzwl	.LC16+44, %eax
	movw	%ax, -220(%ebp)
	movl	$0, -218(%ebp)
	movl	$0, -214(%ebp)
	movl	$0, -210(%ebp)
	movl	$0, -206(%ebp)
	movw	$0, -202(%ebp)
	movl	.LC17, %eax
	movl	%eax, -200(%ebp)
	movl	.LC17+4, %eax
	movl	%eax, -196(%ebp)
	movl	.LC17+8, %eax
	movl	%eax, -192(%ebp)
	movl	.LC17+12, %eax
	movl	%eax, -188(%ebp)
	movl	.LC17+16, %eax
	movl	%eax, -184(%ebp)
	leal	-180(%ebp), %edi
	cld
	movl	$0, %edx
	movl	$11, %eax
	movl	%eax, %ecx
	movl	%edx, %eax
	rep
	stosl
	movl	.LC18, %eax
	movl	%eax, -136(%ebp)
	movl	.LC18+4, %eax
	movl	%eax, -132(%ebp)
	movl	.LC18+8, %eax
	movl	%eax, -128(%ebp)
	movl	.LC18+12, %eax
	movl	%eax, -124(%ebp)
	movzwl	.LC18+16, %eax
	movw	%ax, -120(%ebp)
	leal	-118(%ebp), %edi
	cld
	movl	$46, %ecx
	movl	$0, %eax
	rep
	stosb
	movl	.LC19, %eax
	movl	%eax, -72(%ebp)
	movl	.LC19+4, %eax
	movl	%eax, -68(%ebp)
	movl	.LC19+8, %eax
	movl	%eax, -64(%ebp)
	movl	.LC19+12, %eax
	movl	%eax, -60(%ebp)
	movl	.LC19+16, %eax
	movl	%eax, -56(%ebp)
	movl	.LC19+20, %eax
	movl	%eax, -52(%ebp)
	movl	.LC19+24, %eax
	movl	%eax, -48(%ebp)
	movl	.LC19+28, %eax
	movl	%eax, -44(%ebp)
	movzwl	.LC19+32, %eax
	movw	%ax, -40(%ebp)
	leal	-38(%ebp), %edi
	cld
	movl	$30, %ecx
	movl	$0, %eax
	rep
	stosb
	movl	$0, disp_pos
	movl	$0, -8(%ebp)
	jmp	.L4
.L5:
	movl	$.LC20, (%esp)
	call	disp_str
	addl	$1, -8(%ebp)
.L4:
	cmpl	$399, -8(%ebp)
	jle	.L5
	movl	$0, disp_pos
	movl	$.LC21, (%esp)
	call	disp_str
	movl	8(%ebp), %eax
	sall	$6, %eax
	movl	%eax, %edx
	leal	-1288(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, (%esp)
	call	disp_str
	movl	$.LC22, (%esp)
	call	disp_str
	movl	$.LC23, (%esp)
	call	disp_str
	movl	24(%ebp), %eax
	movl	%eax, (%esp)
	call	disp_int
	movl	$.LC24, (%esp)
	call	disp_str
	movl	20(%ebp), %eax
	movl	%eax, (%esp)
	call	disp_int
	movl	$.LC25, (%esp)
	call	disp_str
	movl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	disp_int
	cmpl	$-1, 12(%ebp)
	je	.L9
	movl	$.LC26, (%esp)
	call	disp_str
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	disp_int
.L9:
	addl	$1316, %esp
	popl	%edi
	popl	%ebp
	ret
	.size	_exception_handler, .-_exception_handler
.globl set_gate
	.type	set_gate, @function
set_gate:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	12(%ebp), %eax
	movl	16(%ebp), %edx
	movb	%al, -20(%ebp)
	movb	%dl, -24(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	20(%ebp), %eax
	movl	%eax, %edx
	movl	-4(%ebp), %eax
	movw	%dx, (%eax)
	movl	-4(%ebp), %eax
	movw	$8, 2(%eax)
	movl	-4(%ebp), %eax
	movb	$0, 4(%eax)
	movsbl	-24(%ebp),%eax
	sall	$5, %eax
	orb	-20(%ebp), %al
	movl	%eax, %edx
	movl	-4(%ebp), %eax
	movb	%dl, 5(%eax)
	movl	20(%ebp), %eax
	shrl	$16, %eax
	movl	%eax, %edx
	movl	-4(%ebp), %eax
	movw	%dx, 6(%eax)
	leave
	ret
	.size	set_gate, .-set_gate
.globl set_idt_gate
	.type	set_idt_gate, @function
set_idt_gate:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$20, %esp
	movl	8(%ebp), %eax
	movb	%al, -4(%ebp)
	movsbl	-4(%ebp),%eax
	sall	$3, %eax
	addl	$_idt, %eax
	movl	%eax, %edx
	movl	12(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	$0, 8(%esp)
	movl	$-114, 4(%esp)
	movl	%edx, (%esp)
	call	set_gate
	leave
	ret
	.size	set_idt_gate, .-set_idt_gate
.globl set_trap_gate
	.type	set_trap_gate, @function
set_trap_gate:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$20, %esp
	movl	8(%ebp), %eax
	movb	%al, -4(%ebp)
	movsbl	-4(%ebp),%eax
	sall	$3, %eax
	addl	$_idt, %eax
	movl	%eax, %edx
	movl	12(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	$0, 8(%esp)
	movl	$-113, 4(%esp)
	movl	%edx, (%esp)
	call	set_gate
	leave
	ret
	.size	set_trap_gate, .-set_trap_gate
.globl interrupt_init
	.type	interrupt_init, @function
interrupt_init:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$invalid_opcode, %eax
	movl	%eax, 4(%esp)
	movl	$6, (%esp)
	call	set_trap_gate
	leave
	ret
	.size	interrupt_init, .-interrupt_init
	.comm	disp_pos,4,4
	.ident	"GCC: (GNU) 4.2.4 (Ubuntu 4.2.4-1ubuntu3)"
	.section	.note.GNU-stack,"",@progbits
