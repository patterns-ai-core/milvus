# frozen_string_literal: true

module Milvus
  class Collections < Base
    PATH = "collection"

    def create(
      collection_name:,
      auto_id:,
      description:,
      fields:
    )
      response = client.connection.post(PATH.to_s) do |req|
        req.body = {
          collection_name: collection_name,
          schema: {
            auto_id: auto_id,
            description: description,
            fields: fields,
            name: collection_name # This duplicated field is kept for historical reasons.
          }
        }.to_json
      end
      response.success?
    end

    def exists?(collection_name:)
      response = client.connection.get(PATH.to_s) do |req|
        req.body = {
          collection_name: collection_name
        }.to_json
      end
      response.body
    end
  end
end
