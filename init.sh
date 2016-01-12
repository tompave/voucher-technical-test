#!/bin/bash

Path=$(dirname $0)

cd $Path

user_rvm_script="$HOME/.rvm/scripts/rvm"
global_rvm_script="/usr/local/rvm/scripts/rvm"

if [ -f $user_rvm_script ]; then
    source $user_rvm_script
elif [ -f $global_rvm_script ]; then
    source $global_rvm_script
else
    echo "Please install RVM"
    exit 1
fi

rvm use ruby-2.0.0-p648

bundle install --gemfile $Path/Gemfile --path $Path/vendor/bundle
