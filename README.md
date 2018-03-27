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

qemu-system-x86_64 -m 4096 -smp 4 -M pc -drive file=openwrt-x86-64-combined-ext4.img,if=none,id=openwrtdisk -device ich9-ahci,id=ahci -device ide-drive,drive=openwrtdisk,bus=ahci.0 -net nic,vlan=0,macaddr=52:54:00:AF:53:81,model=virtio -net user,vlan=0 -redir tcp:10023::23 -redir tcp:10080::80  -redir tcp:10022::22 -localtime -curses

## network
-net user, this mode need "sysctl -w net.ipv4.ping_group_range='0 2147483647'"
