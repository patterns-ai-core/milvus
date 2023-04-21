# frozen_string_literal: true

require "spec_helper"

RSpec.describe Milvus::Query do
  let(:client) {
    Milvus::Client.new(
      url: "http://localhost:9091"
    )
  }

  let(:query_result) { JSON.parse(File.read("spec/fixtures/query_result.json")) }

  describe "#post" do
    let(:response) { OpenStruct.new(body: {}) }

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:post)
        .with(Milvus::Query::PATH)
        .and_return(response)
    end

    it "returns true" do
      response = client.query(
        collection_name: "book",
        output_fields: ["book_id", "book_intro"],
        expr: "book_id in [2,4,6,8]"
      )
      expect(response).to eq(true)
    end
  end
end