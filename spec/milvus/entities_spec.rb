# frozen_string_literal: true

require "spec_helper"

RSpec.describe Milvus::Entities do
  let(:client) {
    Milvus::Client.new(
      url: "http://localhost:9091"
    )
  }

  let(:entities) { client.entities }
  let(:entities_created_fixture) { JSON.parse(File.read("spec/fixtures/entities_created.json")) }
  let(:entities_deleted_fixture) { JSON.parse(File.read("spec/fixtures/entities_deleted.json")) }
  let(:compaction_fixture) { JSON.parse(File.read("spec/fixtures/compaction.json")) }
  let(:status_fixture) { JSON.parse(File.read("spec/fixtures/status.json")) }

  describe "#insert" do
    let(:response) { OpenStruct.new(body: entities_created_fixture) }

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:post)
        .with(Milvus::Entities::PATH)
        .and_return(response)
    end

    it "returns true" do
      response = entities.insert(
        collection_name: "book",
        num_rows: 5,
        fields_data: [
          {
            "field_name": "book_id",
            "type": Milvus::DATA_TYPES["int64"],
            "field": [1,2,3,4,5]
          },
          {
            "field_name": "word_count",
            "type": Milvus::DATA_TYPES["int64"],
            "field": [1000,2000,3000,4000,5000]
          },
          {
            "field_name": "book_intro",
            "type": 101,
            "field": [ [1,1],[2,1],[3,1],[4,1],[5,1] ]
          }
        ]  
      )
      expect(response).to eq(entities_created_fixture)
    end
  end

  describe "#delete" do
    let(:response) { OpenStruct.new(body: entities_deleted_fixture) }

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:delete)
        .with(Milvus::Entities::PATH)
        .and_return(response)
    end

    it "returns true" do
      response = entities.delete(
        collection_name: "book",
        expression: "book_id in [0,1]"
      )
      expect(response).to eq(entities_deleted_fixture)
    end
  end

  describe "#compact" do
    let(:response) { OpenStruct.new(body: compaction_fixture) }

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:post)
        .with("compaction")
        .and_return(response)
    end

    it "returns true" do
      response = entities.compact!(
        collection_id: 440928616022607200
      )
      expect(response).to eq(compaction_fixture)
    end
  end

  describe "#compact_status" do
    let(:response) { OpenStruct.new(body: status_fixture) }

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:get)
        .with("compaction/state")
        .and_return(response)
    end

    it "returns true" do
      response = entities.compact_status(
        compaction_id: 440928616022607200
      )
      expect(response).to eq(status_fixture)
    end
  end
end
