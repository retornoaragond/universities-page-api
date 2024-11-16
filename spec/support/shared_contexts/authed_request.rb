# frozen_string_literal: true

shared_context "authed requests" do
  let(:api_user) { create(:api_user, :active) }
  let(:auth_headers) do
    {
      "Authorization" => "Bearer #{api_user.raw_token}",
    }
  end
end
