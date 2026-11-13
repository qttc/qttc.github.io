# qttc.github.io — Coolray X50 Wiki

Вики для владельцев Geely Coolray / Belgee X50: прошивки Community и откат,
приложения для головного устройства, CarPlay/Carlinkit, ТО, масла и жидкости,
предохранители, аккумулятор, шины и диски, ключ, коробка 7DCT, гарантия, версии машины, коды краски и решения частых проблем.

🔗 https://qttc.github.io/

## Разделы
- [Версии машины](https://qttc.github.io/pages/versions/)
- [Сообщество и прошивки](https://qttc.github.io/pages/community/)
  - [Вернуть заводскую прошивку](https://qttc.github.io/pages/rollback/)
- [Приложения для ГУ](https://qttc.github.io/pages/apps/)
  - [Стрелки навигации на приборке](https://qttc.github.io/pages/cluster-navigation/)
  - [Беспроводной Android Auto (OH Coolray, 5 ГГц)](https://qttc.github.io/pages/wireless-android-auto/)
- [CarPlay / Carlinkit](https://qttc.github.io/pages/carlinkit/)
  - [CarPlay без донгла (coorlay)](https://qttc.github.io/pages/carplay-no-dongle/)
- [Техничка](https://qttc.github.io/pages/parts/) — каталоги и PDF
  - [ТО и расходники](https://qttc.github.io/pages/to/)
    - [Гарантия](https://qttc.github.io/pages/warranty/)
  - [Масло и жидкости](https://qttc.github.io/pages/oil/)
  - [Коды краски](https://qttc.github.io/pages/paint-codes/)
  - [Предохранители](https://qttc.github.io/pages/fuses/)
  - [Аккумулятор](https://qttc.github.io/pages/battery/)
  - [Шины и диски](https://qttc.github.io/pages/tires/)
  - [Ключ](https://qttc.github.io/pages/key/)
  - [Коробка 7DCT](https://qttc.github.io/pages/dct/)
- [Проблемы и решения](https://qttc.github.io/pages/problems/)
  - [Значки на приборной панели](https://qttc.github.io/pages/warning-lights/)

## Стек
Сайт собран на Jekyll и хостится на GitHub Pages. SEO-теги генерирует
`jekyll-seo-tag`, карта сайта — `jekyll-sitemap`, хлебные крошки и FAQ-разметка —
`_includes/breadcrumbs.html` и `_includes/faq-jsonld.html`.

У страницы-подраздела в front matter задаются `parent` (URL раздела) и `crumb`
(короткое имя для хлебных крошек). `faq: true` включает FAQ-разметку из
подзаголовков `###` со знаком «?»; ответ — текст до «К оглавлению», `------` или следующего `##`.

`last_modified_at: ГГГГ-ММ-ДД` даёт `<lastmod>` в `sitemap.xml` и `dateModified` в разметке —
обновлять при каждой содержательной правке страницы.

## Локальная сборка
Нужен Ruby (на Windows — MSYS2 UCRT64: `pacman -S mingw-w64-ucrt-x86_64-ruby`).
Версии Jekyll и плагинов в `Gemfile` совпадают с GitHub Pages; гем `github-pages`
не используется, т.к. не ставится на Ruby 4.

```bash
bundle config set --local path vendor/bundle
bundle install
bundle exec jekyll serve
```

Сайт откроется на http://localhost:4000. Гемы ставятся в `vendor/` внутри проекта.

Перед пушем — сборка и проверка: ссылки и якоря, валидность JSON-LD, чистота ответов FAQ,
`<lastmod>` в sitemap. Код выхода 1 — есть проблемы.

```bash
bundle exec jekyll build
python _scripts/check_site.py
```

## Правила контента
- Ссылки на APK — только на посты в Telegram-чате, без загрузки файлов в репозиторий.
  Исключения, лежат и на сайте: `assets/files/coolray_5ghz_fix_v1.1.zip` (беспроводной Android Auto)
  и `assets/files/rollback/*.zip` (частичный откат: ES, ViperFX, AutoKit, IPKServer);
  при новой версии в чате — заменить файл и ссылки.
- С фото убирать специфичную информацию: госномера, VIN, серийники, адреса, ФИО.
- Не больше одного эмодзи в строке; эмодзи не ставить в заголовки (ломают якоря).
- Факты — из руководства по эксплуатации и Service Manual (`assets/pdf/`), сверка по 2+ источникам;
  данные из чата помечать «по опыту владельцев», неподтверждённое не публиковать.
  Рекомендаций «что купить» (бренды АКБ, шин и т.п.) не давать — только характеристики.
- Чужие фото (чат, Drive2) — с подписью и ссылкой на источник.
- `<title>` страниц выводится без приписки сайта (`_includes/head-custom.html`, `{% seo title=false %}`).
