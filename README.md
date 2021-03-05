# AthVega

<!-- Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/ath_vega`. To experiment with that code, run `bin/console` for an interactive prompt. -->

This command line interface (CLI) application allows a user to create a workout by selecting exercises from  wger (pronounced 'vega') Workout Manager software.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ath_vega'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ath_vega

## Usage

This is a command line interface that uses the open source workout app, 'wger' (pronounced vega) to create workouts with three exercises. To use, firstly follow the directions above to install the gem. 

To run the app:

    $ bin/ath_vega

You are then presented with a series of options for muscle groups (i.e. legs, back, etc.) to choose from. When you select a muscle, you will be presented with a list of exercises for that muscle group. Selecting an exercise adds it to the workout. Once you have selected three exercises, the terminal will output a table of your exercises.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/<github username>/ath_vega.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
