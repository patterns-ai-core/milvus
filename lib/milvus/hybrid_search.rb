# frozen_string_literal: true

module Milvus
  class HybridSearch < Base
    PATH = "entities/hybrid_search"

    # Executes a hybrid search.
    #
    # @param collection_name [String] The name of the collection to search.
    # @param data [Array<Hash>] The data to search for.
    # @param rerank [Hash] The rerank parameters.
    # @param limit [Integer] The maximum number of results to return.
    # @param output_fields [Array<String>] The fields to return in the results.
    #
    # @return [Hash] The search results.
    def post(
      collection_name:,
      search:,
      rerank:,
      limit: nil,
      output_fields: []
    )
      response = client.connection.post(PATH) do |req|
        params = {
          collectionName: collection_name,
          search: search,
          rerank: rerank
        }
        params[:limit] = limit if limit
        params[:outputFields] = output_fields if output_fields.any?
        req.body = params
      end
      response.body.empty? ? true : response.body
    end
  end
end