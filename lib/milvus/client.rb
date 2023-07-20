# frozen_string_literal: true

require "faraday"

module Milvus
  class Client
    attr_reader :url, :api_key

    API_VERSION = "api/v1"

    def initialize(
      url:,
      api_key: nil
    )
      @url = url
      @api_key = api_key
    end

    def health
      @health ||= Milvus::Health.new(client: self).get
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

    def indices
      @indices ||= Milvus::Indices.new(client: self)
    end

    def search(...)
      @search ||= Milvus::Search.new(client: self).post(...)
    end

    def query(...)
      @query ||= Milvus::Query.new(client: self).post(...)
    end

    def connection
      @connection ||= Faraday.new(url: "#{url}/#{API_VERSION}/") do |faraday|
        if api_key
          faraday.request :authorization, :Bearer, api_key
        end
        retry_options = {
          max: 5,
          interval: 0.05,
          interval_randomness: 0.5,
          backoff_factor: 2
        }
        faraday.request :retry, retry_options
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter :net_http_persistent
      end
    end
  end
end
