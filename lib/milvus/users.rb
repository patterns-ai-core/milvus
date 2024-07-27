# frozen_string_literal: true

module Milvus
  class Users < Base
    PATH = "users"

    # Create a user
    #
    # @param user_name [String] Username for the user
    # @param password [String] Password for the user
    # @return [Hash] Server response
    def create(user_name:, password:)
      response = client.connection.post("#{PATH}/create") do |req|
        req.body = {
          userName: user_name,
          password: password
        }
      end

      response.body
    end

    # Describe a user
    #
    # @param user_name [String] Username for the user
    # @return [Hash] Server response
    def describe(user_name:)
      response = client.connection.post("#{PATH}/describe") do |req|
        req.body = {
          userName: user_name
        }
      end

      response.body
    end

    # List users
    #
    # @return [Hash] Server response
    def list
      response = client.connection.post("#{PATH}/list") do |req|
        req.body = {}
      end

      response.body
    end

    # Drops a user
    #
    # @param user_name [String] Username for the user
    # @return [Hash] Server response
    def drop(user_name:)
      response = client.connection.post("#{PATH}/drop") do |req|
        req.body = {
          userName: user_name
        }
      end

      response.body
    end

    def update_password(user_name:, password:, new_password:)
      response = client.connection.post("#{PATH}/update_password") do |req|
        req.body = {
          userName: user_name,
          password: password,
          newPassword: new_password
        }
      end

      response.body
    end

    def grant_role(user_name:, role_name:)
      response = client.connection.post("#{PATH}/grant_role") do |req|
        req.body = {
          userName: user_name,
          roleName: role_name
        }
      end

      response.body
    end

    def revoke_role(user_name:, role_name:)
      response = client.connection.post("#{PATH}/revoke_role") do |req|
        req.body = {
          userName: user_name,
          roleName: role_name
        }
      end

      response.body
    end
  end
end
