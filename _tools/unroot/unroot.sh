#!/system/bin/sh
# Снятие root (KingRoot / SuperSU / RootMaster) на ГУ Geely Coolray / Belgee X50, Android 4.3.
# Удаляет файлы root и восстанавливает подменённые системные бинарники ТОЛЬКО из бэкапов
# самой машины (имя бэкапа берётся из списка ИЛИ из текста самого перехватчика). Стоковые
# бинарники с собой НЕ носит. Подменён бинарник, а оригинала нет → НЕ чинит (иначе кирпич),
# требует базовую перепрошивку.
#
# РЕЖИМЫ (по файлам-маркерам в корне флешки):
#   нет маркера   → DRY-RUN: только смотрит и пишет лог, НИЧЕГО не меняет (безопасно).
#   файл "doit"   → реально удаляет/восстанавливает.
#   файл "reboot" → перезагрузить ГУ после работы (только вместе с doit).
#
# $1 — путь к флешке (передаёт обёртка). Лог: unroot_log.txt там же.
# ВАЖНО: toolbox rm на Android 4.3 за один вызов удаляет только ПЕРВЫЙ аргумент — по одному.

export PATH=/sbin:/system/sbin:/system/xbin:/system/bin
usb="$1"
[ -n "$usb" ] || usb="."
exec >"$usb/unroot_log.txt" 2>&1
set -x

fails=0
NEEDSTOCK=0
DRYRUN=1; [ -f "$usb/doit" ] && DRYRUN=0
DOREBOOT=0; [ -f "$usb/reboot" ] && DOREBOOT=1
warn() { echo "[!] $*"; fails=$((fails+1)); }
log()  { echo "[*] $*"; }

BB=/system/bin/busybox
[ -x "$BB" ] || BB=/system/xbin/busybox
[ -x "$BB" ] || BB=""
[ -n "$BB" ] || warn "busybox не найден — chattr/ELF/md5-проверки ограничены"

md5of() { [ -f "$1" ] || { echo "-"; return; }; md5 "$1" 2>/dev/null | cut -d' ' -f1 || { [ -n "$BB" ] && "$BB" md5sum "$1" 2>/dev/null | cut -d' ' -f1; }; }
lsattr1() { [ -n "$BB" ] && "$BB" lsattr "$1" 2>/dev/null; }

is_elf() {
	[ -f "$1" ] || return 1
	[ -n "$BB" ] || return 1
	m="$("$BB" head -c 4 "$1" 2>/dev/null | "$BB" od -An -tx1 2>/dev/null | "$BB" tr -d ' \n' 2>/dev/null)"
	[ "$m" = "7f454c46" ]
}
is_good_backup() {
	[ -f "$1" ] || return 1
	[ -h "$1" ] && return 1
	[ -s "$1" ] || return 1
	if [ -n "$BB" ]; then is_elf "$1" || { warn "бэкап $1 не ELF — пропускаю"; return 1; }; fi
	return 0
}
is_hijacker() {
	is_elf "$1" && return 1
	if [ -n "$BB" ]; then "$BB" grep -qE 'su --daemon|daemonsu|ku\.sud|rt\.sh|/xbin/su' "$1" 2>/dev/null
	else grep -qE 'su --daemon|daemonsu|ku\.sud|rt\.sh|/xbin/su' "$1" 2>/dev/null; fi
}

echo "===== unroot start $(date) ====="
id
echo "id=$(getprop ro.build.id) dev=$(getprop ro.product.device) sdk=$(getprop ro.build.version.sdk)"
if [ "$DRYRUN" = 1 ]; then
	echo "### РЕЖИМ: DRY-RUN (ничего не меняю). Для реальной чистки положи файл 'doit' в корень флешки."
else
	echo "### РЕЖИМ: БОЕВОЙ (doit) — реально удаляю/восстанавливаю."
fi

# ---------- СКАН (только чтение) ----------
echo "--- СКАН: подменяемые бинарники ---"
for t in /system/bin/debuggerd /system/bin/debuggerd64 /system/bin/ddexe /system/bin/app_process /system/bin/install-recovery.sh /system/etc/install-recovery.sh; do
	if [ -e "$t" ] || [ -h "$t" ]; then
		if is_elf "$t"; then ty="ELF"; elif [ -h "$t" ]; then ty="SYMLINK->$(readlink "$t" 2>/dev/null)"; else ty="script/other"; fi
		echo "  $t : $ty md5=$(md5of "$t") attr=$(lsattr1 "$t")"
		if ! is_elf "$t" && [ -f "$t" ]; then echo "    --- содержимое $t:"; sed -n '1,8p' "$t" 2>/dev/null | sed 's/^/    | /'; fi
	fi
