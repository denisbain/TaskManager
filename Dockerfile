FROM ruby:3.3.0-alpine

ARG RAILS_ROOT=/task_manager
ARG PACKAGES="vim openssl-dev postgresql-dev build-base curl nodejs yarn less tzdata git postgresql-client bash screen gcompat"

RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache $PACKAGES

RUN gem install bundler:2.5.14

RUN mkdir $RAILS_ROOT
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile.lock  ./
RUN bundle install --jobs 5

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile


COPY . .

ENV PATH=$RAILS_ROOT/bin:${PATH}

EXPOSE 3000
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0", "-p", "3000"]