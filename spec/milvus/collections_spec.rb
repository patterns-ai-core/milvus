# frozen_string_literal: true

require "spec_helper"

RSpec.describe Milvus::Collections do
  let(:client) {
    Milvus::Client.new(
      url: "http://localhost:9091"
    )
  }

  let(:collections) { client.collections }
  let(:collection_fixture) { JSON.parse(File.read("spec/fixtures/collection.json")) }

  describe "#create" do
    let(:response) { OpenStruct.new(body: {}) }

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:post)
        .with(Milvus::Collections::PATH)
        .and_return(response)
    end

    it "returns true" do
      response = collections.create(
        collection_name: "book",
        description: "Test book search",
        auto_id: false,
        fields: [
          {
            "name": "book_id",
            "description": "book id",
            "is_primary_key": true,
            "autoID": false,
            "data_type": Milvus::DATA_TYPES["int64"]
          },
          {
            "name": "word_count",
            "description": "count of words",
            "is_primary_key": false,
            "data_type": Milvus::DATA_TYPES["int64"]
          },
          {
            "name": "book_intro",
            "description": "embedded vector of book introduction",
            "data_type": Milvus::DATA_TYPES["binary_vector"],
            "is_primary_key": false,
            "type_params": [
              {
                "key": "dim",
                "value": "2"
              }
            ]
          }
        ]
      )
      expect(response).to eq(true)
    end
  end

  describe "#delete" do
    let(:response) { OpenStruct.new(body: {}) }

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:delete)
        .with(Milvus::Collections::PATH)
        .and_return(response)
    end

    it "returns true" do
      expect(collections.delete(collection_name: "book")).to eq(true)
    end
  end

  describe "#get" do
    let(:response) { OpenStruct.new(body: collection_fixture) }

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:get)
        .with(Milvus::Collections::PATH)
        .and_return(response)
    end

    it "returns a collection" do
      expect(collections.get(collection_name: "book")).to eq(collection_fixture)
    end
  end

  describe "#load" do
    let(:response) { OpenStruct.new(body: {}) }

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:post)
        .with("#{Milvus::Collections::PATH}/load")
        .and_return(response)
    end

    it "returns true" do
      expect(collections.load(collection_name: "book")).to eq(true)
    end
  end

  describe "#release" do
    let(:response) { OpenStruct.new(body: {}) }

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:delete)
        .with("#{Milvus::Collections::PATH}/load")
        .and_return(response)
    end

    it "returns true" do
      expect(collections.release(collection_name: "book")).to eq(true)
    end
  end
end
