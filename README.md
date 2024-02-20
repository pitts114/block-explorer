# Block Explorer

An incredibly basic Bitcoin block explorer.

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
```
