# frozen_string_literal: true

class University < ApplicationRecord

  has_many :contact_emails, dependent: :destroy

  validates :name, presence: true
  validates :location, presence: true
  validates :website_url, presence: true,
                          format: { with: URI::DEFAULT_PARSER.make_regexp,
                                    message: I18n.t("errors.invalid_url") }

  accepts_nested_attributes_for :contact_emails, allow_destroy: true

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
