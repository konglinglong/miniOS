#这个loader现在已经被载入到了0x9000:0x0100中

.code16
.text
	mov %cs, %ax	# cs ＝ 0x9000
	mov %ax, %ds
	mov %ax, %es
	mov %ax, %ss

	mov $0x100, %sp	#这个还要斟酌一下

	mov		$0xb800,%ax
	mov     %ax,%gs
	mov		$0xf,%ah
	mov		$'L',%al
	mov		%ax,%gs:((80*0+39)*2)

#加载KERNEL.BIN(假设最大64K)------------------------------------------------
	push %es
load_kernel:

#软驱入口参数：AH＝02H,AL＝扇区数,CH＝柱面号，CL＝扇区号，DH＝磁头号，DL＝驱动器(00H~7FH：软盘；80H~0FFH：硬盘)
#ES:BX＝输出缓冲区的地址

#软驱复位
	xor %ah, %ah
	xor %dl, %dl
	int $0x13

#先复制（0盘面，0磁道）剩下的16扇区
	mov BaseOfKernel, %ax
	mov %ax, %es
	mov $0, %dx
	mov $0x0003, %cx
	mov OffsetOfKernel, %bx
	mov $0x0210, %ax
	int $0x13
	jc load_kernel_error

#再复制（1盘面，0磁道）（0盘面，1磁道）（1盘面，1磁道）（0盘面，2磁道）（1盘面，2磁道）（0盘面，3磁道），共6×18扇区

	mov $16*512, %ax
	mov $0, %ch
	mov $1, %dh
	jmp 1f
2:
	mov cylinder, %ch
	mov $18*512, %ax
1:

	xadd %ax, OffsetOfKernel
	mov BaseOfKernel, %ax
	mov %ax, %es
	mov $0, %dl
	mov $0x01, %cl
	mov OffsetOfKernel, %bx
	mov $0x0212, %ax
	int $0x13
	jc load_kernel_error

	shr $1, %dh		#交替切换磁头号
	jc 4f
	mov $1, %dh
4:
	mov count, %ax
	test $1, %ax
	jnz 3f
	mov cylinder, %bl
	inc %bl
	mov %bl, cylinder
3:
	dec %ax
	mov %ax, count
	cmp $0, %ax
	jg 2b

#复制（1盘面，3磁道）
	mov $18*512, %ax
	xadd %ax, OffsetOfKernel
	mov BaseOfKernel, %ax
	mov %ax, %es
	mov $0x0100, %dx
	mov $0x0301, %cx
	mov OffsetOfKernel, %bx
	mov $0x0204, %ax
	int $0x13
	jc load_kernel_error

	pop %es

#加载KERNEL.BIN(假设最大64K)------------------------------------------------

#打印成功载入KERNEL.BIN的信息
	push $0x0400
	push $Len
	push $LoadMess
	call PrintStr
	add $0x6, %sp

#把内核头文件移动到0:0处
	mov $32*1024, %cx
	mov $0, %ax
	mov %ax, %es
	mov $0x8000, %ax
	mov %ax, %ds
	xor %si, %si
	xor %di, %di
	cld
	rep
	movsw

#恢复数据段寄存器
	mov %cs, %ax
	mov %ax, %ds
	mov %ax, %es

#加载IDT，GDT
	mov $0x9000, %ax
	mov %ax, %ds
	lidt idtptr
	lgdt gdtptr

	cli

#打开地址线A20
	in $0x92, %al
	or $0x02, %al
	out %al, $0x92

#置CR0第0位为1
	movl %cr0, %eax
	orl $1, %eax
	movl %eax, %cr0

#ljmpl 混合跳转指令16：16──>16:32 真正进入保护模式，并且到了内核中。哈哈！！！
	ljmpl $8, $0x0

load_kernel_error:
	push %ax
	mov $0x4, %dx

.L2:
	push %dx
	mov CurXY, %dx
	mov $0x02, %ah
	int $0x10
	inc %dx
	mov %dx, CurXY
	pop %dx
	cmp $0, %dx
	jle .L3
	sub $1, %dx
	pop %ax
	mov %ah, %bl
	shr $4, %bl
	cmp $9, %bl
	jg .L1
	add $0x30, %bl
	jmp .L4
.L1:
	add $0x37, %bl
.L4:
	shl $4, %ax
	push %ax
	mov %bl, %al
	mov $0x9, %ah
	mov $0x0007, %bx
	mov $1, %cx
	int $0x10
	jmp .L2
.L3:
	pop %ax
	jmp .

#打印字符串函数（基址，长度，位置）
PrintStr:
	push %bp
	mov %sp, %bp
	mov 8(%bp), %dx
	mov 6(%bp), %cx
	mov 4(%bp), %bp
	mov $0x1301, %ax
	mov $0x0007, %bx
	int $0x10
	pop %bp
	ret

BaseOfKernel:
.word 0x8000	#KERNEL.BIN被加载到的位置---基地址
OffsetOfKernel:
.word 0			#KERNEL.BIN被加载到的位置---偏移地址

count:		#要读取的磁道数
.word 6
cylinder:	#要读取的柱面号
.byte 0


LoadMess:
	.ascii "KERNEL.BIN loaded succeed..."
.set Len, (.-LoadMess)

CurXY:		#光标位置
	.word 0x0800

#全局描述符表GDT
gdt:

#第一个描述符不用
	.word 0
	.word 0
	.word 0
	.word 0
#内核代码段选择符，偏移为0x08
	.word 0x07ff
	.word 0x0000
	.word 0x9a00
	.word 0x00c0
#内核数据段描述符，偏移为0x10
	.word 0x07ff
	.word 0x0000
	.word 0x9200
	.word 0x00c0

#视频段描述符（为的是在调试时打印信息，以后可以去掉）偏移为0x18
	.word 0xffff
	.word 0x8000
	.word 0x920b
	.word 0x0000
#加载idt的lidt指令要求的6字节操作数。CPU进入保护模式之前需设置IDT表，这里先设置一个空表
idtptr:
	.word 0
	.word 0,0

#加载gdt的lgdt指令要求的6字节操作数。
gdtptr:
	.word 0x800
	.word gdt, 0x9
