# frozen_string_literal: true

module Milvus
  class Query < Base
    PATH = "query".freeze

    def post(
      collection_name:,
      output_fields:,
      expr:
    )
      response = client.connection.post(PATH) do |req|
        req.body = {
          collection_name: collection_name,
          expr: expr
        }
        if output_fields
          req.body[:output_fields] = output_fields
        end
      end
      response.body.empty? ? true : response.body
    end
  end
end
