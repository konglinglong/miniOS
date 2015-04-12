CC = gcc
LD = ld
OBJCOPY = objcopy

CFLAGS = -c -Wall -fno-stack-protector -minline-all-stringops
TRIM_FLAGS = -R .pdr -R .comment -R .note -S -O binary

BOOT_DIR = ../boot/
KERNEL_INIT = ../init/
LIB_DIR = ../lib/
INCLUDE = -I ../include

.PHONY : all

all: kernel_main.o

kernel_main.o : $(KERNEL_INIT)kernel_main.c
	$(CC) $(CFLAGS) $(INCLUDE) -o $@ $<

clean: 
	@rm -f *.o *.elf *.bin
