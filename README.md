# Fluent::Plugin::Threshold
[![Build Status](https://travis-ci.org/takyoshi/fluent-plugin-threshold.svg?branch=master)](https://travis-ci.org/takyoshi/fluent-plugin-threshold)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fluent-plugin-threshold'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent-plugin-threshold

## Usage

configuration:
```xml
<match th>
  type threshold
  condition ge
  threshold 15
  target_key count
  add_tag_prefix th.
</match>
```


input JSON:
```json
{"user_id": "123", "count": 11, "uri": "/*"}
{"user_id": "125", "count": 13, "uri": "/*"}
{"user_id": "127", "count": 14, "uri": "/*"}
{"user_id": "126", "count": 15, "uri": "/*"}
{"user_id": "124", "count": 16, "uri": "/*"}
{"user_id": "128", "count": 17, "uri": "/*"}
```

output JSON:
```json
{"user_id": "126", "count": 15, "uri": "/*"}
{"user_id": "124", "count": 16, "uri": "/*"}
{"user_id": "128", "count": 17, "uri": "/*"}
```

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/takyoshi/fluent-plugin-threshold. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
