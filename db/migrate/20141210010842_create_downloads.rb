class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.references :theme
      t.references :user
      t.timestamps
    end
  end
end
