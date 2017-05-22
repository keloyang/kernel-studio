# kernel-studio

Kernel developing and debugging environment.

## warning

Before everything, do read and get through each file.

## requirements

 * gcc
 * gdb
 * make
 * QEMU
 * C libraries(static)

## install

	make install

## run testing system

	make run

## run debugging system(kgdb)

	make debug
## run qemu
qemu-system-x86_64 -M pc -kernel bzImage -drive file=rootfs.ext2,if=ide -append "root=/dev/sda rw console=ttyS0 selinux=1" -net nic,model=rtl8139 -net user -display none -serial stdio
