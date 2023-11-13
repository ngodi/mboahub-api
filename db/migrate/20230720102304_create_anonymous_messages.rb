class CreateAnonymousMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :anonymous_messages do |t|
      t.string :sender_email
      t.string :sender_phone
      t.string :sender_name
      t.references :house, null: false, type: :uuid, foreign_key: true
      t.references :receiver, null: false, type: :uuid, foreign_key: {to_table: :users}
      t.text :content

      t.timestamps
    end
  end
end
