class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :username,        :string
    add_column :users, :name,            :string
    add_column :users, :email,           :string
    add_column :users, :password_digest, :string
    add_column :users, :location,        :string
    add_column :users, :website,         :string
    add_column :users, :about,           :text
  end
end
