# frozen_string_literal: true

class ContactEmail < ApplicationRecord

  belongs_to :university

  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/,
                                              message: I18n.t("errors.invalid_emial") }

end

# == Schema Information
#
# Table name: contact_emails
#
#  id            :bigint(8)        not null, primary key
#  email         :string
#  university_id :bigint(8)        not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_contact_emails_on_university_id  (university_id)
#
# Foreign Keys
#
#  fk_rails_...  (university_id => universities.id)
#
