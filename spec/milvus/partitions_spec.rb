# spec/milvus/partitions_spec.rb

require "spec_helper"
require "faraday"

RSpec.describe Milvus::Partitions do
  let(:client) { instance_double("Client", connection: connection) }
  let(:connection) { instance_double("Faraday::Connection") }
  let(:partitions) { described_class.new(client: client) }

  describe "#list" do
    let(:collection_name) { "test_collection" }
    let(:response_body) { File.read("spec/fixtures/partitions/list.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "lists all partitions in the specified collection" do
      expect(connection).to receive(:post).with("partitions/list").and_return(response)
      result = partitions.list(collection_name: collection_name)
      expect(result).to eq(response_body)
    end
  end

  describe "#create" do
    let(:collection_name) { "test_collection" }
    let(:partition_name) { "test_partition" }
    let(:response_body) { File.read("spec/fixtures/partitions/create.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "creates a partition in a collection" do
      expect(connection).to receive(:post).with("partitions/create").and_return(response)
      result = partitions.create(collection_name: collection_name, partition_name: partition_name)
      expect(result).to eq(response_body)
    end
  end

  describe "#drop" do
    let(:collection_name) { "test_collection" }
    let(:partition_name) { "test_partition" }
    let(:response_body) { File.read("spec/fixtures/partitions/drop.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "drops the current partition from the collection" do
      expect(connection).to receive(:post).with("partitions/drop").and_return(response)
      result = partitions.drop(collection_name: collection_name, partition_name: partition_name)
      expect(result).to eq(response_body)
    end
  end

  describe "#has" do
    let(:collection_name) { "test_collection" }
    let(:partition_name) { "test_partition" }
    let(:response_body) { File.read("spec/fixtures/partitions/has.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "checks whether a partition exists" do
      expect(connection).to receive(:post).with("partitions/has").and_return(response)
      result = partitions.has(collection_name: collection_name, partition_name: partition_name)
      expect(result).to eq(response_body)
    end
  end

  describe "#load" do
    let(:collection_name) { "test_collection" }
    let(:partition_names) { ["test_partition"] }
    let(:response_body) { File.read("spec/fixtures/partitions/load.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "loads the data of the current partition into memory" do
      expect(connection).to receive(:post).with("partitions/load").and_return(response)
      result = partitions.load(collection_name: collection_name, partition_names: partition_names)
      expect(result).to eq(response_body)
    end
  end

  describe "#release" do
    let(:collection_name) { "test_collection" }
    let(:partition_names) { ["test_partition"] }
    let(:response_body) { File.read("spec/fixtures/partitions/release.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "releases the data of the current partition from memory" do
      expect(connection).to receive(:post).with("partitions/release").and_return(response)
      result = partitions.release(collection_name: collection_name, partition_names: partition_names)
      expect(result).to eq(response_body)
    end
  end

  describe "#get_stats" do
    let(:collection_name) { "test_collection" }
    let(:partition_name) { "test_partition" }
    let(:response_body) { File.read("spec/fixtures/partitions/get_stats.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "gets the number of entities in a partition" do
      expect(connection).to receive(:post).with("partitions/get_stats").and_return(response)
      result = partitions.get_stats(collection_name: collection_name, partition_name: partition_name)
      expect(result).to eq(response_body)
    end
  end
end
