# GiveMeSpeed

Automated speed test and pestering of your ISP via Twitter.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'give_me_speed'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install give_me_speed

## Usage

First `require` it, then configure it, and then call `#pester!`:

```ruby
require 'give_me_speed'

GiveMeSpeed.config = {
	thresholds: { download: 100, upload: 100 }, # The download and upload speeds you're paying for in bits per second. This is required
	isp: :xfinity, # Your ISP
	twitter_keys: { # The keys to interact with the Twitter API. Defaults to environment vars below
		api_key: ENV['TWITTER_API_KEY'],
        api_secret: ENV['TWITTER_API_SECRET'],
        access_token: ENV['TWITTER_ACCESS_TOKEN'],
        access_secret: ENV['TWITTER_ACCESS_SECRET']
	}
}

GiveMeSpeed.pester!
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cincospenguinos/give_me_speed. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/cincospenguinos/give_me_speed/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GiveMeSpeed project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/cincospenguinos/give_me_speed/blob/main/CODE_OF_CONDUCT.md).
