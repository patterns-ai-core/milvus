# frozen_string_literal: true

module Milvus
  class Entities < Base
    PATH = "entities"

    # This operation inserts data into a specific collection.
    #
    # @param collection_name [String] The name of the collection to insert data into.
    # @param data [Array<Hash>] The data to insert.
    # @param partition_name [String] The name of the partition to insert the data into.
    #
    # @return [Hash] The response from the server.
    def insert(
      collection_name:,
      data:,
      partition_name: nil
    )
      response = client.connection.post("#{PATH}/insert") do |req|
        req.body = {
          collectionName: collection_name,
          data: data
        }
        req.body[:partitionName] = partition_name if partition_name
      end
      response.body.empty? ? true : response.body
    end

    # This operation deletes entities by their IDs or with a boolean expression.
    #
    # @param collection_name [String] The name of the collection to delete entities from.
    # @param filter [String] The filter to use to delete entities.
    # @return [Hash] The response from the server.
    def delete(
      collection_name:,
      filter:
    )
      response = client.connection.post("#{PATH}/delete") do |req|
        req.body = {
          collectionName: collection_name,
          filter: filter
        }
      end
      response.body.empty? ? true : response.body
    end

    # This operation conducts a filtering on the scalar field with a specified boolean expression.
    #
    # @param collection_name [String] The name of the collection to query.
    # @param filter [String] The filter to use to query the collection.
    # @param output_fields [Array<String>] The fields to return in the results.
    # @param limit [Integer] The maximum number of results to return.
    def query(
      collection_name:,
      filter:,
      output_fields: [],
      limit: nil
    )
      response = client.connection.post("#{PATH}/query") do |req|
        req.body = {
          collectionName: collection_name,
          filter: filter
        }
        req.body[:outputFields] = output_fields if output_fields
        req.body[:limit] = limit if limit
      end
      response.body.empty? ? true : response.body
    end

    # This operation inserts new records into the database or updates existing ones.
    #
    # @param collection_name [String] The name of the collection to upsert data into.
    # @param data [Array<Hash>] The data to upsert.
    # @param partition_name [String] The name of the partition to upsert the data into.
    # @return [Hash] The response from the server.
    def upsert(
      collection_name:,
      data:,
      partition_name: nil
    )
      response = client.connection.post("#{PATH}/upsert") do |req|
        req.body = {
          collectionName: collection_name,
          data: data
        }
        req.body[:partitionName] = partition_name if partition_name
      end
      response.body.empty? ? true : response.body
    end

    # This operation gets specific entities by their IDs
    #
    # @param collection_name [String] The name of the collection to get entities from.
    # @param id [Array<Integer>] The IDs of the entities to get.
    # @param output_fields [Array<String>] The fields to return in the results.
    # @return [Hash] The response from the server.
    def get(
      collection_name:,
      id:,
      output_fields: nil
    )
      response = client.connection.post("#{PATH}/get") do |req|
        req.body = {
          collectionName: collection_name,
          id: id
        }
        req.body[:outputFields] = output_fields if output_fields
      end
      response.body.empty? ? true : response.body
    end

    # This operation conducts a vector similarity search with an optional scalar filtering expression.
    #
    # @param collection_name [String] The name of the collection to search.
    # @param data [Array<Array<Float>>] The data to search for.
    # @param anns_field [String] The field to search for.
    # @param limit [Integer] The maximum number of results to return.
    # @param output_fields [Array<String>] The fields to return in the results.
    # @param offset [Integer] The offset to start from.
    # @param filter [String] The filter to use to search the collection.
    # @return [Hash] The search results.
    def search(
      collection_name:,
      data:,
      anns_field:,
      filter: nil,
      limit: nil,
      offset: nil,
      grouping_field: nil,
      group_size: nil,
      strict_group_size: nil,
      output_fields: [],
      search_params: {},
      partition_names: []
    )
      response = client.connection.post("#{PATH}/search") do |req|
        params = {
          collectionName: collection_name,
          data: data,
          annsField: anns_field
        }
        params[:limit] = limit if limit
        params[:outputFields] = output_fields if output_fields.any?
        params[:offset] = offset if offset
        params[:filter] = filter if filter
        params[:searchParams] = search_params if search_params.any?
        params[:partitionNames] = partition_names if partition_names.any?
        params[:groupingField] = grouping_field if grouping_field
        params[:groupSize] = group_size if group_size
        params[:strictGroupSize] = strict_group_size if strict_group_size

        req.body = params
      end
      response.body.empty? ? true : response.body
    end

    # Executes a hybrid search.
    #
    # @param collection_name [String] The name of the collection to search.
    # @param data [Array<Hash>] The data to search for.
    # @param rerank [Hash] The rerank parameters.
    # @param limit [Integer] The maximum number of results to return.
    # @param output_fields [Array<String>] The fields to return in the results.
    # @return [Hash] The search results.
    def hybrid_search(
      collection_name:,
      search:,
      rerank:,
      limit: nil,
      output_fields: []
    )
      response = client.connection.post("#{PATH}/hybrid_search") do |req|
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
