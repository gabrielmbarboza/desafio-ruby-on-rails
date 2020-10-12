FROM ruby:2.7.1

ENV RAILS_ENV development

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle install --jobs 3