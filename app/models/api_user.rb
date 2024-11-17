# frozen_string_literal: true

class APIUser < ApplicationRecord

  HMAC_SECRET_KEY = Rails.application.credentials.api_key_hmac_secret_key

  validates :name, presence: true

  before_create :generate_raw_token
  before_create :generate_token_digest

  scope :active, -> { where(revoked_at: nil).where("expires_at is NULL OR expires_at > ?", Time.zone.now) }

  attr_accessor :raw_token

  def self.with_token(token)
    find_by(token_digest: generate_digest(token))
  end

  def self.generate_digest(token)
    OpenSSL::HMAC.hexdigest("SHA256", HMAC_SECRET_KEY, token)
  end

  private

  def generate_raw_token
    self.raw_token = SecureRandom.base58(30)
  end

  def generate_token_digest
    self.token_digest = self.class.generate_digest(raw_token)
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
