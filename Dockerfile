FROM ruby:2.7.1

ENV RAILS_ENV development

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle install --jobs 3

ARG version=0.93.0

RUN gem install rubocop -v ${version}

COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]