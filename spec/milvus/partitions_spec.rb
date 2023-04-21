# frozen_string_literal: true

require "spec_helper"

RSpec.describe Milvus::Partitions do
  let(:client) {
    Milvus::Client.new(
      url: "http://localhost:9091"
    )
  }

  let(:partitions) { client.partitions }
  let(:status_fixture) { JSON.parse(File.read("spec/fixtures/status.json")) }

  describe "#create" do
    let(:response) { OpenStruct.new(body: {}) }

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:post)
        .with(Milvus::Partitions::PATH)
        .and_return(response)
    end

    it "returns true" do
      response = client.partitions.create(
        collection_name: "book",
        partition_name: "test"
      )
      expect(response).to eq(true)
    end
  end

  describe "#get" do
    let(:response) { OpenStruct.new(body: status_fixture) }

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:get)
        .with("#{Milvus::Partitions::PATH}/existence")
        .and_return(response)
    end

    it "returns partition" do
      response = client.partitions.get(
        collection_name: "book",
        partition_name: "test"
      )
      expect(response).to eq(status_fixture)
    end
  end

  describe "#delete" do
    let(:response) { OpenStruct.new(body: {}) }

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:delete)
        .with(Milvus::Partitions::PATH)
        .and_return(response)
    end

    it "returns true" do
      response = client.partitions.delete(
        collection_name: "book",
        partition_name: "test"
      )
      expect(response).to eq(true)
    end
  end

  describe "#load" do
    let(:response) { OpenStruct.new(body: {}) }

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:post)
        .with("#{Milvus::Partitions::PATH}s/load")
        .and_return(response)
    end

    it "returns true" do
      response = client.partitions.load(
        collection_name: "book",
        partition_names: ["test"]
      )
      expect(response).to eq(true)
    end
  end

  describe "#release" do
    let(:response) { OpenStruct.new(body: {}) }

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:delete)
        .with("#{Milvus::Partitions::PATH}s/load")
        .and_return(response)
    end

    it "returns true" do
      response = partitions.release(
        collection_name: "book",
        partition_names: ["test"]
      )
      expect(response).to eq(true)
    end
  end
end
