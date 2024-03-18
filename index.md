---
title: Coolray FAQ
---

# Coolray FAQ

## Оглавление
- [Что такое Community?](#что-такое-community)
- [Что обновится после установки Community Full?](#что-обновится-после-установки-community-full)
- [Облегченные версии Community](#облегченные-версии-community)
- [Можно ли что-то убрать из Community?](#можно-ли-что-то-убрать-из-community)
- [Где найти дополнительные улучшения для Community?](#где-найти-дополнительные-улучшения-для-community)


## Что такое Community?
Community - это пакет модифицированных системных компонентов и дополнительных приложений который расширяет возможности ГУ. Пакет собран энтузиастами и не является полноценной прошивкой (в отличии от GMC). 

[К оглавлению](#оглавление)

## Что обновится после установки Community Full?
В Новый пакет установки Community:

+ **Полностью переработанный скрипт-конструктор установки позволяющий легко кастомизировать пакет под свои нужды без необходимости изменения самого скрипта (Лайт версии для AA и CP примеры такой кастомизации)** _[done.sh]_
+ **В настройках Android активируется меню разработчика и разрешается установка сторонних приложений.**
+ **Принудительно отключается отладка по USB. Китайский часовой пояс (GMT+8) меняется на Московский (GMT+3).**
+ **Обновляется база часовых поясов Android до версии 2021a (Москва теперь GMT+3 без смены зима/лето).** _[tzdata]_
+ **Звук вызова заменяется на классический рингтон айфона.** _[ANDROMEDA.ogg]_
+ **Добавляется анимация загрузки Community.** _[bootanimation.mp4]_
+ **Подменяются модифицированные системные приложения из папки SysApps**:
  + Русифицируется приложение инженерного режима. _[KC2_EngineerMode.apk]_
  + В верхний статус бар добавляется отображение даты, времени и иконки статуса подключения Wi-Fi. _[KC2_statusbar.apk]_
  + В нижний навигационный бар добавляются дополнительные кнопки включения обогревов, кнопка Назад, кнопка Навигации (вызывает Яндекс Навигатор, если он установлен на ГУ), кнопки настроек Geely и Android'а, кнопка контекстного меню. 
  + Отключается назойливое всплытие окна климата при использовании физических кнопок и ручек (при необходимости окно всегда можно открыть свайпом вверх от нижнего края дисплея). В само окно климата добавляются режимы автоподогревов. _[KC2_SystemUI.apk]_
  + Фиксированная стоковая выдвигающаяся слева панель быстрых переключателей заменяется на настраиваемую с кнопками вкл./выкл. BT, Wi-Fi и Hotspot. _[KC2_EcarxSettingWidget.apk, XCControlBoard.apk]_
  + Отключается автозапуск радио и сообщение о необходимости соблюдения ПДД и выбора режима подключения флешки. _[KC2_popview.apk]_
  + Устанавливается новый лаунчер Home с поддержкой виджетов, группировкой иконок в папки и возможностью удаления пользовательских приложений непосредственно с рабочего стола. _[XCLauncher3.apk]_ При установке нового лаунчера Home стоковый Launcher3 замораживается в системе.
  + Добавляется виджет навигации на рабочем столе ГУ и поддержка отображения стрелок навигации на приборной панели. _[KC2_IPKServer.apk, XCNaviService.apk, Community.apk]_
+ **Устанавливаются дополнительные пользовательские приложения из папки UserApps:**
  + Файловый менеджер ES-проводник _[ES.apk]_
  + Виджет очистки памяти _[XCAutoSecure.apk]_
  + Виджет c датой/временем и погодой _[CoolWidget_1.4.apk]_
  + Облегчённая оффлайн версия галереи QuickPic на замену стоковой, позволяющая просматривать изображения как на USB-носителях, так и на самом ГУ и легко менять обои ГУ. _[QuickPic_4.7.4_Geely.apk]_. При установке галереи QuickPic стоковая галерея замораживается в системе.
  + Устанавливается системный ViPER4Android FX v2.4.0.1 с набором профилей. Скрипт автоматически устанавливает и регистрирует драйвер Viper'а в системе. Таким образом Root-доступ для него более НЕ требуется. _[ViperFX]_
  + Устанавливаются голосовое управление и его конфигурация _[VoiceAssistant]_
  + Загружаются оптимизированные для ГУ Кулька настройки ряда пользовательских приложений. _[Data]_
  + Устанавливается подборка обоев для дисплея ГУ. _[Wallpapers]_

Пакет может использоваться как обновление ранее установленного Community. При этом дополнительные приложения, ранее установленные как системные, будут перенесены в пользовательские. Ведётся полный лог своей работы (на флешке будет создан файл ГГГГММДД-ЧЧММ.log).

[К оглавлению](#оглавление)


## Облегченные версии Community
Пакеты Community Lite для Android Auto и Apple CarPlay - это максимально облегчённые версии Community, ориентированные на работу с телефоном на Android и iPhone соответственно.

**От полного пакета Community включают:**
+ системные настройки Android,
+ обновление часовых поясов [tzdata],
+ рингтон айфона [ANDROMEDA.ogg],
+ модифицированный верхний статус бар [KC2_statusbar.apk],
+ модифицированный нижний навигационный бар, отключение автовсплытие окна климата с автооогревами [KC2_SystemUI.apk]
+ отключение автозапуска радио и сообщение о соблюдении ПДД [KC2_popview.apk].
+ cтрелка в навигационном баре зависимости от пакета вызывает приложения Headunit Reloaded (HUR) или AutoKit.

**Пакет для Android Auto включает:**
+ файловый менеджер ES Проводник [ES.apk]
+ эмулятор Android Auto для ГУ Headunit Reloaded [HUR_7.0.4.apk]
+ приложение для переназначени кнопок [KetRemap_1.24.1.apk]

**Пакет для CarPlay включает:**
+ файловый менеджер ES Проводник [ES.apk]
+ приложение для работы с донглом Carlinkit CCPx [AutoKit_2023.12.06.1516.apk

[К оглавлению](#оглавление)

## Можно ли что-то убрать из Community?
Да! Если вы не хотите устанавливать все компоненты, которые идут при установке, то вы можете просто удалить их с флешки.
Название каждого компонента прописано в описании пункта в квадратных скобках. Для примера:
> Добавляется анимация загрузки Community. [bootanimation.mp4]

То есть, если вам не нужна измененная анимация загрузки, то перед прошивкой просто удалите с флешки файл bootanimation.mp4

[К оглавлению](#оглавление)

## Где найти дополнительные улучшения для Community?
В боте [@Coolray_Community_helper_bot](#https://t.me/Coolray_Community_helper_bot) следуйте пунктам:

> У меня уже прошито Community → Дополнительные пакеты и выбирайте из представленных пакетов дополнительные настройки. 

[К оглавлению](#оглавление)