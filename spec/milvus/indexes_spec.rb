# spec/milvus/indexes_spec.rb

require "spec_helper"
require "faraday"

RSpec.describe Milvus::Indexes do
  let(:client) { instance_double("Client", connection: connection) }
  let(:connection) { instance_double("Faraday::Connection") }
  let(:indexes) { described_class.new(client: client) }

  describe "#create" do
    let(:collection_name) { "test_collection" }
    let(:index_params) { {metricType: "L2", indexType: "IVF_FLAT", params: {nlist: 128}} }
    let(:response_body) { File.read("spec/fixtures/indexes/create.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "creates a named index for a target field" do
      expect(connection).to receive(:post).with("indexes/create").and_return(response)
      result = indexes.create(collection_name: collection_name, index_params: index_params)
      expect(result).to eq(response_body)
    end
  end

  describe "#drop" do
    let(:collection_name) { "test_collection" }
    let(:index_name) { "test_index" }
    let(:response_body) { File.read("spec/fixtures/indexes/drop.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "deletes index from a specified collection" do
      expect(connection).to receive(:post).with("indexes/drop").and_return(response)
      result = indexes.drop(collection_name: collection_name, index_name: index_name)
      expect(result).to eq(response_body)
    end
  end

  describe "#describe" do
    let(:collection_name) { "test_collection" }
    let(:index_name) { "test_index" }
    let(:response_body) { File.read("spec/fixtures/indexes/describe.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "describes the current index" do
      expect(connection).to receive(:post).with("indexes/describe").and_return(response)
      result = indexes.describe(collection_name: collection_name, index_name: index_name)
      expect(result).to eq(response_body)
    end
  end

  describe "#list" do
    let(:collection_name) { "test_collection" }
    let(:response_body) { File.read("spec/fixtures/indexes/list.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "lists all indexes of a specific collection" do
      expect(connection).to receive(:post).with("indexes/list").and_return(response)
      result = indexes.list(collection_name: collection_name)
      expect(result).to eq(response_body)
    end
  end
end
