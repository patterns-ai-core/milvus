# frozen_string_literal: true

module Milvus
  class Collections < Base
    PATH = "collections"

    # This operation checks whether a collection exists.
    #
    # @param collection_name [String] The name of the collection to check.
    # @return [Hash] Server response
    def has(collection_name:)
      response = client.connection.post("#{PATH}/has") do |req|
        req.body = {
          collectionName: collection_name
        }
      end
      response.body
    end

    # This operation renames an existing collection and optionally moves the collection to a new database.
    #
    # @param collection_name [String] The name of the collection to rename.
    # @param new_collection_name [String] The new name of the collection.
    # @return [Hash] Server response
    def rename(collection_name:, new_collection_name:)
      response = client.connection.post("#{PATH}/rename") do |req|
        req.body = {
          collectionName: collection_name,
          newCollectionName: new_collection_name
        }
      end
      response.body.empty? ? true : response.body
    end

    # This operation gets the number of entities in a collection.
    #
    # @param collection_name [String] The name of the collection to get the count of.
    # @return [Hash] Server response
    def get_stats(collection_name:)
      response = client.connection.post("#{PATH}/get_stats") do |req|
        req.body = {
          collectionName: collection_name
        }
      end
      response.body
    end

    # Create a Collection
    #
    # @param collection_name [String] The name of the collection to create.
    # @param auto_id [Boolean] Whether to automatically generate IDs for the collection.
    # @param description [String] A description of the collection.
    # @param fields [Array<Hash>] The fields of the collection.
    # @return [Hash] Server response
    def create(
      collection_name:,
      auto_id:,
      fields:
    )
      response = client.connection.post("#{PATH}/create") do |req|
        req.body = {
          collectionName: collection_name,
          schema: {
            autoId: auto_id,
            fields: fields,
            name: collection_name # This duplicated field is kept for historical reasons.
          }
        }
      end
      response.body.empty? ? true : response.body
    end

    # Describes the details of a collection.
    #
    # @param collection_name [String] The name of the collection to describe.
    # @return [Hash] Server response
    def describe(collection_name:)
      response = client.connection.post("#{PATH}/describe") do |req|
        req.body = {
          collectionName: collection_name
        }
      end
      response.body
    end

    # This operation lists all collections in the specified database.
    #
    # @return [Hash] Server response
    def list
      response = client.connection.post("#{PATH}/list") do |req|
        req.body = {}
      end
      response.body
    end

    # This operation drops the current collection and all data within the collection.
    #
    # @param collection_name [String] The name of the collection to drop.
    # @return [Hash] Server response
    def drop(collection_name:)
      response = client.connection.post("#{PATH}/drop") do |req|
        req.body = {
          collectionName: collection_name
        }
      end
      response.body.empty? ? true : response.body
    end

    # Load the collection to memory before a search or a query
    #
    # @param collection_name [String] The name of the collection to load.
    # @return [Hash] Server response
    def load(collection_name:)
      response = client.connection.post("#{PATH}/load") do |req|
        req.body = {
          collectionName: collection_name
        }
      end
      response.body.empty? ? true : response.body
    end

    # This operation returns the load status of a specific collection.
    #
    # @param collection_name [String] The name of the collection to get the load status of.
    # @return [Hash] Server response
    def get_load_state(collection_name:)
      response = client.connection.post("#{PATH}/get_load_state") do |req|
        req.body = {
          collectionName: collection_name
        }
      end
      response.body
    end

    # Release a collection from memory after a search or a query to reduce memory usage
    #
    # @param collection_name [String] The name of the collection to release.
    # @return [Hash] Server response
    def release(collection_name:)
      response = client.connection.post("#{PATH}/release") do |req|
        req.body = {
          collectionName: collection_name
        }
      end
      response.body.empty? ? true : response.body
    end
  end
end
