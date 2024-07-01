# frozen_string_literal: true

module Milvus
  # https://milvus.io/api-reference/pymilvus/v2.4.x/MilvusClient/Collections/DataType.md
  DATA_TYPES = {
    "boolean" => 1,
    "int8" => 2,
    "int16" => 3,
    "int32" => 4,
    "int64" => 5,
    "float" => 10,
    "double" => 11,
    "string" => 20,
    "varchar" => 21,
    "array" => 22,
    "json" => 23,
    "binary_vector" => 100,
    "float_vector" => 101,
    "float16_vector" => 102,
    "bfloat16_vector" => 103,
    "sparse_float_vector" => 104
  }.freeze
end