done
echo "--- СКАН: найденные бэкапы ---"
ls -l /system/bin/*_real /system/bin/*-ku.bak /system/bin/*.bak /system/bin/*_original /system/xbin/*_real 2>/dev/null
echo "--- СКАН: файлы root ---"
for f in /system/xbin/su /system/bin/su /system/xbin/ku.sud /system/xbin/kugote /system/xbin/krdem \
	/system/xbin/supolicy /system/xbin/daemonsu /system/xbin/sugote /system/bin/rt.sh \
	/system/usr/iku/isu /system/etc/kds /system/etc/install-recovery-2.sh /system/bin/.ext/.su \
	/system/app/Kinguser.apk /system/app/Superuser.apk \
	/system/bin/shuamesu /system/xbin/bdsu /system/xbin/mu; do
	if [ -e "$f" ] || [ -h "$f" ]; then echo "  есть: $f attr=$(lsattr1 "$f")"; fi
done
echo "--- СКАН: пакеты root ---"
pm list packages 2>/dev/null | grep -iE 'king|root|supersu|chainfire|shuame|permmgr|user2root' | tr -d '\r'

# --- remount rw (в dry-run не пишем на /system) ---
if [ "$DRYRUN" = 0 ]; then
	mount -o remount,rw /system /system
	mount -o rw,remount /system 2>/dev/null
	RW="/system/.unroot_rw.$$"; rm -f "$RW" 2>/dev/null
	if ! ( : > "$RW" ) 2>/dev/null; then echo "[x] /system не в rw — выход"; echo "===== aborted $(date) ====="; sync; exit 1; fi
	rm -f "$RW"; log "/system rw OK"
else
	echo "[*] mount /system: $(mount | grep ' /system ')"
fi

# ---------- действия ----------
del() {
	if [ -e "$1" ] || [ -h "$1" ]; then
		if [ "$DRYRUN" = 1 ]; then log "DRY: удалил бы $1"; return 0; fi
		unlock "$1"
		if rm -f "$1"; then log "удалён $1"; else warn "НЕ удалён $1"; return 1; fi
	fi
	return 0
}
deldir() { [ -d "$1" ] || return 0; if [ "$DRYRUN" = 1 ]; then log "DRY: снял бы каталог $1"; else rmdir "$1" 2>/dev/null && log "снят каталог $1"; fi; }
unlock() { [ -n "$BB" ] && "$BB" chattr -ia "$1" 2>/dev/null; chattr -ia "$1" 2>/dev/null; return 0; }

do_restore() {
	if [ "$DRYRUN" = 1 ]; then log "DRY: восстановил бы $1 из $2"; return 0; fi
	unlock "$1"; unlock "$2"
	[ -h "$1" ] && rm -f "$1"
	if cp -f "$2" "$1" && [ -s "$1" ]; then
		chmod 0755 "$1"; chown 0:0 "$1" 2>/dev/null
		rm -f "$2"; log "восстановлен $1 из $2"; return 0
	fi
	warn "СБОЙ восстановления $1 из $2 — бэкап СОХРАНЁН, ничего не удаляю"; NEEDSTOCK=1; return 2
}
restore() {
	t="$1"; shift
	for b in "$@"; do if is_good_backup "$b"; then do_restore "$t" "$b"; return $?; fi; done
	is_elf "$t" && return 1
	if is_hijacker "$t"; then
		if [ -n "$BB" ]; then
			bt="${t##*/}"
			for p in $("$BB" grep -oE '/system/[A-Za-z0-9_./-]+' "$t" 2>/dev/null); do
				[ "$p" = "$t" ] && continue
				bp="${p##*/}"; case "$bp" in "$bt"*) ;; *) continue ;; esac
				if is_good_backup "$p"; then log "оригинал $t найден в тексте перехватчика: $p"; do_restore "$t" "$p"; return $?; fi
			done
		fi
		warn "ПОДМЕНА без годного бэкапа: $t — нужна базовая перепрошивка ГУ"; NEEDSTOCK=1; return 2
	fi
	return 1
}

echo "--- 1. Восстановление подменённых бинарников ---"
restore /system/bin/ddexe        /system/bin/ddexe_real /system/bin/ddexe-ku.bak
restore /system/bin/debuggerd    /system/bin/debuggerd_real /system/bin/debuggerd-ku.bak
restore /system/bin/debuggerd64  /system/bin/debuggerd64_real
restore /system/bin/app_process  /system/bin/app_process_real /system/bin/app_process32_original /system/bin/app_process_original

if [ "$NEEDSTOCK" != 0 ]; then
	echo "[x] Подменён системный бинарник, годного оригинала нет — этим скриптом не чинится."
	echo "    Нужна БАЗОВАЯ перепрошивка ГУ (архив «H… to stock» вернёт только файлы Community)."
	echo "    Ничего не удаляю, чтобы не ухудшить состояние."
	echo "===== aborted: needs stock $(date) ====="
	sync; exit 2
