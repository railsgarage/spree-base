# Spree-Base

## Description
Spree-Base is a preconfigured environment for developing a Spree application.

## Requirements
 * [Install Vagrant](https://www.vagrantup.com/downloads.html)
 * [Install Docker](https://docs.docker.com/installation/)
 * Install Ansible - `brew install ansible`
 * Add `export DOCKER_HOST=tcp://localhost:5555` to your `~/.bash_profile` and relaunch your terminal
 * If using fish, add `set -x DOCKER_HOST "tcp://localhost:5555"` to your '~/.config/fish/config.fish' and relaunch terminal

## Installation
 * Clone repository
 * `cd` into project folder
 * `vagrant up`
 * `fig up -d postgres`
 * `fig run --rm util bundle exec rake db:create`
 * `fig run --rm util bundle exec rake db:migrate`
 * `fig up app`

## Development
 * To start the app, run `vagrant up` then `fig up app`

---

 * Creating Gemfile.lock - `docker run --rm -v /app:/usr/src/app -w /usr/src/app ruby:2.1.5 bundle install`
