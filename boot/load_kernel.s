#读软盘第3分区(KERNEL.BIN)
	mov BaseOfKernel, %ax
	mov %ax, %es
	mov $0, %dx
	mov $0x0003, %cx
	mov OffsetOfKernel, %bx
	mov $0x0210, %ax
	int $0x13
	jc load_kernel_error
	
	
	mov $16*512, %ax
	xadd %ax, OffsetOfKernel
	mov BaseOfKernel, %ax
	mov %ax, %es
	mov $0, %dx
	mov $0x0101, %cx
	mov OffsetOfKernel, %bx
	mov $0x0212, %ax
	int $0x13
	jc load_kernel_error
	
	mov $18*512, %ax
	xadd %ax, OffsetOfKernel
	mov BaseOfKernel, %ax
	mov %ax, %es
	mov $0, %dx
	mov $0x0201, %cx
	mov OffsetOfKernel, %bx
	mov $0x0212, %ax
	int $0x13
	jc load_kernel_error
	
	mov $18*512, %ax
	xadd %ax, OffsetOfKernel
	mov BaseOfKernel, %ax
	mov %ax, %es
	mov $0, %dx
	mov $0x0301, %cx
	mov OffsetOfKernel, %bx
	mov $0x0212, %ax
	int $0x13
	jc load_kernel_error
	
	mov $18*512, %ax
	xadd %ax, OffsetOfKernel
	mov BaseOfKernel, %ax
	mov %ax, %es
	mov $0, %dx
	mov $0x0401, %cx
	mov OffsetOfKernel, %bx
	mov $0x0212, %ax
	int $0x13
	jc load_kernel_error
	
	mov $18*512, %ax
	xadd %ax, OffsetOfKernel
	mov BaseOfKernel, %ax
	mov %ax, %es
	mov $0, %dx
	mov $0x0501, %cx
	mov OffsetOfKernel, %bx
	mov $0x0212, %ax
	int $0x13
	jc load_kernel_error
	
	mov $18*512, %ax
	xadd %ax, OffsetOfKernel
	mov BaseOfKernel, %ax
	mov %ax, %es
	mov $0, %dx
	mov $0x0601, %cx
	mov OffsetOfKernel, %bx
	mov $0x0212, %ax
	int $0x13
	jc load_kernel_error
	
	mov $18*512, %ax
	xadd %ax, OffsetOfKernel
	mov BaseOfKernel, %ax
	mov %ax, %es
	mov $0, %dx
	mov $0x0701, %cx
	mov OffsetOfKernel, %bx
	mov $0x0204, %ax
	int $0x13
	jc load_kernel_error
	
	pop %es

#加载KERNEL.BIN------------------------------------------------
