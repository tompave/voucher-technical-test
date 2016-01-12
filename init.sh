#!/bin/bash

Path=$(dirname $0)

cd $Path

source /usr/local/rvm/scripts/rvm
rvm use ruby-2.0.0-p648

bundle install --gemfile $Path/Gemfile --path $Path/vendor/bundle
