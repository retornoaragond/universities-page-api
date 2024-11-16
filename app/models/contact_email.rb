# frozen_string_literal: true

class ContactEmail < ApplicationRecord

  belongs_to :university

  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/,
                                              message: I18n.t("errors.invalid_emial") }

end
