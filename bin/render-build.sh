#!/usr/bin/env bash
# exit on error
set -o errexit

### Configurations Tailwind
npm install esbuild

### Configurations Rails
bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate

### Configurations Tailwind
bin/rails tailwindcss:build

### Install Fonts MiniMagick
sleep 5
mkdir /opt/render/.fonts
cp ~/project/src/.render/fonts/* /opt/render/.fonts
fc-cache -f -v