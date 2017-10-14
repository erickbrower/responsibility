# Responsibility [![Build Status](https://travis-ci.org/erickbrower/responsibility.svg?branch=master)](https://travis-ci.org/erickbrower/responsibility)

A Responsibility is a class that provides a single piece of functionality,
as per the Single Responsibility Principle
[https://en.wikipedia.org/wiki/Single_responsibility_principle]. This class
provides a single method called "perform", with optional "before" and
"after" hooks. It also keeps track of any errors set during execution.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'responsibility'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install responsibility

## Usage

A simple example could be something like:

```ruby
class UserSignupService
  include Responsibility

  def before
    unless user.present? && user.valid?
      errors << "User was not provided or is not valid"
    end
  end

  def perform
    user.save
  end

  def after
    UserConfirmationEmailService.perform(email: user.email)
  end
end

user = User.new(
  email: "cerickbrower@gmail.com",
  password: "Wubba Lubba Dub Dub!"
)
result = UserSignupService.perform(user: user)

```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/erickbrower/responsibility.
