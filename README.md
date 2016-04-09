<div align="left">
  <a href="https://github.com/juanroldan1989/my-budget-app"><img width="450" src="https://github.com/juanroldan1989/my-budget-app/raw/master/app/assets/images/auckland.jpg" alt="eventfinda ruby logo" /></a>
</div>

# Finding deals in Auckland

[![Code Climate](https://codeclimate.com/github/juanroldan1989/my-budget-app/badges/gpa.svg)](https://codeclimate.com/github/juanroldan1989/my-budget-app)
[![Build Status](https://travis-ci.org/juanroldan1989/my-budget-app.svg?branch=master)](https://travis-ci.org/juanroldan1989/my-budget-app)
[![Coverage Status](https://coveralls.io/repos/github/juanroldan1989/my-budget-app/badge.svg?branch=master)](https://coveralls.io/github/juanroldan1989/my-budget-app?branch=master)

Responsive web application built to look out single/combined deals in Auckland, importing deals/events from BookMe and EventFinda websites and filtering them by Price and Keywords ("tours", "hotels", "food", "drinks", "beaches" and "fun").

### 1. Development

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

Importing deals from http://www.eventfinda.co.nz requires for a developer account (free) first: http://www.eventfinda.co.nz/api/v2/index

Then run this task:

```
rake get:deals:websites
```

Import deals from http://bookme.co.nz:

```
rake get:deals:websites
```


Combine deals by price:
```
rake deals:set:combined
```

Validate test suite:

```
rspec spec
```

Launch app:
```
foreman start
```

### 2. Work in progress

* Display deal's locations within Deal page: https://jsfiddle.net/_tomorro/yhrmL5zz/

### 3. Q&A

Questions or problems? Please post them on the [issue tracker](https://github.com/juanroldan1989/my-budget-app/github/issues). You can contribute changes by forking the project and submitting a pull request. You can ensure the tests are passing by running `rspec spec`.


### 4. Live app

http://my-budget-in-auckland.herokuapp.com

