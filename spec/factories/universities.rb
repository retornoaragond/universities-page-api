# frozen_string_literal: true

FactoryBot.define do
  factory :university do
    name { Faker::University.name }
    location { Faker::Address.city }
    website_url { Faker::Internet.url(host: "#{name.parameterize}.edu") }
  end
end

# == Schema Information
#
# Table name: universities
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  location    :string
#  website_url :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
