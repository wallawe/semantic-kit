class CreateExpos < ActiveRecord::Migration
  def change
    create_table :expos do |t|
      t.references :user
      t.string :url
      t.string :image
      t.timestamps
    end
  end
end
