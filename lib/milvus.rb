# frozen_string_literal: true

require_relative "milvus/version"
require_relative "milvus/constants"

module Milvus
  autoload :Base, "milvus/base"
  autoload :Collections, "milvus/collections"
  autoload :Client, "milvus/client"
  autoload :Error, "milvus/error"
  autoload :Entities, "milvus/entities"
  autoload :Indexes, "milvus/indexes"
  autoload :Partitions, "milvus/partitions"
  autoload :Search, "milvus/search"
  autoload :Query, "milvus/query"
end
