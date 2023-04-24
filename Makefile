CC = gcc
LD = ld
CCFLAGS = -static -fno-builtin -fno-strict-aliasing -O2 -Wall -MD -ggdb -m64 -fno-omit-frame-pointer
CCFLAGS += $(shell $(CC) -fno-stack-protector -E -x c /dev/null >/dev/null 2>&1 && echo -fno-stack-protector)
LDFLAGS = -m elf_x86_64
OBJCOPY = objcopy

all: build qemu clean

build: monox.img

monox.img: bootsector.bin
	dd if=bootsector.bin of=monox.img bs=510 count=1
	dd if=signature of=monox.img bs=1 count=2 seek=510

bootsector.bin: src/boot.s src/boot.c
	$(CC) $(CCFLAGS) -fno-pic -O -nostdinc -I. -c -o bootmain.o src/boot.c
	$(CC) $(CCFLAGS) -fno-pic -nostdinc -I. -c -o bootasm.o src/boot.s
	$(LD) $(LDFLAGS) -N -e start -Ttext 0x7C00 -o bootblock.o bootasm.o bootmain.o
	$(OBJCOPY) -S -O binary -j .text bootblock.o bootsector.bin

qemu:
	qemu-system-x86_64 -drive file=monox.img,format=raw,index=0,media=disk

clean:
	rm -r *.o *.d *.bin
