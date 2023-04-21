# frozen_string_literal: true

module Milvus
  class Search < Base
    PATH = "search".freeze

    def post(
      collection_name:,
      output_fields: nil,
      anns_field:,
      top_k:,
      params:,
      metric_type:,
      round_decimal: nil,
      vectors:,
      dsl_type:
    )
      response = client.connection.post(PATH) do |req|
        req.body = {
          collection_name: collection_name,
          search_params: [
            { key: "anns_field", value: anns_field },
            { key: "topk", value: top_k },
            { key: "params", value: params },
            { key: "metric_type", value: metric_type },
          ],
          dsl_type: dsl_type,
          vectors: vectors
        }
        if round_decimal
          req.body[:search_params].push(
            { key: "round_decimal", value: round_decimal }
          )
        end
        if output_fields
          req.body[:output_fields] = output_fields
        end
      end
      response.body.empty? ? true : response.body
    end
  end
end
