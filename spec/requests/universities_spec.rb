# frozen_string_literal: true

require "rails_helper"

RSpec.describe API::V1::UniversitiesController, type: :request do

  include_context "authed requests"
  let!(:universities) do
    [
      create(:university, name: "University A", location: "New York", website_url: "http://universitya.com"),
      create(:university, name: "University B", location: "San Francisco", website_url: "http://universityb.com"),
    ]
  end
  let!(:university) { universities.first }
  let(:valid_attributes) do
    {
      name: "New University",
      location: "Los Angeles",
      website_url: "http://newuniversity.com",
      contact_emails_attributes: [
        { email: "info@newuniversity.com" },
      ],
    }
  end
  let(:invalid_attributes) { { name: "" } }

  describe "GET /index" do
    it "returns a paginated list of universities" do
      get "/api/v1/universities", headers: auth_headers

      expect(response).to have_http_status(:ok)
      json_response = response.parsed_body

      expect(json_response["universities"].size).to eq(2)
      expect(json_response["meta"]).to be_present
    end

    it "applies search filters" do
      get "/api/v1/universities", params: { search: "University A" }, headers: auth_headers

      expect(response).to have_http_status(:ok)
      json_response = response.parsed_body
      expect(json_response["universities"].size).to eq(1)
      expect(json_response["universities"].first["name"]).to eq("University A")
    end
  end

  describe "GET /show" do
    it_behaves_like "api authed endpoint" do
      let(:request) { get(api_v1_university_path(university), headers:) }
    end

    it "returns a single university" do
      get api_v1_university_path(university), headers: auth_headers

      expect(response).to have_http_status(:ok)
      json_response = response.parsed_body
      expect(json_response["name"]).to eq("University A")
    end

    it "returns a 404 when the university is not found" do
      get api_v1_university_path(id: 999), headers: auth_headers

      expect(response).to have_http_status(:not_found)
      json_response = response.parsed_body
      expect(json_response["errors"]).to include("Record not found")
    end
  end

  describe "POST /create" do
    it_behaves_like "api authed endpoint" do
      let(:request) { get("/api/v1/universities", params: { university: valid_attributes }, headers:) }
    end

    it "creates a new university with valid attributes" do
      post api_v1_universities_path, params: { university: valid_attributes }, headers: auth_headers

      expect(response).to have_http_status(:created)
      json_response = response.parsed_body
      expect(json_response["university"]["name"]).to eq("New University")
    end

    it "returns errors with invalid attributes" do
      post api_v1_universities_path, params: { university: invalid_attributes }, headers: auth_headers

      expect(response).to have_http_status(:unprocessable_entity)
      json_response = response.parsed_body
      expect(json_response["errors"]).to include("Name can't be blank")
    end
  end

  describe "PATCH /update" do

    it_behaves_like "api authed endpoint" do
      let(:request) do
        get(api_v1_university_path(university), params: { university: { name: "Updated University" } }, headers:)
      end
    end

    it "updates a university with valid attributes" do
      patch api_v1_university_path(university), params: { university: { name: "Updated University" } },
                                                headers: auth_headers

      expect(response).to have_http_status(:ok)
      json_response = response.parsed_body
      expect(json_response["university"]["name"]).to eq("Updated University")
    end

    it "returns errors with invalid attributes" do
      patch api_v1_university_path(university), params: { university: { name: "" } }, headers: auth_headers

      expect(response).to have_http_status(:unprocessable_entity)
      json_response = response.parsed_body
      expect(json_response["errors"]).to include("Name can't be blank")
    end
  end

  describe "DELETE /destroy" do

    it_behaves_like "api authed endpoint" do
      let(:request) { get(api_v1_university_path(university), headers:) }
    end

    it "deletes a university" do
      expect do
        delete api_v1_university_path(university), headers: auth_headers
      end.to change(University, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
