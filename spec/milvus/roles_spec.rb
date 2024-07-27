# spec/milvus/users_spec.rb

require "spec_helper"
require "faraday"

RSpec.describe Milvus::Roles do
  let(:connection) { instance_double("Faraday::Connection") }
  let(:client) { instance_double("Client", connection: connection) }
  let(:roles) { described_class.new(client: client) }

  describe "#list" do
    let(:response_body) { File.read("spec/fixtures/roles/list.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "lists users" do
      expect(connection).to receive(:post)
        .with("roles/list")
        .and_yield(Faraday::Request.new)
        .and_return(response)
      result = roles.list

      expect(result).to eq(response_body)
    end
  end

  describe "#describe" do
    let(:response_body) { File.read("spec/fixtures/roles/describe.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "describes the role" do
      expect(connection).to receive(:post)
        .with("roles/describe")
        .and_yield(Faraday::Request.new)
        .and_return(response)
      result = roles.describe(role_name: "public")

      expect(result).to eq(response_body)
    end
  end
end
