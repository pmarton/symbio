symbio | eat better together
============================

symbio is a simple collaborative food ordering system written in Ruby on Rails and [licensed under the AGPL](LICENSE.md).

Installation (incomplete)
-------------------------

* Set up [Ruby on Rails](http://rubyonrails.org/download)
* `git clone` this repository
* Run `bundle install`
* Copy `.env_example` to `.env` and change (at least) the DB settings
* ~~Run `foreman run rake db:migrate`~~ (this is currently broken and will be fixed in Rails 4.0, see https://github.com/rails/rails/pull/9120)
* Workaround: For now, please edit config/database.yml and then run `rake db:migrate`
* Run the dev setup with `foreman start`

For productive deployment, I recommend [Heroku](http://www.heroku.com/).
