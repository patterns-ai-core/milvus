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
# Data types: "boolean", "int8", "int16", "int32", "int64", "float", "double", "string", "varchar", "binary_vector", "float_vector"

# Creating a new collection schema
client.collections.create(
  collection_name: "book",
  description: "Test book search",
  auto_id: false,
  fields: [
    {
      "name": "book_id",
      "description": "book id",
      "is_primary_key": true,
      "autoID": false,
      "data_type": Milvus::DATA_TYPES["int64"]
    },
    {
      "name": "word_count",
      "description": "count of words",
      "is_primary_key": false,
      "data_type": Milvus::DATA_TYPES["int64"]
    },
    {
      "name": "book_intro",
      "description": "embedded vector of book introduction",
      "data_type": Milvus::DATA_TYPES["binary_vector"],
      "is_primary_key": false,
      "type_params": [
        {
          "key": "dim",
          "value": "2"
        }
      ]
    }
  ]
)
```
```ruby
# Get the collection info
client.collections.get(collection_name: "book")
```
```ruby
# Delete the collection
client.collections.delete(collection_name: "book")
```
```ruby
# Load the collection to memory before a search or a query
client.collections.load(collection_name: "book")
```
```ruby
# Release a collection from memory after a search or a query to reduce memory usage
client.collections.release(collection_name: "book")
```

### Inserting Data
```ruby
client.entities.insert(
  collection_name: "book",
  num_rows: 5, # Number of rows to be inserted. The number should be the same as the length of each field array.
  fields_data: [
    {
      "field_name": "book_id",
      "type": Milvus::DATA_TYPES["int64"],
      "field": [1,2,3,4,5]
    },
    {
      "field_name": "word_count",
      "type": Milvus::DATA_TYPES["int64"],
      "field": [1000,2000,3000,4000,5000]
    },
    {
      "field_name": "book_intro",
      "type": 101,
      "field": [ [1,1],[2,1],[3,1],[4,1],[5,1] ]
    }
  ]  
)
```
```ruby
# Delete the entities with the boolean expression you created
client.entities.delete(
  collection_name: "book",
  expression: "book_id in [0,1]"
)
```
```ruby
# Compact data manually
client.entities.compact!(
  collection_id: "book"
)
# => {"status"=>{}, "compactionID"=>440928616022809499}

# Check compaction status
client.entities.compact_status(
  compaction_id: 440928616022809499
)
# => {"status"=>{}, "state"=>2}
```

### Indices
```ruby
client.indices.create(
  collection_name: "book",
  field_name: "book_intro",
  extra_params: [
    { key: "metric_type", "value": "L2" },
    { key: "index_type", "value": "IVF_FLAT" },
    { key: "params", "value": "{\"nlist\":1024}" }
  ]
)
```
```ruby
collection.indices.create(
  field_name="book_name", 
  index_name="scalar_index",
)
```
```ruby
client.indices.delete(
  collection_name: "book",
  field_name: "book_intro"
)
```

### Search & Querying
```ruby
client.search(
  collection_name: "book",
  output_fields: ["book_id"], # optional
  anns_field: "book_intro",
  top_k: "2",
  params: "{\"nprobe\": 10}",
  metric_type: "L2",
  round_decimal: "-1",
  vectors: [ [0.1,0.2] ],
  dsl_type: 1
)
```
```ruby
client.query(
  collection_name: "book",
  output_fields: ["book_id", "book_intro"],
  expr: "book_id in [2,4,6,8]"
)
```

### Partitions
```ruby
client.partitions.create(
  "collection_name": "book",
  "partition_name": "novel"
)
```
```ruby
client.partitions.get(
  "collection_name": "book",
  "partition_name": "novel"
)
```
```ruby
client.partitions.delete(
  "collection_name": "book",
  "partition_name": "novel"
)
```
```ruby
client.partitions.load(
  "collection_name": "book",
  "partition_names": ["novel"],
  "replica_number": 1
)
```
```ruby
client.partitions.release(
  "collection_name": "book",
  "partition_names": ["novel"],
  "replica_number": 1
)
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

`milvus` is licensed under the Apache License, Version 2.0. View a copy of the License file.

