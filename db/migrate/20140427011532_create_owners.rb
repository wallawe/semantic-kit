class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.references :user
      t.references :theme
      t.timestamps
    end
  end
end
