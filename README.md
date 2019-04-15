# Cocktail Yeti [![CircleCI](https://circleci.com/gh/tomekr/cocktail-yeti/tree/master.svg?style=svg)](https://circleci.com/gh/tomekr/cocktail-yeti/tree/master) [![Maintainability](https://api.codeclimate.com/v1/badges/ab33ebc47cd4a6d5feaa/maintainability)](https://codeclimate.com/github/tomekr/cocktail-yeti/maintainability)

Cocktail Yeti is an open source Cocktail GraphQL API hosted on Rails.

## Development

To get started:

1. `bundle install`
2. To setup the database and populate it with data, run `rails db:setup`
3. `bundle exec rails server` and navigate to [http://localhost:3000](http://localhost:3000)

### Docker

1. Build the web container with `docker-compose build web`
2. To start the web container, run `docker-compose up -d web`
3. To drop into a shell on the web container, run `docker-compose exec web sh`
3. To run the test suite, run `bundle exec rake`
