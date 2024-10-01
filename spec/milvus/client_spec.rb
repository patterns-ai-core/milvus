# frozen_string_literal: true

require "spec_helper"

RSpec.describe Milvus::Client do
  let(:client) {
    described_class.new(
      url: "localhost:8080",
      api_key: "123"
    )
  }

  describe "#initialize" do
    it "creates a client" do
      expect(client).to be_a(Milvus::Client)
    end

    it "accepts a custom logger" do
      logger = Logger.new($stdout)
      client = Milvus::Client.new(
        url: "localhost:8080",
        api_key: "123",
        logger: logger
      )
      expect(client.logger).to eq(logger)
    end
  end
end
