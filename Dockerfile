# Dockerfile to reproduce the Heroku bundler version issue
# WITH binstub: bundler 2.6.9 (Gem.bin_path fails without gemspec)

FROM ruby:3.4
WORKDIR /app

ENV GEM_HOME=/app/vendor/bundle/ruby/3.4.0 \
    GEM_PATH=/app/vendor/bundle/ruby/3.4.0 \
    BUNDLE_PATH=vendor/bundle \
    BUNDLE_BIN=vendor/bundle/bin \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_WITHOUT=development:test \
    PATH=/app/bin:/app/vendor/bundle/bin:/app/vendor/bundle/ruby/3.4.0/bin:/usr/local/bin:/usr/bin:/bin:$PATH

COPY Gemfile Gemfile.lock ./
COPY bin ./bin/

RUN gem install bundler -v 4.0.3 --no-document

RUN bundle install
RUN bundle clean

CMD ["bundle", "-v"]
