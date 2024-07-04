# frozen_string_literal: true

module Milvus
  # https://milvus.io/api-reference/pymilvus/v2.4.x/MilvusClient/Collections/DataType.md
  DATA_TYPES = [
    "Boolean",
    "Int8",
    "Int16",
    "Int32",
    "Int64",
    "Float",
    "Double",
    "VarChar",
    "Array",
    "Json",
    "BinaryVector",
    "FloatVector",
    "Float16Vector",
    "BFloat16Vector",
    "SparseFloatVector"
  ].freeze
end
