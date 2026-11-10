"""Проверка собранного сайта (_site): ссылки и якоря, JSON-LD, FAQ-ответы, sitemap.

Запуск после `bundle exec jekyll build`:  python _scripts/check_site.py
Код выхода 1, если найдены проблемы.
"""
import glob
import json
import os
import re
import sys
import urllib.parse as U
import xml.etree.ElementTree as ET

sys.stdout.reconfigure(encoding='utf-8', errors='replace')
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SITE = os.path.join(ROOT, '_site')
BASE = 'https://qttc.github.io'
problems = []


def bad(kind, url, detail=''):
    problems.append(f'{kind:<10} {url} {detail}'.rstrip())


def load_pages():
    pages = {}
    for f in glob.glob(os.path.join(SITE, '**', '*.html'), recursive=True):
        url = '/' + os.path.relpath(f, SITE).replace(os.sep, '/')
        url = url[:-10] if url.endswith('index.html') else url
        pages[url] = open(f, encoding='utf-8').read()
    return pages


def check_links(pages):
    for url, html in pages.items():
        for href in re.findall(r'href="([^"]+)"', html):
            if href.startswith(('http', 'mailto', '//')) or href.endswith(('.css', '.png', '.ico', '.xml')):
                continue
            path, _, frag = href.partition('#')
            path, frag = U.unquote(path) or url, U.unquote(frag)
            if path.startswith('/assets/'):
                if not os.path.exists(SITE + path):
                    bad('MISSING', url, href)
                continue
            if path not in pages:
                bad('NO PAGE', url, href)
            elif frag and f'id="{frag}"' not in pages[path]:
                bad('NO ANCHOR', url, href)


def check_jsonld(pages):
    """JSON-LD должен парситься; у FAQ — непустые чистые ответы без хвостов страницы."""
    faq_count = 0
    for url, html in pages.items():
        for blk in re.findall(r'<script type="application/ld\+json">(.*?)</script>', html, re.S):
            try:
                data = json.loads(blk)
            except ValueError as e:
                bad('BAD JSON', url, str(e))
                continue
            if data.get('@type') != 'FAQPage':
                continue
            qs = data.get('mainEntity', [])
            if not qs:
                bad('FAQ EMPTY', url)
            for q in qs:
                name = q.get('name', '')
                ans = q.get('acceptedAnswer', {}).get('text', '')
                faq_count += 1
                if not name or not ans:
                    bad('FAQ ITEM', url, name)
                # пробел перед знаком препинания — след HTML-тегов; «Вернуться» — захвачен подвал
                if re.search(r' [.,;:)!?](\s|$)', ans) or 'Вернуться на главную' in ans:
                    bad('FAQ TEXT', url, f'{name} → …{ans[-60:]}')
    return faq_count


def check_faq_flags(pages):
    """Страница с `faq: true` должна дать FAQPage хотя бы с одним вопросом."""
    for md in glob.glob(os.path.join(ROOT, 'pages', '*.md')) + [os.path.join(ROOT, 'index.md')]:
        text = open(md, encoding='utf-8').read()
        fm = text.split('---', 2)[1] if text.startswith('---') else ''
        if not re.search(r'^faq:\s*true', fm, re.M):
            continue
        m = re.search(r'^permalink:\s*(\S+)', fm, re.M)
        html = pages.get(m.group(1) if m else '', '')
        if '"@type":"FAQPage"' not in html or '"@type":"Question"' not in html:
            bad('FAQ FLAG', os.path.relpath(md, ROOT), 'faq: true, но вопросов нет')


def check_sitemap(pages):
    """Каждая страница (кроме 404) в sitemap и с <lastmod>."""
    ns = {'s': 'http://www.sitemaps.org/schemas/sitemap/0.9'}
    tree = ET.parse(os.path.join(SITE, 'sitemap.xml'))
    seen = {}
    for u in tree.getroot().findall('s:url', ns):
        loc = u.find('s:loc', ns).text
        seen[U.unquote(loc[len(BASE):])] = u.find('s:lastmod', ns) is not None
    for url in pages:
        if url.startswith('/404'):
            continue
        if url not in seen:
            bad('NO SITEMAP', url)
        elif not seen[url]:
            bad('NO LASTMOD', url, 'добавьте last_modified_at во front matter')
    return len(seen)


pages = load_pages()
check_links(pages)
faqs = check_jsonld(pages)
check_faq_flags(pages)
urls = check_sitemap(pages)
for p in problems:
    print(p)
print(f'страниц {len(pages)}, вопросов FAQ {faqs}, URL в sitemap {urls}, проблем {len(problems)}')
sys.exit(1 if problems else 0)
