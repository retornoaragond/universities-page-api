# frozen_string_literal: true

class ContactEmail < ApplicationRecord

  belongs_to :university

  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }

end
