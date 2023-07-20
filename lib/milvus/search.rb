# frozen_string_literal: true

module Milvus
  class Search < Base
    PATH = "search"

    def post(
      collection_name:,
      anns_field:, top_k:, params:, metric_type:, vectors:, vector_type:, dsl_type:, output_fields: nil,
      round_decimal: nil, partition_names: nil, filter: nil)
      response = client.connection.post(PATH) do |req|
        body = {
          collection_name: collection_name,
          search_params: [
            {key: "anns_field", value: anns_field},
            {key: "topk", value: top_k},
            {key: "params", value: params},
            {key: "metric_type", value: metric_type}
          ],
          vectors: vectors,
          vector_type: vector_type,
          dsl_type: dsl_type,
        }
        body[:expr] = filter if filter
        body[:partition_names] = partition_names if partition_names

        if round_decimal
          body[:search_params].push(
            {key: "round_decimal", value: round_decimal}
          )
        end
        if output_fields
          body[:output_fields] = output_fields
        end
        req.body = body.to_json
      end
      response.body.empty? ? true : response.body
    end
  end
end
