# frozen_string_literal: true

require_relative "milvus/version"
require_relative "milvus/constants"

module Milvus
  autoload :Base, "milvus/base"
  autoload :Collections, "milvus/collections"
  autoload :Client, "milvus/client"
  autoload :Error, "milvus/error"
  autoload :Entities, "milvus/entities"
  autoload :Health, "milvus/health"
  autoload :Indices, "milvus/indices"
  autoload :Partitions, "milvus/partitions"
end
