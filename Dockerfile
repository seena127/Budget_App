FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app
RUN bundle exec rake assets:precompile
EXPOSE 3000
#entrypoint is mainly used here to make sure the command is initialized when container starts
ENTRYPOINT ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
