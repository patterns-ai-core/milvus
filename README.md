# Milvus

<p>
    <img alt='Milvus logo' src='https://milvus.io/images/milvus_logo.svg' height='50' />
    &nbsp;&nbsp;
    <img alt='Ruby logo' src='https://user-images.githubusercontent.com/541665/230231593-43861278-4550-421d-a543-fd3553aac4f6.png' height='40' />
</p>

Ruby wrapper for the Milvus vector search database API.

Part of the [Langchain.rb](https://github.com/andreibondarev/langchainrb) stack.

Available for paid consulting engagements! [Email me](mailto:andrei@sourcelabs.io).

![Tests status](https://github.com/andreibondarev/milvus/actions/workflows/ci.yml/badge.svg)
[![Gem Version](https://badge.fury.io/rb/milvus.svg)](https://badge.fury.io/rb/milvus)
[![Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://rubydoc.info/gems/milvus)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/andreibondarev/milvus/blob/main/LICENSE.txt)
[![](https://dcbadge.vercel.app/api/server/WDARp7J2n8?compact=true&style=flat)](https://discord.gg/WDARp7J2n8)
[![X](https://img.shields.io/twitter/url/https/twitter.com/cloudposse.svg?style=social&label=Follow%20%40rushing_andrei)](https://twitter.com/rushing_andrei)

## API Docs
https://docs.zilliz.com/reference/restful/data-plane-v2

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
    url: 'http://localhost:19530'
)
```

### Using the Collections endpoints
```ruby
# Check if the collection exists.
client.collections.has(collection_name: "book")
```

```ruby
# Rename a collection.
client.collections.rename(collection_name: "book", new_collection_name: "note")
```

```ruby
# Get collection stats
client.collections.get_stats(collection_name: "book")
```

```ruby
# Data types: https://github.com/patterns-ai-core/milvus/blob/main/lib/milvus/constants.rb

# Creating a new collection schema
client.collections.create(
  collection_name: "book",
  description: "Test book search",
  auto_id: false,
  fields: [
    {
      "fieldName": "book_id",
      "description": "book id",
      "isPrimary": true,
      "autoID": false,
      "dataType": "Int64"
    },
    {
      "fieldName": "word_count",
      "description": "count of words",
      "isPrimary": false,
      "dataType": "Int64"
    },
    {
      "fieldName": "book_intro",
      "description": "embedded vector of book introduction",
      "dataType": "FloatVector",
      "isPrimary": false,
      "elementTypeParams": {
        "dim": "2"
      }
    }
  ]
)
```
```ruby
# Descrbie the collection
client.collections.describe(collection_name: "book")
```
```ruby
# Drop the collection
client.collections.drop(collection_name: "book")
```
```ruby
# Load the collection to memory before a search or a query
client.collections.load(collection_name: "book")
```
```ruby
# List all collections in the specified database.
client.collections.list
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
```
```ruby
# Check compaction status
client.entities.compact_status(
  compaction_id: 440928616022809499
)
# => {"status"=>{}, "state"=>2}
```

### Indexes
```ruby
# Create an index
index_params = {
  fieldName: "example_field",
  indexType: "IVF_FLAT",
  metricType: "L2",
  params: { nlist: 100 }
}

client.indexes.create(
  collection_name: "example_collection",
  index_params: index_params
)
```
```ruby
# Describe an index
client.indexes.describe(
  collection_name: "example_collection",
  index_name: "example_index"
)
```
```ruby
# List indexes
client.indexes.list(
  collection_name: "example_collection"
)
```
```ruby
# Drop an index
client.indexes.drop(
  collection_name: "example_collection",
  index_name: "example_index"
)
```

### Search, Querying & Hybrid Search
```ruby
client.entities.search(
  collection_name: "recipes",
  anns_field: "vectors",
  data: [embedding],
  filter: "id in [450847466900987454]"
)
```
```ruby
client.entities.query(
  collection_name: "recipes",
  filter: "id in [450847466900987455, 450847466900987454]"
)
```
```ruby
client.entities.hybrid_search(
  collection_name: "recipes",
  search: [{
    filter: "id in [450847466900987455]",
    data: [embedding],
    annsField: "vectors",
    limit: 10,
    outputFields: ["content", "id"]
  }],
  rerank: {
    "strategy": "rrf",
    "params": {
      "k": 10
    }
  },
  limit: 10,
  output_fields: ["content", "id"]
)
```

### Partitions
```ruby
# List partitions
client.partitions.list(
  collection_name: "example_collection"
)
```
```ruby
# Create a partition
client.partitions.create(
  collection_name: "example_collection",
  partition_name: "example_partition"
)
```
```ruby
# Check if a partition exists
client.partitions.has(
  collection_name: "example_collection",
  partition_name: "example_partition"
)
```
```ruby
# Load partition data into memory
client.partitions.load(
  collection_name: "example_collection",
  partition_names: ["example_partition"]
)
```
```ruby
# Release partition data from memory
client.partitions.release(
  collection_name: "example_collection",
  partition_names: ["example_partition"]
)
```
```ruby
# Get statistics of a partition
client.partitions.get_stats(
  collection_name: "example_collection",
  partition_name: "example_partition"
)
```
```ruby
# Drop a partition
client.partitions.drop(
  collection_name: "example_collection",
  partition_name: "example_partition"
)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/patterns-ai-core/milvus.

## License

`milvus` is licensed under the Apache License, Version 2.0. View a copy of the License file.

