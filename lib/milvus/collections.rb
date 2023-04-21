# frozen_string_literal: true

module Milvus
  class Collections < Base
    PATH = "collection".freeze

    # Create a Collection
    def create(
      collection_name:,
      auto_id:,
      description:,
      fields:
    )
      response = client.connection.post(PATH) do |req|
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
      response.body.empty? ? true : response.body
    end

    # Retrieve a Collection
    def get(collection_name:)
      response = client.connection.get(PATH) do |req|
        req.body = {
          collection_name: collection_name
        }.to_json
      end
      response.body
    end

    # Drop a Collection
    def delete(collection_name:)
      response = client.connection.delete(PATH) do |req|
        req.body = {
          collection_name: collection_name
        }.to_json
      end
      response.body.empty? ? true : response.body
    end

    # Load the collection to memory before a search or a query
    def load(collection_name:)
      response = client.connection.post("#{PATH}/load") do |req|
        req.body = {
          collection_name: collection_name
        }.to_json
      end
      response.body.empty? ? true : response.body
    end

    # Release a collection from memory after a search or a query to reduce memory usage
    def release(collection_name:)
      response = client.connection.delete("#{PATH}/load") do |req|
        req.body = {
          collection_name: collection_name
        }.to_json
      end
      response.body.empty? ? true : response.body
    end
  end
end
