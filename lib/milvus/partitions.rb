# frozen_string_literal: true

module Milvus
  class Partitions < Base
    PATH = "partitions"

    # This operation lists all partitions in the database used in the current connection.
    #
    # @param collection_name [String] The name of the collection.
    # @return [Hash] Server response
    def list(collection_name:)
      response = client.connection.post("#{PATH}/list") do |req|
        req.body = {collectionName: collection_name}
      end
      response.body.empty? ? true : response.body
    end

    # This operation creates a partition in a collection.
    #
    # @param collection_name [String] The name of the collection to create the partition in.
    # @param partition_name [String] The name of the partition to create.
    def create(collection_name:, partition_name:)
      response = client.connection.post("#{PATH}/create") do |req|
        req.body = {
          collectionName: collection_name,
          partitionName: partition_name
        }
      end
      response.body.empty? ? true : response.body
    end

    # This operation drops the current partition. To successfully drop a partition, ensure that the partition is already released.
    #
    # @param collection_name [String] The name of the collection to drop the partition from.
    # @param partition_name [String] The name of the partition to drop.
    # @return [Hash] Server response
    def drop(collection_name:, partition_name:)
      response = client.connection.post("#{PATH}/drop") do |req|
        req.body = {
          collectionName: collection_name,
          partitionName: partition_name
        }
      end
      response.body.empty? ? true : response.body
    end

    # This operation checks whether a partition exists.
    #
    # @param collection_name [String] The name of the collection to check for the partition in.
    # @param partition_name [String] The name of the partition to check.
    # @return [Hash] Server response
    def has(collection_name:, partition_name:)
      response = client.connection.post("#{PATH}/has") do |req|
        req.body = {
          collectionName: collection_name,
          partitionName: partition_name
        }
      end
      response.body.empty? ? true : response.body
    end

    # This operation loads the data of the current partition into memory.
    #
    # @param collection_name [String] The name of the collection to load.
    # @param partition_names [Array<String>] The names of the partitions to load.
    # @return [Hash] Server response
    def load(collection_name:, partition_names:)
      response = client.connection.post("#{PATH}/load") do |req|
        req.body = {
          collectionName: collection_name,
          partitionNames: partition_names
        }
      end
      response.body.empty? ? true : response.body
    end

    # This operation releases the data of the current partition from memory.
    #
    # @param collection_name [String] The name of the collection to release.
    # @param partition_name [String] The name of the partition to release.
    # @return [Hash] Server response
    def release(collection_name:, partition_names:)
      response = client.connection.post("#{PATH}/release") do |req|
        req.body = {
          collectionName: collection_name,
          partitionNames: partition_names
        }
      end
      response.body.empty? ? true : response.body
    end

    # This operations gets the number of entities in a partition.
    #
    # @param partition_name [String] The name of the partition to get the number of entities in.
    # @return [Hash] Server response
    def get_stats(collection_name:, partition_name:)
      response = client.connection.post("#{PATH}/get_stats") do |req|
        req.body = {
          collectionName: collection_name,
          partitionName: partition_name
        }
      end
      response.body.empty? ? true : response.body
    end
  end
end
