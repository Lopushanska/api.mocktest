FROM ruby:2.6.1
RUN apt-get update && apt-get install -y --allow-unauthenticated sudo
WORKDIR /opt/project/blackbox-test
COPY Gemfile /opt/project/blackbox-test
RUN bundle install

CMD cucumber features/api/