# spec/milvus/aliases_spec.rb

require "spec_helper"
require "faraday"

RSpec.describe Milvus::Aliases do
  let(:connection) { instance_double("Faraday::Connection") }
  let(:client) { instance_double("Client", connection: connection) }
  let(:aliases) { described_class.new(client: client) }

  describe "#list" do
    let(:response_body) { File.read("spec/fixtures/aliases/list.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "lists aliases" do
      expect(connection).to receive(:post)
        .with("aliases/list")
        .and_yield(Faraday::Request.new)
        .and_return(response)
      result = aliases.list

      expect(result).to eq(response_body)
    end
  end

  describe "#describe" do
    let(:response_body) { File.read("spec/fixtures/aliases/describe.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "describes the details of a specific alias" do
      expect(connection).to receive(:post)
        .with("aliases/describe")
        .and_yield(Faraday::Request.new)
        .and_return(response)
      result = aliases.describe(alias_name: "bob")

      expect(result).to eq(response_body)
    end
  end

  describe "#alter" do
    let(:response_body) { File.read("spec/fixtures/aliases/alter.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "reassigns the alias of one collection to another" do
      expect(connection).to receive(:post)
        .with("aliases/alter")
        .and_yield(Faraday::Request.new)
        .and_return(response)
      result = aliases.alter(alias_name: "bob", collection_name: "new_collection")

      expect(result).to eq(response_body)
    end
  end

  describe "#drop" do
    let(:response_body) { File.read("spec/fixtures/aliases/drop.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "drops the alias" do
      expect(connection).to receive(:post)
        .with("aliases/drop")
        .and_yield(Faraday::Request.new)
        .and_return(response)
      result = aliases.drop(alias_name: "bob")

      expect(result).to eq(response_body)
    end
  end

  describe "#create" do
    let(:response_body) { File.read("spec/fixtures/aliases/create.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "creates alias for collection" do
      expect(connection).to receive(:post)
        .with("aliases/create")
        .and_yield(Faraday::Request.new)
        .and_return(response)
      result = aliases.create(alias_name: "bob", collection_name: "quick_setup")

      expect(result).to eq(response_body)
    end
  end
end
