# Dockerfile to reproduce the Heroku bundler version issue
# WITH binstub: bundler 2.6.9 (Gem.bin_path fails without gemspec)

FROM ruby:3.4
WORKDIR /app

# Build-time environment
ENV GEM_HOME=/app/vendor/bundle/ruby/3.4.0 \
    GEM_PATH=/app/vendor/bundle/ruby/3.4.0 \
    BUNDLE_PATH=vendor/bundle \
    BUNDLE_BIN=vendor/bundle/bin \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_WITHOUT=development:test

COPY Gemfile Gemfile.lock ./
COPY bin ./bin/

RUN mkdir -p vendor/bundle/ruby/3.4.0/{gems,specifications,bin} vendor/bundle/bin

# Install bundler then remove gemspec (simulates S3 download without gemspec)
RUN gem install bundler -v 4.0.3 --no-document \
    && rm $GEM_HOME/specifications/bundler-4.0.3.gemspec

RUN bundle lock --add-platform aarch64-linux x86_64-linux
RUN bundle install

# Runtime environment (NO GEM_HOME - like Heroku)
ENV GEM_HOME="" \
    GEM_PATH=/app/vendor/bundle/ruby/3.4.0: \
    PATH=/app/bin:/app/vendor/bundle/bin:/app/vendor/bundle/ruby/3.4.0/bin:/usr/local/bin:/usr/bin:/bin

CMD ["bundle", "-v"]
