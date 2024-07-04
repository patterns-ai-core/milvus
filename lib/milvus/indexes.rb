# frozen_string_literal: true

module Milvus
  class Indexes < Base
    PATH = "indexes"

    # This creates a named index for a target field, which can either be a vector field or a scalar field.
    #
    # @param collection_name [String] The name of the collection to create the index for.
    # @param index_params [Hash] The parameters for the index.
    # @return [Hash] Server response
    def create(
      collection_name:,
      index_params:
    )
      response = client.connection.post("#{PATH}/create") do |req|
        req.body = {
          collectionName: collection_name,
          indexParams: index_params
        }
      end
      response.body.empty? ? true : response.body
    end

    # This operation deletes index from a specified collection.
    #
    # @param collection_name [String] The name of the collection to delete the index from.
    # @param index_name [String] The name of the index to delete.
    # @return [Hash] Server response
    def drop(
      collection_name:,
      index_name:
    )
      response = client.connection.post("#{PATH}/drop") do |req|
        req.body = {
          collectionName: collection_name,
          indexName: index_name
        }
      end
      response.body.empty? ? true : response.body
    end

    # This operation describes the current index.
    #
    # @param collection_name [String] The name of the collection to describe the index for.
    # @param index_name [String] The name of the index to describe.
    # @return [Hash] Server response
    def describe(
      collection_name:,
      index_name:
    )
      response = client.connection.post("#{PATH}/describe") do |req|
        req.body = {
          collectionName: collection_name,
          indexName: index_name
        }
      end
      response.body.empty? ? true : response.body
    end

    # This operation lists all indexes of a specific collection.
    #
    # @param collection_name [String] The name of the collection to list indexes for.
    # @return [Hash] Server response
    def list(
      collection_name:
    )
      response = client.connection.post("#{PATH}/list") do |req|
        req.body = {
          collectionName: collection_name
        }
      end
      response.body.empty? ? true : response.body
    end
  end
end
