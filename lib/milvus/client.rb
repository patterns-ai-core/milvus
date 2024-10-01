# frozen_string_literal: true

require "faraday"

module Milvus
  class Client
    attr_reader :url, :api_key, :adapter, :raise_error, :logger

    API_VERSION = "v2/vectordb"

    def initialize(
      url:,
      api_key: nil,
      adapter: Faraday.default_adapter,
      raise_error: false,
      logger: nil
    )
      @url = url
      @api_key = api_key
      @adapter = adapter
      @raise_error = raise_error
      @logger = logger || Logger.new($stdout)
    end

    def collections
      @schema ||= Milvus::Collections.new(client: self)
    end

    def partitions
      @partitions ||= Milvus::Partitions.new(client: self)
    end

    def entities
      @entities ||= Milvus::Entities.new(client: self)
    end

    def indexes
      @indexes ||= Milvus::Indexes.new(client: self)
    end

    def roles
      @roles ||= Milvus::Roles.new(client: self)
    end

    def users
      @users ||= Milvus::Users.new(client: self)
    end

    def aliases
      @aliases ||= Milvus::Aliases.new(client: self)
    end

    def connection
      @connection ||= Faraday.new(url: "#{url}/#{API_VERSION}/") do |faraday|
        if api_key
          faraday.request :authorization, :Bearer, api_key
        end
        faraday.request :json
        faraday.response :logger, logger, {headers: true, bodies: true, errors: true}
        faraday.response :raise_error if raise_error
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter adapter
      end
    end
  end
end
