# frozen_string_literal: true

module Milvus
  class Search < Base
    PATH = "search"

    def post(
      collection_name:,
      anns_field:, top_k:, params:, metric_type:, vectors:, dsl_type:, output_fields: nil,
      round_decimal: nil, partition_names: nil,vector: nil, filter: nil
    )
      response = client.connection.post(PATH) do |req|
        req.body = {
          collection_name: collection_name,
          search_params: [
            {key: "anns_field", value: anns_field},
            {key: "topk", value: top_k},
            {key: "params", value: params},
            {key: "metric_type", value: metric_type}
          ],
          dsl_type: dsl_type,
        }
        # support for single search vs batch search and also allows for partition scans
        req.body[:vectors] = vectors if vectors
        req.body[:vector] = vector if vector
        req.body[:filter] = filter if filter
        req.body[:partition_names] = partition_names if partition_names

        if round_decimal
          req.body[:search_params].push(
            {key: "round_decimal", value: round_decimal}
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
