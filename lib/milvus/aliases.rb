# https://docs.zilliz.com/reference/restful/alias-operations-v2

module Milvus
  class Aliases < Base
    PATH = "aliases"

    # Lists available roles on the server
    #
    # @return [Hash] The response from the server
    def list
      response = client.connection.post("#{PATH}/list") do |req|
        req.body = {}
      end

      response.body
    end

    # Describes the details of a specific alias
    #
    # @param alias_name [String] The name of the alias to describe
    # @return [Hash] The response from the server
    def describe(alias_name:)
      response = client.connection.post("#{PATH}/describe") do |req|
        req.body = {
          aliasName: alias_name
        }
      end

      response.body
    end

    # Reassigns the alias of one collection to another
    #
    # @param alias_name [String] The alias of the collection
    # @param collection_name [String] The name of the target collection to reassign an alias to
    # @return [Hash] The response from the server
    def alter(alias_name:, collection_name:)
      response = client.connection.post("#{PATH}/alter") do |req|
        req.body = {
          aliasName: alias_name,
          collectionName: collection_name
        }
      end

      response.body
    end

    # This operation drops a specified alias
    #
    # @param alias_name [String] The alias to drop
    # @return [Hash] The response from the server
    def drop(alias_name:)
      response = client.connection.post("#{PATH}/drop") do |req|
        req.body = {
          aliasName: alias_name
        }
      end

      response.body
    end

    # This operation creates an alias for an existing collection. A collection can have multiple aliases, while an alias can be associated with only one collection.
    #
    # @param alias_name [String] The alias of the collection
    # @param collection_name [String] The name of the target collection to reassign an alias to
    # @return [Hash] The response from the server
    def create(alias_name:, collection_name:)
      response = client.connection.post("#{PATH}/create") do |req|
        req.body = {
          aliasName: alias_name,
          collectionName: collection_name
        }
      end

      response.body
    end
  end
end
