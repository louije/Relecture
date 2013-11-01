# README

Relecture is a Ruby on Rails 4.0 app. It requires Ruby 2.0 or 1.9.3.
It does not require a database (for now).

## Install

To try locally, and if Ruby is installed on your system, check out the repository and enter the following terminal commands
(do note that the use of a Ruby version manager such as RVM or rbenv will make things simple in the long run):

	gem install bundle
	bundle install
	rails server

Then load [localhost:3000](http://localhost:3000).

## Extend and contribute

### Reading services

Relecture supports Instapaper and Pinboard through the use of the respective gems.
Services should be put in the `/app/models` folder. Their class name should end with `Service`.
The `/app/models/concerns/service.rb` should be included and the relevant methods should be patched.
For now, the services list is manually managed in `app_controller.rb`.

Instapaper requires an api key/secret that can either be entered in `/config/initializers/instapaper.rb`
(see sample file in the same folder) or as an environment variables `INSTAPAPER_CS` and `INSTAPAPER_CS`.
(This is handy for Heroku deployment).

## TODO

- Tests
- Query the services on a background process, and load them from the client side	(single process server-side processing takes a very long time).
- Additional services
- New queries, in addition to _random link_ and _x years ago_.