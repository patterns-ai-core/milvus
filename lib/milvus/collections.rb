# frozen_string_literal: true

module Milvus
  class Collections < Base
    PATH = "collections"

    # This operation checks whether a collection exists.
    def exists?(collection_name:)
      response = client.connection.post("#{PATH}/has") do |req|
        req.body = {
          collectionName: collection_name
        }.to_json
      end
      response.body
    end

    # This operation renames an existing collection and optionally moves the collection to a new database.
    def rename(collection_name:, new_collection_name:)
      response = client.connection.post("#{PATH}/rename") do |req|
        req.body = {
          collectionName: collection_name,
          newCollectionName: new_collection_name
        }.to_json
      end
      response.body.empty? ? true : response.body
    end

    # This operation gets the number of entities in a collection.
    def get_stats(collection_name:)
      response = client.connection.post("#{PATH}/get_stats") do |req|
        req.body = {
          collectionName: collection_name
        }.to_json
      end
      response.body
    end

    # Create a Collection
    def create(
      collection_name:,
      auto_id:,
      description:,
      fields:
    )
      response = client.connection.post("#{PATH}/create") do |req|
        req.body = {
          collectionName: collection_name,
          schema: {
            autoId: auto_id,
            description: description,
            fields: fields,
            name: collection_name # This duplicated field is kept for historical reasons.
          }
        }.to_json
      end
      response.body.empty? ? true : response.body
    end

    # Describes the details of a collection.
    def describe(collection_name:)
      response = client.connection.post("#{PATH}/describe") do |req|
        req.body = {
          collectionName: collection_name
        }.to_json
      end
      response.body
    end

    # This operation lists all collections in the specified database.
    def list
      response = client.connection.post("#{PATH}/list") do |req|
        req.body = {}
      end
      response.body
    end

    # This operation drops the current collection and all data within the collection.
    def drop(collection_name:)
      response = client.connection.post("#{PATH}/drop") do |req|
        req.body = {
          collectionName: collection_name
        }.to_json
      end
      response.body.empty? ? true : response.body
    end

    # Load the collection to memory before a search or a query
    def load(collection_name:)
      response = client.connection.post("#{PATH}/load") do |req|
        req.body = {
          collectionName: collection_name
        }
      end
      response.body.empty? ? true : response.body
    end

    # This operation returns the load status of a specific collection.
    def get_load_state(collection_name:)
      response = client.connection.post("#{PATH}/get_load_state") do |req|
        req.body = {
          collectionName: collection_name
        }
      end
      response.body
    end

    # Release a collection from memory after a search or a query to reduce memory usage
    def release(collection_name:)
      response = client.connection.post("#{PATH}/release") do |req|
        req.body = {
          collectionName: collection_name
        }.to_json
      end
      response.body.empty? ? true : response.body
    end
  end
end
