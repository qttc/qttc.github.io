# qttc.github.io — Coolray X50 Wiki

Вики для владельцев Geely Coolray / Belgee X50: прошивки Community и откат,
приложения для головного устройства, CarPlay/Carlinkit, ТО, масла и жидкости,
коды краски и решения частых проблем.

🔗 https://qttc.github.io/

## Разделы
- [Сообщество и прошивки](https://qttc.github.io/pages/community/)
- [Приложения для ГУ](https://qttc.github.io/pages/apps/)
- [CarPlay / Carlinkit](https://qttc.github.io/pages/carlinkit/)
  - [CarPlay без донгла (coorlay)](https://qttc.github.io/pages/carplay-no-dongle/)
- [Техничка](https://qttc.github.io/pages/parts/) — каталоги и PDF
  - [ТО и расходники](https://qttc.github.io/pages/to/)
  - [Масло и жидкости](https://qttc.github.io/pages/oil/)
  - [Коды краски](https://qttc.github.io/pages/paint-codes/)
- [Проблемы и решения](https://qttc.github.io/pages/problems/)
  - [Значки на приборной панели](https://qttc.github.io/pages/warning-lights/)

## Стек
Сайт собран на Jekyll и хостится на GitHub Pages. SEO-теги генерирует
`jekyll-seo-tag`, карта сайта — `jekyll-sitemap`, хлебные крошки и FAQ-разметка —
`_includes/breadcrumbs.html` и `_includes/faq-jsonld.html`.

У страницы-подраздела в front matter задаются `parent` (URL раздела) и `crumb`
(короткое имя для хлебных крошек). `faq: true` включает FAQ-разметку из
подзаголовков `###` со знаком «?».

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

## Правила контента
- Ссылки на APK — только на посты в Telegram-чате, без загрузки файлов в репозиторий.
- С фото убирать специфичную информацию: госномера, VIN, серийники, адреса, ФИО.
- Не больше одного эмодзи в строке; эмодзи не ставить в заголовки (ломают якоря).