fi

echo "--- 2. Файлы KingRoot ---"
for f in \
	/system/xbin/su /system/xbin/ku.sud /system/xbin/kugote /system/xbin/krdem \
	/system/xbin/supolicy /system/xbin/daemonsu \
	/system/bin/su /system/bin/rt.sh /system/bin/.usb_config \
	/system/usr/iku/isu \
	/system/xbin/start_kusud.sh /system/xbin/.ku /system/xbin/.su \
	/system/app/Kinguser.apk /system/app/KingUser.apk /system/app/kinguser.apk \
	/system/app/Kinguser.odex /system/app/KingUser.odex \
	/system/etc/kds /system/etc/install_recovery.sh
do del "$f"; done
deldir /system/usr/iku

echo "--- 3. Файлы SuperSU ---"
del /system/bin/install-recovery.sh
for f in \
	/system/xbin/su /system/xbin/daemonsu /system/xbin/sugote /system/xbin/sugote-mksh /system/xbin/supolicy \
	/system/bin/.ext/.su \
	/system/app/Superuser.apk /system/app/SuperSU.apk \
	/system/etc/install-recovery.sh /system/etc/install-recovery-2.sh \
	/system/etc/init.d/99SuperSUDaemon \
	/system/etc/.installed_su_daemon /system/etc/.has_su_daemon \
	/system/lib/libsupol.so
do del "$f"; done
deldir /system/bin/.ext
deldir /system/etc/init.d

echo "--- 3b. RootMaster / Root Genius / Kingo / Baidu / 360 ---"
for f in \
	/system/bin/shuamesu /system/xbin/shuamesu /system/bin/bdsu /system/xbin/bdsu \
	/system/xbin/mu /system/bin/mu /system/bin/ksu /system/xbin/ksu /system/app/Kinguser_kingo.apk
do del "$f"; done

echo "--- 4. Общие остатки ---"
del /system/xbin/.su
del /system/bin/.su

echo "--- 5. Приложения и данные root ---"
for p in com.kingroot.kinguser com.kingroot.RushRoot com.kingouser.com com.kingo.root com.kingroot.master com.king.root \
	com.zhiqupk.root.global com.shuame.rootgenius com.rd.user2root com.mtk.user2root com.baidu.easyroot com.qihoo.permmgr \
	eu.chainfire.supersu com.noshufou.android.su; do
	if [ "$DRYRUN" = 1 ]; then log "DRY: удалил бы пакет $p"; else
		pm uninstall "$p" 2>&1
		rm -rf "/data/data/$p" 2>/dev/null
		rm -rf "/data/app-lib/$p" 2>/dev/null
	fi
done
if [ "$DRYRUN" = 0 ]; then
	rm -rf /data/data-lib/com.kingroot.kinguser 2>/dev/null
	rm -rf /data/data-lib/king 2>/dev/null
fi

echo "--- 6. Проверка остатков ---"
left=0
for f in \
	/system/xbin/su /system/bin/su /system/xbin/ku.sud /system/xbin/kugote /system/xbin/krdem \
	/system/xbin/supolicy /system/xbin/daemonsu /system/xbin/sugote \
	/system/app/Superuser.apk /system/app/Kinguser.apk \
	/system/bin/.ext/.su /system/bin/rt.sh \
	/system/etc/install-recovery.sh /system/etc/install-recovery-2.sh \
	/system/usr/iku/isu /system/etc/kds \
	/system/bin/shuamesu /system/xbin/bdsu /system/xbin/mu
do
	if [ -e "$f" ] || [ -h "$f" ]; then echo "[!] ОСТАЛСЯ: $f"; left=$((left+1)); fi
done
echo "осталось root-файлов: $left ; предупреждений: $fails ; режим: $( [ "$DRYRUN" = 1 ] && echo DRY-RUN || echo БОЕВОЙ )"

sync
if [ "$DRYRUN" = 1 ]; then
	echo "[i] DRY-RUN завершён. Проверь лог; для реальной чистки добавь файл 'doit' на флешку."
	echo "===== unroot end (dry-run) $(date) ====="
	exit 0
fi
if [ "$left" = 0 ] && [ "$fails" = 0 ]; then
	echo "[OK] root-файлы удалены"
	RC=0
else
	echo "[!] есть остатки или ошибки — см. лог выше"
	RC=1
fi
echo "===== unroot end $(date) ====="
if [ "$DOREBOOT" = 1 ] && [ "$RC" = 0 ]; then log "reboot по маркеру"; sync; sleep 3; reboot; fi
exit $RC
