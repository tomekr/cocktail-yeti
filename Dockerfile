FROM ruby:alpine

RUN apk add --update build-base postgresql-dev tzdata nodejs

WORKDIR /app
ADD Gemfile* /app/
RUN bundle install
