# frozen_string_literal: true

RSpec.shared_examples_for "api authed endpoint" do
  context "active api user" do
    let(:api_user) { create(:api_user, :active) }
    let(:headers) do
      { "Authorization" => "Bearer #{api_user.raw_token}" }
    end

    it "allows the request" do
      request
      expect(200..300).to include(response.status)
    end
  end

  context "expired api user" do
    let(:api_user) { create(:api_user, :expired) }

    let(:headers) do
      { "Authorization" => "Bearer #{api_user.raw_token}" }
    end

    it "does not allow the request" do
      request
      expect(response.status).to eq(401)
      expect(JSON.parse(response.body)).to eq({ "errors" => ["Access denied"] })
    end
  end

  context "revoked api user" do
    let(:api_user) { create(:api_user, :revoked) }

    let(:headers) do
      { "Authorization" => "Bearer #{api_user.raw_token}" }
    end

    it "does not allow the request" do
      request
      expect(response.status).to eq(401)
      expect(JSON.parse(response.body)).to eq({ "errors" => ["Access denied"] })
    end
  end
end
