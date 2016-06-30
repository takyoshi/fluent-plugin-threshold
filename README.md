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

config_params (all required):

name                             | values
-------------------------------- | ------------------------------------------
operator                         | ge, gt, le, lt, string, regexp.
threshold                        | string, integer, and float value.
target_key                       | json property name.
{add|remove}_tag_{prefix|suffix} | string

configuration example:
```xml
<match th>
  type threshold
  operator ge
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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/takyoshi/fluent-plugin-threshold. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
