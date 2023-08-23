#!/usr/bin/env bash
# exit on error
set -o errexit

### Install Fonts MiniMagick
mkdir ~/.fonts
cp .render/fonts/* ~/.fonts
fc-cache -f -v

### Configurations Rails
bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate

### Configurations Tailwind
npm install esbuild
bin/rails tailwindcss:build