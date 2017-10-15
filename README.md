# Responsibility [![Build Status](https://travis-ci.org/erickbrower/responsibility.svg?branch=master)](https://travis-ci.org/erickbrower/responsibility)

A Responsibility is a class that provides a single piece of functionality,
as per the [Single Responsibility Principle](https://en.wikipedia.org/wiki/Single_responsibility_principle). This class
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

Define a class, `include Responsibility`, and define a `perform` method.
If `before` is defined and returns `false` or calls `fail!` then the `perform` or `after` methods will not be run. The same rule applies to `perform`, and in the case of failure `after` will not be called.

Any keyword arguments (or just a hash) passed to `perform` will become attributes of the resulting object

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
result.success? #=> true
result.errors #=> []
result.user #=> Our newly persisted user

```

If errors are created during `before`, `perform`, or `after` then the service fails. In the example above, if the user isn't valid we add an error. In this case the result object would look like:

```ruby
user = User.new(
  email: "",
  password: ""
)
result = UserSignupService.perform(user: user)
result.success? #=> false
result.errors #=> ["User was not provided or is not valid"]
```

Another contrived example with an explicit failure, assuming the User object couldn't be persisted:
```ruby
class UserSignupService
  include Responsibility

  def before
    unless user.present? && user.valid?
      errors << "User was not provided or is not valid"
    end
  end

  def perform
    unless user.save
      fail!(message: "User could not be saved")
    end
  end

  def after
    UserConfirmationEmailService.perform(email: user.email)
  end
end

result = UserSignupService.perform(user: user)
result.success?  #=> false
result.errors #=> ["User could not be saved"]

```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/erickbrower/responsibility.
