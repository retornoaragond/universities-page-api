# frozen_string_literal: true

class CreateUniversities < ActiveRecord::Migration[7.2]
  def change
    create_table :universities do |t|
      t.string :name
      t.string :location
      t.string :website_url

      t.timestamps
    end
  end
end
