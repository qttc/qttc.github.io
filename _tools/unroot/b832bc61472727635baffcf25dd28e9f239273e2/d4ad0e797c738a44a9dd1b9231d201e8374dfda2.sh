#!/system/bin/sh
# Обёртка: стоковый update.sh запускает этот файл (sh < …) без аргументов.
# Находим флешку по маркеру unroot.sh и зовём его, передав путь.
export PATH=/sbin:/system/sbin:/system/xbin:/system/bin
usb=""
d="${0%/*}"; p="${d%/*}"
[ -f "$p/unroot.sh" ] && usb="$p"
if [ -z "$usb" ]; then
	for c in /mnt/udisk1 /mnt/udisk2 /mnt/udisk3 /mnt/udisk /udisk/single /udisk /mnt/usbdisk /storage/udisk1 /storage/udisk2; do
		[ -f "$c/unroot.sh" ] && { usb="$c"; break; }
	done
fi
[ -n "$usb" ] && sh "$usb/unroot.sh" "$usb"
