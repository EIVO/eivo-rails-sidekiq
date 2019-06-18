# EIVO Rails Sidekiq

[![Gem Version](https://badge.fury.io/rb/eivo-rails-sidekiq.svg)](http://badge.fury.io/rb/eivo-rails-sidekiq)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'eivo-rails-sidekiq'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eivo-sidekiq -N

## Usage

	$ rails g eivo:sidekiq:install

You must use a dedicated Redis instance for sidekiq, more informations [here](http://www.mikeperham.com/2015/09/24/storing-data-with-redis/).

## License

This project is released under the MIT license. See the LICENSE file for more info.
