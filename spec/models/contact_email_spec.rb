# frozen_string_literal: true

require "rails_helper"

RSpec.describe ContactEmail, type: :model do
  describe "validations" do
    subject { build(:contact_email) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to allow_value("example123@example.com").for(:email) }
    it { is_expected.not_to allow_value("example123example.com").for(:email) }
  end
end
