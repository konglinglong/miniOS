
CC = gcc
LD = ld
OBJCOPY = objcopy

CFLAGS = -c -Wall -fno-stack-protector -minline-all-stringops
TRIM_FLAGS=-R .pdr -R .comment -R .note -S -O binary

LDFILE_BOOT = $(BOOT_DIR)x86_boot.ld
LDFILE_DOS = $(BOOT_DIR)x86_dos.ld
LDFLAGS_BOOT = -T$(LDFILE_BOOT)
LDFLAGS_DOS = -T$(LDFILE_DOS)

BOOT_DIR = boot/
KERNEL_DIR = kernel/
KERNEL_INIT = init/
LIB_DIR = lib/
INCLUDE = -I include
LONG_LINUX_BOOT = $(BOOT_DIR)boot.bin $(BOOT_DIR)loader.bin
LONG_LINUX_KERNEL = $(KERNEL_DIR)kernel.bin

.PHONY : all

all: miniOS.img

miniOS.img : $(LONG_LINUX_BOOT) $(LONG_LINUX_KERNEL)
	@filesize=$(shell du -b $(BOOT_DIR)boot.bin | tr -cs "[0-9]" "[\012*]"); \
	filesize=`expr $$filesize + 511`; \
	filesize=`expr $$filesize / 512`; \
	dd if=$(BOOT_DIR)boot.bin of=miniOS.img bs=512 count=$$filesize; \
	seeksize=$$filesize; \
	filesize=`du -b $(BOOT_DIR)loader.bin | tr -cs "[0-9]" "[\012*]"`; \
	filesize=`expr $$filesize + 511`; \
	filesize=`expr $$filesize / 512`; \
	dd if=$(BOOT_DIR)loader.bin of=miniOS.img seek=$$seeksize bs=512 count=$$filesize  conv=sync; \
	seeksize=`expr $$seeksize + $$filesize`; \
	filesize=`du -b $(KERNEL_DIR)kernel.bin | tr -cs "[0-9]" "[\012*]"`; \
	filesize=`expr $$filesize + 511`; \
	filesize=`expr $$filesize / 512`; \
	dd if=$(KERNEL_DIR)kernel.bin of=miniOS.img seek=$$seeksize bs=512 count=$$filesize conv=sync; \
	seeksize=`expr $$seeksize + $$filesize`; \
	filesize=`expr 2880 - $$seeksize`; \
	dd if=/dev/zero of=miniOS.img seek=$$seeksize bs=512 count=$$filesize

$(LONG_LINUX_BOOT) :
	(cd boot;make)

$(LONG_LINUX_KERNEL) :
	(cd lib;make)
	(cd init;make)
	(cd kernel;make)


clean: 
	@rm -f *.img
	(cd boot;make clean)
	(cd init;make clean)
	(cd kernel;make clean)
	(cd lib;make clean)

realclean: clean
	@rm -f miniOS.img
