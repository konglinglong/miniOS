.global _divide_error, _debug, _nmi, _breakpoint_exception, _overflow, _bounds_check
.global _inval_op, _copr_not_availabile, _double_fault, _copr_seg_overrun, _inval_tss
.global _segment_not_present, _stack_exception, _general_protection, _page_fault, _copr_error


_divide_error:
	push $0xFFFFFFFF
	push $0
	jmp _exception
_debug:
	push $0xFFFFFFFF
	push $1
	jmp _exception
_nmi:
	push $0xFFFFFFFF
	push $2
	jmp _exception
_breakpoint_exception:
	push $0xFFFFFFFF
	push $3
	jmp _exception
_overflow:
	push $0xFFFFFFFF
	push $4
	jmp _exception
_bounds_check:
	push $0xFFFFFFFF
	push $5
	jmp _exception
_inval_op:
	push $0xFFFFFFFF
	push $6
	jmp _exception
_copr_not_availabile:
	push $0xFFFFFFFF
	push $7
	jmp _exception
_double_fault:
	push $8
	jmp _exception
_copr_seg_overrun:
	push $0xFFFFFFFF
	push $9
	jmp _exception
_inval_tss:
	push $10
	jmp _exception
_segment_not_present:
	push $11
	jmp _exception
_stack_exception:
	push $12
	jmp _exception
_general_protection:
	push $13
	jmp _exception
_page_fault:
	push $14
	jmp _exception
_copr_error:
	push $0xFFFFFFFF
	push $16
	jmp _exception
_exception:
	call _exception_handler
	add $4*2, %esp
	hlt
