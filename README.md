<div align="left">
  <a href="https://github.com/juanroldan1989/my-budget-app"><img width="450" src="https://github.com/juanroldan1989/my-budget-app/raw/master/app/assets/images/auckland.jpg" alt="my budget app logo" /></a>
</div>

# Finding deals in Auckland

[![Code Climate](https://codeclimate.com/github/juanroldan1989/my-budget-app/badges/gpa.svg)](https://codeclimate.com/github/juanroldan1989/my-budget-app)
[![Build Status](https://travis-ci.org/juanroldan1989/my-budget-app.svg?branch=master)](https://travis-ci.org/juanroldan1989/my-budget-app)
[![Coverage Status](https://coveralls.io/repos/github/juanroldan1989/my-budget-app/badge.svg?branch=master)](https://coveralls.io/github/juanroldan1989/my-budget-app?branch=master)

- Responsive web application built to look out single/combined deals in Auckland.
- Allows to importing deals/events from BookMe and EventFinda websites and
- To filter events by Price and Keywords ("tours", "hotels", "food", "drinks", "beaches" and "fun").
- Results returned from API cached within the application. Expiration time: 1 hour.

## 1. Development

Clone repository:
```
git clone git@github.com:juanroldan1989/my-budget-app.git
```

Install gems:
```
bundle install
```

Setup DB:
```
rake db:create db:migrate db:test:prepare
```

### 1.1 Import deals from [BookMe.co.nz](http://bookme.co.nz):
Scrapping events is the only way, there's no API available:

```
rake get:deals:from:book_me
```

### 1.2 Import deals from [EventFinda.co.nz](http://www.eventfinda.co.nz):
- Get a developer account (free) first: http://www.eventfinda.co.nz/api/v2/index

- Setup credentials into `config/application.yml` file:
```
cp config/application.sample.yml config/application.yml
```

Run import task (implemented with [event_finda_ruby](https://github.com/juanroldan1989/event_finda_ruby) gem):
```
rake get:deals:from:event_finda
```
### 1.3 Combine deals from both websites
```
rake deals:set:combined
```

### 1.4 Starting up
Validate test suite:
```
rspec spec
```

Launch app:
```
foreman start
```

### 1.5 Redis
With [Redis setup](https://redis.io/topics/quickstart), start looking for events. Stored keys can be checked like this:

```
$ redis-cli
127.0.0.1:6379> select "0"
OK
127.0.0.1:6379> keys **
 1) "/v1/deals/by_price/0/by_price_lower_than/2"
 2) "/v1/deals/by_price/0/keywords_search/82"
 3) "/v1/deals/by_price/0/by_price_lower_than/3/keywords_search/126"
 4) "/v1/deals/by_price/0/by_price_lower_than/2/keywords_search/209"
 5) "/v1/deals/by_price/0/keywords_search/75"
 6) "/v1/deals/by_price/0/by_price_lower_than/2/keywords_search/75"
 7) "/v1/deals/by_price/0/keywords_search/285"
 8) "/v1/deals/by_price/0/by_price_lower_than/3/keywords_search/82"
 9) "/v1/deals/by_price/0/by_price_lower_than/3/keywords_search/209"
10) "/v1/deals/by_price/0/by_price_lower_than/3"
11) "/v1/deals/by_price/0/by_price_lower_than/3/keywords_search/285"
12) "/v1/deals/by_price/0/keywords_search/158"
13) "/v1/deals/by_price/0/by_price_lower_than/2/keywords_search/285"
14) "/v1/deals/by_price/0/by_price_lower_than/2/keywords_search/82"
15) "/v1/deals/by_price/0/by_price_lower_than/2/keywords_search/158"
16) "/v1/deals/by_price/0/by_price_lower_than/2/keywords_search/126"
17) "/v1/deals/by_price/0"
```

Heroku's Redis addon displaying stored keys in live app:

<img width="450" src="https://github.com/juanroldan1989/my-budget-app/raw/master/app/assets/images/redis.png" alt="my budget app redis" /></a>

## 2. Work in progress

* Display deal's locations within Deal page: https://jsfiddle.net/_tomorro/yhrmL5zz/

## 3. Q&A

Questions or problems? Please post them on the [issue tracker](https://github.com/juanroldan1989/my-budget-app/issues). You can contribute changes by forking the project and submitting a pull request. You can ensure the tests are passing by running `rspec spec`.


## 4. Live app

http://my-budget-in-auckland.herokuapp.com

<img width="450" src="https://github.com/juanroldan1989/my-budget-app/raw/master/app/assets/images/screenshot.png" alt="my budget app logo" /></a>
