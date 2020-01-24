FROM ruby:2.5.5-alpine3.10
LABEL maintainer="ohendriansyah@binar.co.id"
ENV PORT="8080" \
    HOME="/opt/app-root" \
    RAILS_ENV="production" \
    RACK_ENV="production"
RUN set -xe \
 && apk add --no-cache postgresql-client nodejs tini tzdata libc6-compat \
 && mkdir -p ${HOME}
WORKDIR ${HOME}
RUN set -xe \
 && bundle config --global frozen 1
COPY Gemfile Gemfile.lock ./
RUN set -xe \
 && apk add --no-cache --virtual build-deps build-base postgresql-dev \
 && bundle install \
 && apk del build-deps
COPY . .
RUN set -xe \
 && rake assets:precompile \
 && chown -R 1001 . \
 && chgrp -R 0 . \
 && chmod -R g=u .
USER 1001 
EXPOSE ${PORT}
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
CMD ["rails", "db:migrate"]
