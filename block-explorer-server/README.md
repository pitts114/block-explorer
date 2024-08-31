# Block Explorer Server

A Ruby on Rails app that interacts with a Bitcoin Core node and serves a RESTful API and server-side rendered UI.

## Setup

```bash
cp .env.example .env

cat .ruby-version | rvm use
bundle install

docker compose up

bundle exec rails db:create
bundle exec rails db:migrate

bundle exec rails s
```

After starting the server, visit http://localhost:3000/blocks.

### Install Bitcoin Core

See https://github.com/bitcoin/bitcoin/tree/master/doc.

## Bitcoin Core

Helpful commands:

```bash
# example: get blockchain info
bin/bitcoin-cli getblockchaininfo

# mine a block
bin/bitcoin-cli -generate 1;
```
