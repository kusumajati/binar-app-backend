#!/usr/bin/env bash

bundle exec rake db:migrate

if [[ $? != 0 ]]; then
  echo
  echo "== Failed to migrate. Running setup first."
  echo
  bundle exec rake db:create && \
  bundle exec rake db:migrate
fi

bundle exec rails s -b 0.0.0.0
