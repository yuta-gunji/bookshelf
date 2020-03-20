FROM ruby:2.6.5-alpine3.11

RUN set -x \
  && apk update \
  && apk upgrade \
  && apk add --no-cache \
    gcc \
    g++ \
    libc-dev \
    libxml2-dev \
    linux-headers \
    make \
    nodejs \
    postgresql \
    postgresql-dev \
    tzdata \
    yarn \
    imagemagick \
  && apk add --virtual build-packs --no-cache \
    build-base \
    curl-dev

WORKDIR /webapp

COPY Gemfile Gemfile.lock ./
RUN set -x \
  && gem install bundler:2.1.4 \
  && bundle install --jobs=4 \
  && apk del build-packs

COPY package.json yarn.lock babel.config.js postcss.config.js ./
RUN yarn install

ARG RAILS_ENV
ENV RAILS_ENV $RAILS_ENV

ARG RAILS_MASTER_KEY
ENV RAILS_MASTER_KEY $RAILS_MASTER_KEY

COPY . /webapp
RUN set -x \
  && mkdir -p tmp/sockets \
  && mkdir -p tmp/pids \
  && if [ "${RAILS_ENV}" = "production" ]; then bin/rails webpacker:clobber && bin/rails webpacker:compile; fi

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
