# frozen_string_literal: true

require "rails_helper"

RSpec.describe APIUser, type: :model do
  describe "validations" do
    subject { build(:api_user) }

    it { is_expected.to validate_presence_of(:name) }
  end

  describe "before_create" do
    it "generates the raw token" do
      api_user = create(:api_user)
      expect(api_user.raw_token.size).to eq(30)
    end

    it "stores an encrypted token" do
      api_user = create(:api_user)
      expect(api_user.token_digest).to be_present
    end
  end

  describe ".with_token" do
    it "finds the api user from the raw token" do
      api_user = create(:api_user)
      found_api_user = APIUser.with_token(api_user.raw_token)
      expect(found_api_user).to eq(api_user)
    end
  end

  describe ".active" do
    it "returns the api users that are not revoked or expired" do
      active_api_user = create(:api_user, :active)
      create(:api_user, :revoked)
      create(:api_user, :expired)

      expect(APIUser.active).to eq([active_api_user])
    end
  end
end
