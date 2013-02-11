symbio | eat better together
============================

symbio is a simple collaborative food ordering system written in Ruby on Rails and [licensed under the AGPL](LICENSE.md).

Installation (incomplete)
-------------------------

* Set up [Ruby on Rails](http://rubyonrails.org/download)
* `git clone` this repository
* Run `bundle install`
* Copy `.env_example` to `.env` and change (at least) the DB settings
* Run `foreman run rake db:migrate` (which is currently broken, see https://github.com/rails/rails/pull/9120)
* Run the dev setup with `foreman start`

For productive deployment, I recommend [Heroku](http://www.heroku.com/).
