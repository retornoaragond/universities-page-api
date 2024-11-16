# frozen_string_literal: true

require "rails_helper"

RSpec.describe University, type: :model do
  describe "validations" do
    subject { build(:university) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:location) }
    it { is_expected.to validate_presence_of(:website_url) }
    it { is_expected.to allow_value("http://example.com").for(:website_url) }
    it { is_expected.not_to allow_value("example.com").for(:website_url) }
  end
end
