# frozen_string_literal: true

FactoryBot.define do
  factory :api_user do
    name { Faker::Name.name }

    trait :active do
      expires_at { nil }
      revoked_at { nil }
    end

    trait :expired do
      expires_at { 1.day.ago }
    end

    trait :revoked do
      revoked_at { 1.day.ago }
    end
  end
end

# == Schema Information
#
# Table name: api_users
#
#  id           :bigint(8)        not null, primary key
#  name         :string           not null
#  token_digest :string
#  expires_at   :datetime
#  revoked_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_api_users_on_token_digest  (token_digest) UNIQUE
#
