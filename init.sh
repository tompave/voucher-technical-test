#!/bin/bash

Path=$(dirname $0)

cd $Path

source /usr/local/rvm/scripts/rvm
rvm use ruby-2.0.0-p195

bundle install
