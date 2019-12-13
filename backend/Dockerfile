FROM ruby:2.5

ENV APP /usr/src/app
RUN mkdir $APP
WORKDIR $APP

COPY Gemfile* $APP/
RUN bundle install -j3 --path vendor/bundle

COPY . $APP/

CMD ["bin/rails", "server", "-b", "0.0.0.0"]