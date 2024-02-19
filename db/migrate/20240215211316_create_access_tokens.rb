# frozen_string_literal: true

class CreateAccessTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :access_tokens, id: :uuid do |t|
      t.string :token, null: false
      t.references :user, type: :uuid, foreign_key: true, index: true, unique: true
      t.timestamps
    end

    add_index :access_tokens, :token, unique: true
  end
end

