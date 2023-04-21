# frozen_string_literal: true

module Milvus
  class Partitions < Base
    PATH = "partition".freeze

    # Create a partition
    def create(collection_name:, partition_name:)
      response = client.connection.post(PATH, {
        collection_name: collection_name,
        partition_name: partition_name
      })
      response.body.empty? ? true : response.body
    end

    # Verify if a partition exists
    def get(collection_name:, partition_name:)
      response = client.connection.get("#{PATH}/existence") do |req|
        req.body = {
          collection_name: collection_name,
          partition_name: partition_name
        }
      end
      response.body.empty? ? true : response.body
    end

    # Dropping a partition
    def delete(collection_name:, partition_name:)
      response = client.connection.delete(PATH) do |req|
        req.body = {
          collection_name: collection_name,
          partition_name: partition_name
        }
      end
      response.body.empty? ? true : response.body
    end

    # Load a Partition
    def load(
      collection_name:,
      partition_names:,
      replica_number: nil
    )
      response = client.connection.post("#{PATH}s/load") do |req|
        req.body = {
          collection_name: collection_name,
          partition_names: partition_names
        }
        req.body[:replica_number] = replica_number if replica_number
      end
      response.body.empty? ? true : response.body
    end

    def release(
      collection_name:,
      partition_name:,
      replica_number: nil
    )
      response = client.connection.delete("#{PATH}s/load") do |req|
        req.body = {
          collection_name: collection_name,
          partition_name: partition_name
        }
        req.body[:replica_number] = replica_number if replica_number
      end
      response.body.empty? ? true : response.body
    end
  end
end
