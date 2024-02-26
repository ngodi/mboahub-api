class AddStatusToAnonymousMessage < ActiveRecord::Migration[6.1]
  def change
    add_column :anonymous_messages, :status, :string, default: 'received'
  end
end
