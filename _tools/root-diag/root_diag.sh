#!/system/bin/sh
# Диагностика следов root (KingRoot, Kingo, SuperSU и др.) на ГУ Coolray / Belgee X50.
# Только чтение: ничего не удаляет, /system не перемонтирует. Лог — root_diag_log.txt на флешке.

export PATH=/sbin:/system/sbin:/system/xbin:/system/bin
usb="$1"
exec >"$usb/root_diag_log.txt" 2>&1

s() { echo; echo "=== $*"; }

s "info"
echo "root_diag v1"
date
id
for p in ro.build.id ro.build.display.id ro.build.version.release ro.product.model; do
	echo "$p=$(getprop $p)"
done

s "mount"
mount

s "known root files"
for f in \
	/system/xbin/su /system/bin/su /sbin/su /system/sbin/su \
	/system/xbin/daemonsu /system/xbin/sugote /system/xbin/sugote-mksh /system/xbin/supolicy \
	/system/xbin/ku.sud /system/xbin/kugote /system/bin/kugote \
	/system/bin/.ext /system/bin/.ext/.su /system/xbin/.su /system/bin/.su \
	/system/usr/iku /system/usr/iku/isu \
	/system/bin/rt.sh /system/bin/ddexe /system/bin/ddexe_real /system/bin/ddexe-ku.bak \
	/system/bin/debuggerd_real /system/bin/debuggerd-ku.bak \
	/system/bin/install-recovery.sh /system/etc/install-recovery.sh \
	/system/etc/install-recovery-2.sh /system/etc/install_recovery.sh \
	/system/bin/app_process32_original /system/bin/app_process_init \
	/system/etc/.installed_su_daemon /system/etc/.has_su_daemon \
	/system/etc/init.d /system/etc/init.d/99SuperSUDaemon \
	/system/lib/libsupol.so \
	/system/app/Kinguser.apk /system/app/kinguser.apk /system/app/Kinguser \
	/system/priv-app/Kinguser /system/priv-app/Kinguser.apk \
	/system/app/KingoUser.apk /system/app/Superuser.apk /system/app/SuperSU /system/app/SuperSU.apk \
	/data/data/com.kingroot.kinguser /data/data/com.kingouser.com /data/data/com.kingo.root \
	/data/data/com.kingroot.master /data/data/eu.chainfire.supersu \
	/data/data-lib/king /data/data-lib/com.kingroot.kinguser \
	/data/app/com.kingroot.* /data/app/com.kingouser.* /data/app/com.kingo.* \
	/data/app/eu.chainfire.supersu*
do
	if [ -e "$f" ] || [ -h "$f" ]; then ls -ld "$f"; fi
done

s "suspicious names"
for d in /system/bin /system/xbin /system/sbin /sbin /system/etc /system/lib \
	/system/app /system/priv-app /data/app /data/data /data/data-lib /data/local/tmp; do
	for f in "$d"/* "$d"/.*; do
		n="${f##*/}"
		case "$n" in
			.|..|'*'|'.*') ;;
			su|.su|su.*|*.su|*sud|*sugote*|*daemonsu*|*supol*|*superuser*|*Superuser*|*SuperSU*|\
			*king*|*King*|*kugote*|*ddexe*|*root*|*Root*|*install-recovery*|*install_recovery*|\
			*magisk*|*Magisk*|rt.sh|*iku*|*_real|*_original|*.bak)
				ls -ld "$f" ;;
		esac
	done
done

s "listings"
for d in /system/xbin /system/bin/.ext /system/etc/init.d /system/usr/iku /system/app /system/priv-app; do
	echo "--- $d"
	ls -la "$d"
done

s "install-recovery content"
for f in /system/bin/install-recovery.sh /system/etc/install-recovery.sh /system/etc/install-recovery-2.sh; do
	if [ -f "$f" ]; then echo "--- $f"; cat "$f"; fi
done

s "replaced system binaries"
ls -l /system/bin/debuggerd* /system/bin/app_process* /system/bin/ddexe* /system/bin/sh /system/bin/mksh

s "packages"
pm list packages -f

s "processes"
ps

s "su version"
for f in /system/xbin/su /system/bin/su; do
	if [ -x "$f" ]; then echo "--- $f"; "$f" -v; fi
done

s "DONE"
sync
