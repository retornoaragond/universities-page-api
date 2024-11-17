# frozen_string_literal: true

class CreateAPIUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :api_users do |t|
      t.string :name, null: false
      t.string :token_digest, index: { unique: true }
      t.datetime :expires_at
      t.datetime :revoked_at

      t.timestamps
    end
  end
end
