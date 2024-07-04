# spec/milvus/entities_spec.rb

require "spec_helper"
require "faraday"

RSpec.describe Milvus::Entities do
  let(:client) { instance_double("Client", connection: connection) }
  let(:connection) { instance_double("Faraday::Connection") }
  let(:entities) { described_class.new(client: client) }

  describe "#insert" do
    let(:collection_name) { "test_collection" }
    let(:data) { [{field1: "value1"}] }
    let(:response_body) { File.read("spec/fixtures/entities/insert.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "inserts data into a specific collection" do
      expect(connection).to receive(:post).with("entities/insert").and_return(response)
      result = entities.insert(collection_name: collection_name, data: data)
      expect(result).to eq(response_body)
    end
  end

  describe "#delete" do
    let(:collection_name) { "test_collection" }
    let(:filter) { "id in [1, 2, 3]" }
    let(:response_body) { File.read("spec/fixtures/entities/delete.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "deletes entities by their IDs or with a boolean expression" do
      expect(connection).to receive(:post).with("entities/delete").and_return(response)
      result = entities.delete(collection_name: collection_name, filter: filter)
      expect(result).to eq(response_body)
    end
  end

  describe "#query" do
    let(:collection_name) { "test_collection" }
    let(:filter) { "field1 > 10" }
    let(:output_fields) { ["field1", "field2"] }
    let(:limit) { 10 }
    let(:response_body) { File.read("spec/fixtures/entities/query.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "conducts a filtering on the scalar field with a specified boolean expression" do
      expect(connection).to receive(:post).with("entities/query").and_return(response)
      result = entities.query(collection_name: collection_name, filter: filter, output_fields: output_fields, limit: limit)
      expect(result).to be true
    end
  end

  describe "#upsert" do
    let(:collection_name) { "test_collection" }
    let(:data) { [{field1: "value1"}] }
    let(:response_body) { File.read("spec/fixtures/entities/upsert.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "inserts new records into the database or updates existing ones" do
      expect(connection).to receive(:post).with("entities/upsert").and_return(response)
      result = entities.upsert(collection_name: collection_name, data: data)
      expect(result).to be true
    end
  end

  describe "#get" do
    let(:collection_name) { "test_collection" }
    let(:id) { [450847466900987461] }
    let(:output_fields) { ["field1", "field2"] }
    let(:response_body) { File.read("spec/fixtures/entities/get.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "gets specific entities by their IDs" do
      expect(connection).to receive(:post).with("entities/get").and_return(response)
      result = entities.get(collection_name: collection_name, id: id, output_fields: output_fields)
      expect(result).to eq(response_body)
    end
  end

  describe "#search" do
    let(:collection_name) { "test_collection" }
    let(:search) { {query: "test_query"} }
    let(:rerank) { {method: "test_method"} }
    let(:annsField) { "test_field" }
    let(:limit) { 10 }
    let(:output_fields) { ["field1", "field2"] }
    let(:response_body) { File.read("spec/fixtures/entities/search.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "executes a search" do
      expect(connection).to receive(:post).with("entities/search").and_return(response)
      result = entities.search(collection_name: collection_name, search: search, rerank: rerank, annsField: annsField, limit: limit, output_fields: output_fields)
      expect(result).to be true
    end
  end

  describe "#hybrid_search" do
    let(:collection_name) { "test_collection" }
    let(:search) do
      [
        {
          filter: "id in [450847466900987455]",
          data: [[0.1, 0.2, 0.3]],
          annsField: "vectors",
          limit: 10,
          outputFields: ["content", "id"]
        }
      ]
    end
    let(:rerank) do
      {
        strategy: "rrf",
        params: {
          k: 10
        }
      }
    end
    let(:limit) { 10 }
    let(:output_fields) { ["field1", "field2"] }
    let(:response_body) { File.read("spec/fixtures/entities/hybrid_search.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "executes a hybrid search" do
      expect(connection).to receive(:post).with("entities/hybrid_search").and_return(response)
      result = entities.hybrid_search(collection_name: collection_name, search: search, rerank: rerank, limit: limit, output_fields: output_fields)
      expect(result).to eq(response_body)
    end
  end
end
