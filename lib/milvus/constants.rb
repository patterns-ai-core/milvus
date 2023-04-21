# frozen_string_literal: true

module Milvus
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
    "binary_vector" => 101,
    "float_vector" => 102
  }.freeze
end
