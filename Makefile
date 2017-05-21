LINUX := /root/workspace/linux-4.4.40
BUSYBOX := /root/workspace/busybox-1.26.0

ifneq ($(linux), )
	LINUX=$(linux)
endif

ifneq ($(busybox), )
	BUSYBOX=$(busybox)
endif

default: kernel.img rootfs.img

run: kernel.img rootfs.img
	qemu-system-x86_64 -kernel kernel.img -append "root=/dev/sda rw init=/sbin/init" -hda rootfs.img -curses -net nic,model=e1000 -net tap,vlan=0

debug: kernel.img rootfs.img
	qemu-system-x86_64 -kernel kernel.img -append "root=/dev/ram rdinit=/sbin/init kgdboc=ttyS0,115200 kgdbwait" -initrd rootfs.img -net nic,model=e1000 -net user -serial tcp::1234,server -curses &
#	TMPFILE=$$(mktemp) && echo "target remote localhost:1234" > $$TMPFILE && gdb -x $$TMPFILE $(LINUX)/vmlinux

clean:
	rm -f kernel.img rootfs.img

update: $(LINUX)/.config $(BUSYBOX)/.config
	yes "" | make -C $(LINUX) oldconfig
	yes "" | make -C $(BUSYBOX) oldconfig

kernel.img: $(LINUX)/.config
	make -C $(LINUX) bzImage -j4
	cp $(LINUX)/arch/x86/boot/bzImage $@

rootfs.img: $(BUSYBOX)/.config
	make -C $(BUSYBOX) install -j4
	./mkrootfs $@ $(BUSYBOX)

install $(LINUX)/.config $(BUSYBOX)/.config:
	./install $(LINUX) $(BUSYBOX)

.PHONY: default run debug clean update install
