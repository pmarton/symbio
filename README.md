symbio | eat better together
============================

symbio is a simple collaborative food ordering system written in Ruby on Rails and [licensed under the AGPL](LICENSE.md).

Installation (incomplete)
-------------------------

* Set up [Ruby on Rails](http://rubyonrails.org/download)
* `git clone` this repository
* Run `bundle install`
* Copy `.env_example` to `.env` and change (at least) the DB settings
* For now, please also copy `config/database.example.yml` to `config/database.yml` and edit it as necessary (this workaround should not be necessary anymore in Rails 4.0, for details see https://github.com/rails/rails/pull/9120)
* Edit `db/seeds.rb` and change the e-mail addresses (`admin@sym.bio` and `user@sym.bio`) for the first admin and regular user to different, valid e-mail addresses of yours
* Create a free account at [SendGrid](http://sendgrid.com/) and add your credentials to `.env`. If you prefer to use another SMTP server, edit `config/initializers/mail.rb` accordingly.
* Run `foreman run rake db:setup`
* Start the dev server with `foreman start`
* Log in with your specified e-mail addresses and the password `symbio`.

For productive deployment, I recommend [Heroku](http://www.heroku.com/).
