# frozen_string_literal: true

module Milvus
  class Search < Base
    PATH = "search".freeze

    def post(
      collection_name:,
      output_fileds:,
      search_params:
    )
      response = client.connection.post(PATH) do |req|
        req.body = {
          collection_name: collection_name,
          output_fileds: output_fileds,
          search_params: search_params
        }.to_json
      end
      response.body.empty? ? true : response.body
    end
  end
end
