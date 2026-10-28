source "https://rubygems.org"

# Версии как в GitHub Pages (pages.github.com/versions). Сам гем github-pages
# не ставится на Ruby 4 (тянет commonmarker < Ruby 4), поэтому перечислены напрямую.
gem "jekyll", "~> 3.10.0"
gem "kramdown", "~> 2.4"
gem "kramdown-parser-gfm", "~> 1.1"
gem "liquid", "~> 4.0.4"

group :jekyll_plugins do
  gem "jekyll-seo-tag", "2.8.0"
  gem "jekyll-sitemap", "1.4.0"
end

# Убраны из стандартной поставки Ruby 3.4+, нужны для jekyll serve
gem "webrick"
gem "csv"
gem "base64"
gem "bigdecimal"
gem "logger"

platforms :windows do
  gem "tzinfo-data"
end
