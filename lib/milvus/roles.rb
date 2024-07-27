# frozen_string_literal: true

module Milvus
  class Roles < Base
    PATH = "roles"

    # Lists available roles on the server
    #
    # @return [Hash] The response from the server.
    def list
      response = client.connection.post("#{PATH}/list") do |req|
        req.body = {}
      end

      response.body
    end

    # This operation inserts data into a specific collection.
    #
    # @param role_name [String] The name of the collection to insert data into.
    # @return [Hash] The response from the server.
    def describe(role_name:)
      response = client.connection.post("#{PATH}/describe") do |req|
        req.body = {
          roleName: role_name
        }
      end

      response.body
    end
  end
end
