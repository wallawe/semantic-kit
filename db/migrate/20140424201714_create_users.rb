class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :location
      t.string :website
      t.text :about

      t.timestamps
    end
  end
end
