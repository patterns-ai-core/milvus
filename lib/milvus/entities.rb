# frozen_string_literal: true

module Milvus
  class Entities < Base
    PATH = "entities".freeze

    # Insert the data to the collection.
    def insert(
      collection_name:,
      fields_data:,
      num_rows:,
      partition_name: nil
    )
      response = client.connection.post(PATH) do |req|
        req.body = {
          collection_name: collection_name,
          fields_data: fields_data,
          num_rows: num_rows
        }.to_json

        req.body['partition_name'] = partition_name if partition_name
      end
      response.body
    end

    # Delete the entities with the boolean expression you created
    def delete(
      collection_name:,
      expression:
    )
      response = client.connection.delete(PATH) do |req|
        req.body = {
          collection_name: collection_name,
          expr: expression
        }.to_json
      end
      response.body
    end

    # Compact data manually
    def compact!(
      collection_id:
    )
      response = client.connection.post("compaction") do |req|
        req.body = {
          collectionID: collection_id
        }.to_json
      end
      response.body
    end

    # Check compaction status
    def compact_status(
      compaction_id:
    )
      response = client.connection.get("compaction/state") do |req|
        req.body = {
          compactionID: compaction_id
        }.to_json
      end
      response.body
    end
  end
end
