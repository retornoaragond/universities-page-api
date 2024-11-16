# frozen_string_literal: true

class University < ApplicationRecord

  has_many :contact_emails, dependent: :destroy

  validates :name, presence: true
  validates :location, presence: true
  validates :website_url, presence: true,
                          format: { with: URI::DEFAULT_PARSER.make_regexp, message: "must be a valid URL" }

  accepts_nested_attributes_for :contact_emails, allow_destroy: true

end
