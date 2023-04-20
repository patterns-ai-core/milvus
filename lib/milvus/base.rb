# frozen_string_literal: true

module Milvus
  class Base
    attr_reader :client

    def initialize(client:)
      @client = client
    end
  end
end
