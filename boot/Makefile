
CC = gcc
LD = ld
OBJCOPY = objcopy

CFLAGS = -c -Wall -fno-stack-protector -minline-all-stringops
TRIM_FLAGS = -R .pdr -R .comment -R .note -S -O binary

LDFILE_BOOT = x86_boot.ld
LDFILE_DOS = x86_dos.ld
LDFLAGS_BOOT = -T$(LDFILE_BOOT)
LDFLAGS_DOS = -T$(LDFILE_DOS)

.PHONY : all

all: boot.img

boot.bin: boot.s
	$(CC) $(CFLAGS) -o boot.o $<
	$(LD) boot.o -o boot.elf $(LDFLAGS_BOOT)
	$(OBJCOPY) $(TRIM_FLAGS) boot.elf $@

loader.bin: loader.s
	$(CC) $(CFLAGS) -o loader.o $<
	$(LD) loader.o -o loader.elf $(LDFLAGS_DOS)
	$(OBJCOPY) $(TRIM_FLAGS) loader.elf $@

boot.img: boot.bin loader.bin
	@dd if=boot.bin of=boot.img bs=512 count=1
	@dd if=loader.bin of=boot.img seek=1 bs=512 conv=sync
	@dd if=/dev/zero of=boot.img skip=2 seek=2 bs=512 count=2878


clean: 
	@rm -f *.o *.elf *.bin *.img

distclean: clean
	@rm -f boot.img
