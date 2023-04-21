# frozen_string_literal: true

require "spec_helper"

RSpec.describe Milvus::Search do
  let(:client) {
    Milvus::Client.new(
      url: "http://localhost:9091"
    )
  }

  let(:search_result) { JSON.parse(File.read("spec/fixtures/search_result.json")) }

  describe "#post" do
    let(:response) { OpenStruct.new(body: search_result) }

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:post)
        .with(Milvus::Search::PATH)
        .and_return(response)
    end

    it "returns search result" do
      response = client.search(
        collection_name: "book",
        output_fields: ["book_id"], # optional
        anns_field: "book_intro",
        top_k: "2",
        params: "{\"nprobe\": 10}",
        metric_type: "L2",
        round_decimal: "-1",
        vectors: [[0.1, 0.2]],
        dsl_type: 1
      )
      expect(response).to eq(search_result)
    end
  end
end
