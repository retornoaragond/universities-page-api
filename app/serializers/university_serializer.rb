# frozen_string_literal: true

class UniversitySerializer < ActiveModel::Serializer

  attributes :id, :name, :location, :website_url

  has_many :contact_emails

end
