# frozen_string_literal: true

require "spec_helper"

RSpec.describe Milvus::Indices do
  let(:client) {
    Milvus::Client.new(
      url: "http://localhost:9091"
    )
  }

  let(:indices) { client.indices }
  let(:index_fixture) { JSON.parse(File.read("spec/fixtures/index.json")) }

  describe "#create" do
    let(:response) { OpenStruct.new(body: {}) }

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:post)
        .with(Milvus::Indices::PATH)
        .and_return(response)
    end

    it "returns true" do
      response = indices.create(
        collection_name: "book",
        field_name: "book_intro",
        extra_params: [
          { key: "metric_type", "value": "L2" },
          { key: "index_type", "value": "IVF_FLAT" },
          { key: "params", "value": "{\"nlist\":1024}" }
        ]
      )
      expect(response).to eq(true)
    end
  end

  describe "#delete" do
    let(:response) { OpenStruct.new(body: {}) }

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:delete)
        .with(Milvus::Indices::PATH)
        .and_return(response)
    end

    it "returns true" do
      response = indices.delete(
        collection_name: "book",
        field_name: "book_intro"
      )
      expect(response).to eq(true)
    end
  end
end