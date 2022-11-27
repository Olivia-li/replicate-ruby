# Replicate Ruby client

This is a Ruby client for Replicate. It lets you run models with your Ruby code. 

Grab your token from replicate.com/account to use this library. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'replicate-api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install replicate-api

## Usage

You can run a model and get its output:

```
replicate = Replicate::Client.new(api_key: "#{YOUR API KEY HERE}")
model = replicate.models("stability-ai/stable-diffusion")
model.predict(prompt="a 19th century portrait of a wombat gentleman")
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/olivia-li/replicate-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
