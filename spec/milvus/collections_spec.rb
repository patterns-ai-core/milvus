# spec/milvus/collections_spec.rb

require "spec_helper"
require "faraday"

RSpec.describe Milvus::Collections do
  let(:client) { instance_double("Client", connection: connection) }
  let(:connection) { instance_double("Faraday::Connection") }
  let(:collections) { described_class.new(client: client) }

  describe "#has" do
    let(:collection_name) { "test_collection" }
    let(:response_body) { File.read("spec/fixtures/collections/has.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "checks whether a collection exists" do
      expect(connection).to receive(:post).with("collections/has").and_yield(Faraday::Request.new).and_return(response)
      result = collections.has(collection_name: collection_name)
      expect(result).to eq(response_body)
    end
  end

  describe "#rename" do
    let(:collection_name) { "test_collection" }
    let(:new_collection_name) { "new_test_collection" }

    context "when the rename is successful" do
      let(:response_body) { File.read("spec/fixtures/collections/rename.json") }
      let(:response) { instance_double("Faraday::Response", body: response_body) }

      it "renames an existing collection" do
        expect(connection).to receive(:post).with("collections/rename").and_return(response)
        result = collections.rename(collection_name: collection_name, new_collection_name: new_collection_name)
        expect(result).to eq(response_body)
      end
    end

    context "when the rename fails" do
      let(:response_body) { File.read("spec/fixtures/collections/rename_error.json") }
      let(:response) { instance_double("Faraday::Response", body: response_body) }

      it "returns an error message" do
        expect(connection).to receive(:post).with("collections/rename").and_return(response)
        result = collections.rename(collection_name: collection_name, new_collection_name: new_collection_name)
        expect(result).to eq(response_body)
      end
    end
  end

  describe "#get_stats" do
    let(:collection_name) { "test_collection" }
    let(:response_body) { File.read("spec/fixtures/collections/get_stats.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "gets the number of entities in a collection" do
      expect(connection).to receive(:post).with("collections/get_stats").and_yield(Faraday::Request.new).and_return(response)
      result = collections.get_stats(collection_name: collection_name)
      expect(result).to eq(response_body)
    end
  end

  describe "#create" do
    let(:collection_name) { "test_collection" }
    let(:auto_id) { true }
    let(:description) { "Test collection" }
    let(:fields) { [{name: "field1", type: "int64"}] }
    let(:response_body) { File.read("spec/fixtures/collections/create.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "creates a collection" do
      expect(connection).to receive(:post).with("collections/create").and_return(response)
      result = collections.create(collection_name: collection_name, auto_id: auto_id, description: description, fields: fields)
      expect(result).to eq(response_body)
    end
  end

  describe "#describe" do
    let(:collection_name) { "test_collection" }
    let(:response_body) { File.read("spec/fixtures/collections/describe.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "describes the details of a collection" do
      expect(connection).to receive(:post).with("collections/describe").and_yield(Faraday::Request.new).and_return(response)
      result = collections.describe(collection_name: collection_name)
      expect(result).to eq(response_body)
    end
  end

  describe "#list" do
    let(:response_body) { File.read("spec/fixtures/collections/list.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "lists all collections in the specified database" do
      expect(connection).to receive(:post).with("collections/list").and_yield(Faraday::Request.new).and_return(response)
      result = collections.list
      expect(result).to eq(response_body)
    end
  end

  describe "#drop" do
    let(:collection_name) { "test_collection" }
    let(:response_body) { File.read("spec/fixtures/collections/drop.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "drops the current collection and all data within the collection" do
      expect(connection).to receive(:post).with("collections/drop").and_return(response)
      result = collections.drop(collection_name: collection_name)
      expect(result).to eq(response_body)
    end
  end

  describe "#load" do
    let(:collection_name) { "test_collection" }
    let(:response_body) { File.read("spec/fixtures/collections/load.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "loads the collection to memory" do
      expect(connection).to receive(:post).with("collections/load").and_return(response)
      result = collections.load(collection_name: collection_name)
      expect(result).to eq(response_body)
    end
  end

  describe "#get_load_state" do
    let(:collection_name) { "test_collection" }
    let(:response_body) { File.read("spec/fixtures/collections/get_load_state.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "returns the load status of a specific collection" do
      expect(connection).to receive(:post).with("collections/get_load_state").and_yield(Faraday::Request.new).and_return(response)
      result = collections.get_load_state(collection_name: collection_name)
      expect(result).to eq(response_body)
    end
  end

  describe "#release" do
    let(:collection_name) { "test_collection" }
    let(:response_body) { File.read("spec/fixtures/collections/release.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "releases a collection from memory" do
      expect(connection).to receive(:post).with("collections/release").and_return(response)
      result = collections.release(collection_name: collection_name)
      expect(result).to eq(response_body)
    end
  end
end
