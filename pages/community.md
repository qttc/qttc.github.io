---
title: Community FAQ
layout: page
permalink: /community
---

# На данной странице собраны ответы на самые популярные вопросы по прошивке Community

#### Оглавление

## О Communty
- [Что такое Community?](#что-такое-community)
- [Что обновится после установки Community Full?](#что-обновится-после-установки-community-full)
- [Облегченные версии Community](#облегченные-версии-community)
- [Можно ли что-то убрать из Community?](#можно-ли-что-то-убрать-из-community)
- [Где найти дополнительные улучшения для Community?](#где-найти-дополнительные-улучшения-для-community)
- [Установится ли Communty на Belgee X50?](#установится-ли-communty-на-belgee-x50)

## Как скачать Community
- [Где скачать последнюю версию Community?](#где-скачать-последнюю-версию-community)
- [Как пользоваться ботом?](#как-пользоваться-ботом)

## Установка Community
- [Пошаговая инструкция по установке](#пошаговая-инструкция-по-установке)
- [Как узнать версию ПО в машине?](#как-узнать-версию-по-в-машине)
- [Как установить Community?](#как-установить-community)
- [Какая флешка нужна для установки Community?](#какая-флешка-нужна-для-установки-community)
- [В какой порт вставлять флешку?](#в-какой-порт-вставлять-флешку)
- [Как правильно разархивировать файлы на флешку?](#как-правильно-разархивировать-файлы-на-флешку)
- [Как обновить Community до последней версии?](#как-обновить-community-до-последней-версии)
- [Следовал инструкции на 4pda, что-то пошло не так](#следовал-инструкции-на-4pda-что-то-пошло-не-так)

## Установка доп. приложений
- [Как установить доп. приложения вместе с установкой Community?](#как-установить-доп-приложения-вместе-с-установкой-community)
- [Как установить доп. приложения после установки Community?](#как-установить-доп-приложения-после-установки-community)

## Откат и гарантии
- [Лишает ли установка Community гарантии?](#лишает-ли-установка-community-гарантии)
- [Как откатить изменения и вернуть заводские настройки](#как-откатить-изменения-и-вернуть-заводские-настройки)



___

## Что такое Community?
Community - это пакет модифицированных системных компонентов и дополнительных приложений который расширяет возможности ГУ. Пакет собран энтузиастами и не является полноценной прошивкой (в отличии от GMC). 

_[К оглавлению](#оглавление)_

## Что обновится после установки Community Full?
В Новый пакете установки Community полностью переработан скрипт-конструктор установки. Теперь легко кастомизировать пакет под свои нужды без необходимости изменения самого скрипта (Лайт версии для AA и CP примеры такой кастомизации). Все правки необходимо вносить в _[done.sh]_

Здесь и далее описание пунктов в формате:
> Изменение - [измененный компонент]

+ **Подменяются модифицированные системные приложения из папки SysApps**:
  + Русифицируется приложение инженерного меню. _[KC2_EngineerMode.apk]_
  + В верхний статус бар добавляется отображение даты, времени и иконки статуса подключения Wi-Fi. _[KC2_statusbar.apk]_
  + В нижний навигационный бар добавляются
    + дополнительные кнопки включения обогревов
    + кнопка Назад
    + кнопка Навигации (вызывает Яндекс Навигатор, если он установлен на ГУ)
    + кнопки настроек Geely и Android'а
    + кнопка контекстного меню. 
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
+ **В настройках Android активируется меню разработчика и разрешается установка сторонних приложений.**
+ **Принудительно отключается отладка по USB. Китайский часовой пояс (GMT+8) меняется на Московский (GMT+3).**
+ **Обновляется база часовых поясов Android до версии 2021a (Москва теперь GMT+3 без смены зима/лето).** _[tzdata]_
+ **Звук вызова заменяется на классический рингтон айфона.** _[ANDROMEDA.ogg]_
+ **Добавляется анимация загрузки Community.** _[bootanimation.mp4]_

Пакет может использоваться как обновление ранее установленного Community. При этом дополнительные приложения, ранее установленные как системные, будут перенесены в пользовательские. Ведётся полный лог своей работы (на флешке будет создан файл ГГГГММДД-ЧЧММ.log).

_[К оглавлению](#оглавление)_


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

_[К оглавлению](#оглавление)_

## Установится ли Communty на Belgee X50?
Установка возможна только на дорестайлинговые версии со старым ГУ (Android 4.3)

_[К оглавлению](#оглавление)_

## Можно ли что-то убрать из Community?
Да! Если вы не хотите устанавливать все компоненты, которые идут при установке, то вы можете просто удалить их с флешки.
Название каждого компонента прописано в описании пункта в квадратных скобках. Для примера:
> Добавляется анимация загрузки Community. [bootanimation.mp4]

То есть, если вам не нужна измененная анимация загрузки, то перед прошивкой просто удалите с флешки файл bootanimation.mp4

_[К оглавлению](#оглавление)_

## Где найти дополнительные улучшения для Community?
В боте [@Coolray_Community_helper_bot](#https://t.me/Coolray_Community_helper_bot) следуйте пунктам:

> У меня уже прошито Community → Дополнительные пакеты 

и выбирайте из представленных пакетов дополнительные настройки. 

_[К оглавлению](#оглавление)_

___

## Как установить Community?
Для скачивания файлов и проверки, возможна ли установка Community на ваш автомобиль, вам необходимо воспользоваться ботом в телеграме - [@Coolray_Community_helper_bot](#https://t.me/Coolray_Community_helper_bot)

Далее, следуйте инструкциям бота, выбирайте и нажимайте необходимые кнопки.

Пакет Community один для всех версий. Особенности есть ТОЛЬКО для ревизии H30 младше 84-ой версии. Подробнее описано в боте.

_[К оглавлению](#оглавление)_

## Пошаговая инструкция по установке

1. **Узнать версию ПО в машине.**
Подробнее - [Как узнать версию ПО в машине?](#как-узнать-версию-по-в-машине)
2. **Открыть бот** [@Coolray_Community_helper_bot](#https://t.me/Coolray_Community_helper_bot)
3. **Выбрать "У меня сток" — выбрать вашу версию ГУ.**
Подробнее - [Как пользоваться ботом?](#как-пользоваться-ботом)
4. **Скачать архив на комп.**
5. **Подготовить флешку.**
Подробнее - [Какая флешка нужна для установки Community?](#какая-флешка-нужна-для-установки-community)
6. **Разархивировать архив и скопировать на флешку.**
Подробнее - [Как правильно разархивировать файлы на флешку?](#как-правильно-разархивировать-файлы-на-флешку)
7. **Достать флешку и пойти к машине.**
8. **Воткнуть флешку в USB порт машины.**
Подробнее - [В какой порт вставлять флешку?](#в-какой-порт-вставлять-флешку)
9. **Дождаться установки - установка длится ± 5-7 минут.** 
ГУ перезагрузится после установки автоматически!

Готово. Вы восхитительны!

_[К оглавлению](#оглавление)_

## Как узнать версию ПО в машине?
В машине на ГУ нажать на ⚙️ — вкладка "система" — О системе — Версия ПО. 

Нас интересуют символы после буквы H - H50.00032
![Версия ПО](https://telegra.ph/file/30e6799c5e6cdaa01436c.png "Версия ПО")

_[К оглавлению](#оглавление)_

## Где скачать последнюю версию Community?
Только в боте находится актуальная версия Community → [@Coolray_Community_helper_bot](#https://t.me/Coolray_Community_helper_bot)

_[К оглавлению](#оглавление)_


## Как пользоваться ботом?
В боте нужно нажимать на кнопки. 

![Бот](https://telegra.ph/file/bdeb9e4263124faf45d46.png "Функции бота")

Если у вас не отображаются кнопки, нажмите на иконку 
![Активация кнопок в боте](https://telegra.ph/file/a05c6a2ce96156452dc82.png)

_[К оглавлению](#оглавление)_

## Какая флешка нужна для установки Community?
Любая флешка объемом от 2 до 8 GB с файловой системой FAT32 и разметкой MBR.

Рекомендуюется использовать более старые флешки, т.к. вероятнее всего у них будет файловая система и разметка такая как требуется.

_[К оглавлению](#оглавление)_

## В какой порт вставлять флешку?
В любой порт - не важно левый или правый.

_[К оглавлению](#оглавление)_


## Как правильно разархивировать файлы на флешку?
1. После того как скачали архив Community, разархивируйте все файлы из архива в отдельную папку.
2. Затем скопируйте все файлы из этой папки в корень флешки.
![Структура файлов](https://telegra.ph/file/299ded5a261ec6e0663f8.jpg)

_[К оглавлению](#оглавление)_

## Как установить доп. приложения вместе с установкой Community?
Вы  можете дополнить пакет нужными для вас приложениями, скачайте их и скопируйте их в папку **UserApps** перед установкой Community.

_[К оглавлению](#оглавление)_

## Как установить доп. приложения после установки Community?
Функциональность установки приложений аналогично установке приожений как на телефоне/планшете на Android.

1. Скопируйте нужные .apk файлы на флешку.
2. Вставьте флешку в любой usb порт.
3. Откройте "ES Проводник" на ГУ
4. В левом меню выберите флешку
5. Нажмите на нужное приложение и установите его.

_[К оглавлению](#оглавление)_

## Как обновить Community до последней версии?
Скачайте последний пакет Community из бота. 

Пакет может использоваться как обновление ранее установленного Community. При этом дополнительные приложения, ранее установленные как системные, будут перенесены в пользовательские.

_[К оглавлению](#оглавление)_

## Следовал инструкции на 4pda, что-то пошло не так
Тема на 4PDA устарела и больше не обновляется. Пожалуйста, используйте актуальную информацию из бота.

_[К оглавлению](#оглавление)_

## Лишает ли установка Community гарантии?
Краткий ответ - да.

При обращении в дилерский центр с проблемами, связанными с ГУ (камеры и т.д), необходимо откатить версию Community до заводской. 

Во всех остальных случаях, дилеры с высокой вероятностью проигнорируют установленное Community и ничего с гарантией не будет.

_[К оглавлению](#оглавление)_

## Как откатить изменения и вернуть заводские настройки?
1. Вспомнить/посмотреть какая версия прошивки ГУ установлена.
2. Аналогично как при установке, перейти в бот, выбрать "У меня уже прошито Community" → "Откатиться в сток".
3. Выбрать и скачать архив соответсвуйющий вашей версии прошивке. 
4. Например, если у вас H50.00009, то скачать пакет "H50.00009 to stock.zip"
5. Разархивировать на флешку и воткнуть флешку в любой usb-порт.
6. Подождать 5-7 минут и дождаться отката.

![Откат](https://telegra.ph/file/b56e713f45f14f9795c5d.jpg)

**Обратите внимание!**

Для полного отката **НУЖЕН ТОЛЬКО** архив "H... to stock.zip".

**НЕ НУЖНО** скачивать и прошивать  пакеты "Инженерка в сток", "Настройки в сток для H50", "Удаление Autokit", "Удаление ES", "Удаление Viper".

Эти архивы нужны только для частичного отката!

_[К оглавлению](#оглавление)_