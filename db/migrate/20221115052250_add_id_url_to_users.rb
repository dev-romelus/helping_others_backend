class AddIdUrlToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :identity_document_url, :string
  end
end
