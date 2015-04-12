CC = gcc
LD = ld
OBJCOPY = objcopy

CFLAGS = -c -fno-stack-protector -minline-all-stringops
TRIM_FLAGS = -R .pdr -R .comment -R .note -S -O binary

BOOT_DIR = ../boot/
KERNEL_INIT = ../init/
INCLUDE = -I ../include

.PHONY : all

all: klib.o klibc.o

klib.o : klib.s ../include/global.h
	$(CC) $(CFLAGS) $(INCLUDE) -o $@ $<

klibc.o : klibc.c
	$(CC) $(CFLAGS) $(INCLUDE) -o $@ $<

clean: 
	@rm -f *.o *.elf *.bin
