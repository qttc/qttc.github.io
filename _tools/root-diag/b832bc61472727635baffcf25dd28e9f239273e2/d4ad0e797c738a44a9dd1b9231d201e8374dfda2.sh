#!/system/bin/sh
# Ищет флешку с root_diag.sh: путь монтирования у разных ГУ разный.
d="${0%/*}"
usb="${d%/*}"
if [ ! -f "$usb/root_diag.sh" ]; then
	for c in /mnt/udisk1 /mnt/udisk2 /mnt/udisk3 /mnt/udisk /udisk/single /udisk /mnt/usbdisk /storage/udisk1 /storage/udisk2; do
		if [ -f "$c/root_diag.sh" ]; then usb="$c"; break; fi
	done
fi
if [ -f "$usb/root_diag.sh" ]; then
	sh "$usb/root_diag.sh" "$usb"
fi
