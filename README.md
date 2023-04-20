# Milvus

<p>
    <img alt='Milvus logo' src='https://res.cloudinary.com/crunchbase-production/image/upload/c_lpad,f_auto,q_auto:eco,dpr_1/cqpyxcuzl6gwqjjwzamt' height='50' />
    +&nbsp;&nbsp;
    <img alt='Ruby logo' src='https://user-images.githubusercontent.com/541665/230231593-43861278-4550-421d-a543-fd3553aac4f6.png' height='40' />
</p>

Ruby wrapper for the Milvus vector search database API

![Tests status](https://github.com/andreibondarev/milvus/actions/workflows/ci.yml/badge.svg) [![Gem Version](https://badge.fury.io/rb/milvus.svg)](https://badge.fury.io/rb/milvus)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add milvus

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install milvus

## Usage

### Instantiating API client

```ruby
require 'milvus'

client = Milvus::Client.new(
    url: 'http://localhost:9091'
)
```

### Using the Collections endpoints

```ruby
# Creating a new collection schema
client.collections.create(
  collection_name: "recipes",
  description: "Collection of recipes",
  auto_id: true,
  fields: [
    {
      name: "recipe_id",
      data_type: 5,
      description: "Primary key",
      is_primary_key: true
    }
  ]
)
```
```ruby
# Get the collection info
client.collections.get(collection_name: 'recipes')
```

### Health
```ruby
# Live determines whether the application is alive. It can be used for Kubernetes liveness probe.
client.health
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/andreibondarev/milvus.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
