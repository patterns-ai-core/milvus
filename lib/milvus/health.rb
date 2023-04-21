# frozen_string_literal: true

module Milvus
  class Health < Base
    PATH = "health"

    def get
      response = client.connection.get(PATH.to_s)
      response.body
    end
  end
end
