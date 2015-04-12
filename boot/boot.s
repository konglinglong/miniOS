.code16
.text
	mov %cs, %ax
	mov %ax, %ds
	mov %ax, %es
	mov $BaseOfStack, %sp

#打印启动信息
	push $0x0000
	push $bmLen
	push $BootMess
	call DispStr
	add $0x6, %sp

#打印Memory Size:
	push $0x0600
	push $msLen
	push $MemSizeMess
	call DispStr
	add $0x6, %sp

#读取扩展内存大小并打印------------------------------------------------
	mov $0x88, %ah
	int $0x15
	
	push %ax
	mov $0x4, %dx

.L2:
	push %dx
	mov CursorXY, %dx
	mov $0x02, %ah
	int $0x10
	inc %dx
	mov %dx, CursorXY
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
	
#读取扩展内存大小并打印------------------------------------------------


#加载LOADER.BIN------------------------------------------------
	push %es
load_loader:

#软驱复位
	xor %ah, %ah
	xor %dl, %dl
	int $0x13

#读软盘第2分区
	mov $BaseOfLoader, %ax
	mov %ax, %es
	mov $0, %dx
	mov $0x0002, %cx
	mov $OffsetOfLoader, %bx
	mov $0x0201, %ax
	int $0x13
	jc load_loader
	pop %es
#加载LOADER.BIN------------------------------------------------


#打印成功载入LOADER.BIN的信息
	push $0x0200
	push $lmLen
	push $LoadMess
	call DispStr
	add $0x6, %sp
	
#段间跳转jmp 0x9000:0x0100 ，用二进制代码直接写入指令
#	.byte 0xea
#	.2byte 0x0100
#	.2byte 0x9000
	ljmpl $0x9000,$0x0100

#打印字符串函数（基址，长度，位置）
DispStr:
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

#栈顶地址
.set BaseOfStack, 0x7c00

.set BaseOfLoader, 0x9000	#LOADER.BIN被加载到的位置---段地址
.set OffsetOfLoader, 0x0100	#LOADER.BIN被加载到的位置---偏移地址

BootMess:
	.ascii "booting..."
.set bmLen, (.-BootMess)

LoadMess:
	.ascii "LOADER.BIN loaded succeed..."
.set lmLen, (.-LoadMess)

ReadMenError:
	.ascii "read memory error"
.set rmLen, (.-ReadMenError)

MemSizeMess:
	.ascii "Memory Size: 0x     K"
.set msLen, (.-MemSizeMess)

#光标位置
CursorXY:
	.word 0x060f

.org 510
.word 0xaa55
