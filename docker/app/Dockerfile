FROM ruby:2.6.5

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && curl -sL https://deb.nodesource.com/setup_13.x | bash - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq && apt-get install -y --no-install-recommends \
      build-essential \
      nodejs \
      yarn \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /webapp

COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.1.4 \
  && bundle install --jobs=4

COPY . /webapp
RUN bin/rails yarn:install \
  && mkdir -p tmp/sockets \
  && mkdir -p tmp/pids

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
CMD bundle exec puma -C config/puma.rb
