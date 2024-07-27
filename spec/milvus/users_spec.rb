# spec/milvus/users_spec.rb

require "spec_helper"
require "faraday"

RSpec.describe Milvus::Users do
  let(:connection) { instance_double("Faraday::Connection") }
  let(:client) { instance_double("Client", connection: connection) }
  let(:users) { described_class.new(client: client) }

  describe "#create" do
    let(:response_body) { File.read("spec/fixtures/users/create.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "creates a user" do
      expect(connection).to receive(:post)
        .with("users/create")
        .and_yield(Faraday::Request.new)
        .and_return(response)
      result = users.create(user_name: "user_name", password: "password")

      expect(result).to eq(response_body)
    end
  end

  describe "#describe" do
    let(:response_body) { File.read("spec/fixtures/users/describe.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "describes the user" do
      expect(connection).to receive(:post)
        .with("users/describe")
        .and_yield(Faraday::Request.new)
        .and_return(response)
      result = users.describe(user_name: "root")

      expect(result).to eq(response_body)
    end
  end

  describe "#list" do
    let(:response_body) { File.read("spec/fixtures/users/list.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "responds with a list of users" do
      expect(connection).to receive(:post)
        .with("users/list")
        .and_yield(Faraday::Request.new)
        .and_return(response)
      result = users.list

      expect(result).to eq(response_body)
    end
  end

  describe "#drop" do
    let(:response_body) { File.read("spec/fixtures/users/drop.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "drops the user" do
      expect(connection).to receive(:post)
        .with("users/drop")
        .and_yield(Faraday::Request.new)
        .and_return(response)
      result = users.drop(user_name: "root")

      expect(result).to eq(response_body)
    end
  end

  describe "#update_password" do
    let(:response_body) { File.read("spec/fixtures/users/update_password.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "updates the users's password" do
      expect(connection).to receive(:post)
        .with("users/update_password")
        .and_yield(Faraday::Request.new)
        .and_return(response)
      result = users.update_password user_name: "username",
        password: "old_password",
        new_password: "new_password"

      expect(result).to eq(response_body)
    end
  end

  describe "#grant_role" do
    let(:response_body) { File.read("spec/fixtures/users/grant_role.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "sets role to the user" do
      expect(connection).to receive(:post)
        .with("users/grant_role")
        .and_yield(Faraday::Request.new)
        .and_return(response)
      result = users.grant_role user_name: "user_name", role_name: "admin"

      expect(result).to eq(response_body)
    end
  end

  describe "#revoke_role" do
    let(:response_body) { File.read("spec/fixtures/users/revoke_role.json") }
    let(:response) { instance_double("Faraday::Response", body: response_body) }

    it "revokes the role" do
      expect(connection).to receive(:post)
        .with("users/revoke_role")
        .and_yield(Faraday::Request.new)
        .and_return(response)
      result = users.revoke_role user_name: "user_name", role_name: "admin"

      expect(result).to eq(response_body)
    end
  end
end
