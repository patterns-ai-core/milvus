# frozen_string_literal: true

module Milvus
  class Indices < Base
    PATH = "index".freeze

    def create(
      collection_name:,
      field_name:,
      extra_params:
    )
      response = client.connection.post(PATH) do |req|
        req.body = {
          collection_name: collection_name,
          field_name: field_name,
          extra_params: extra_params
        }.to_json
      end
      response.body.empty? ? true : response.body
    end

    def delete(
      collection_name:,
      field_name:
    )
      response = client.connection.delete(PATH) do |req|
        req.body = {
          collection_name: collection_name,
          field_name: field_name
        }.to_json
      end
      response.body.empty? ? true : response.body
    end
  end
end
