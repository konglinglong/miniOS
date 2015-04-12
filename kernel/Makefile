CC = gcc
LD = ld
OBJCOPY = objcopy

CFLAGS = -c -Wall -fno-stack-protector -minline-all-stringops
TRIM_FLAGS=-R .pdr -R .comment -R .note -S -O binary

BOOT_DIR = ../boot/
KERNEL_INIT = ../init/
LIB_DIR = ../lib/
INCLUDE = -I ../include
LIB_OBJ = $(LIB_DIR)klib.o $(LIB_DIR)klibc.o
KERNEL_OBJ = kernel_head.o $(KERNEL_INIT)kernel_main.o interrupt.o i8259.o sched.o asm/irp.o $(LIB_OBJ)
.PHONY : all

all: kernel.bin

kernel.bin : $(KERNEL_OBJ)
	$(LD) $(KERNEL_OBJ) -o $(KERNEL_DIR)kernel.elf -s -x -Ttext 0x0000 -e start_kernel
	$(OBJCOPY) $(TRIM_FLAGS) $(KERNEL_DIR)kernel.elf $@

kernel_head.o : $(KERNEL_DIR)kernel_head.s
	$(CC) $(CFLAGS) -o $(KERNEL_DIR)kernel_head.o $<

interrupt.o : $(KERNEL_DIR)interrupt.c
	$(CC) $(CFLAGS) $(INCLUDE) -o $@ $<

i8259.o : $(KERNEL_DIR)i8259.c
	$(CC) $(CFLAGS) $(INCLUDE) -o $@ $<

sched.o : $(KERNEL_DIR)sched.c
	$(CC) $(CFLAGS) $(INCLUDE) -o $@ $<

asm/irp.o : asm/irp.s
	$(CC) $(CFLAGS) $(INCLUDE) -o $@ $<

clean: 
	@rm -f asm/*.o *.o *.elf *.bin
