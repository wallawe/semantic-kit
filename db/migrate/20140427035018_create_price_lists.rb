class CreatePriceLists < ActiveRecord::Migration
  def change
    create_table :price_lists do |t|
      t.references :theme
      t.decimal    :single_tier,   scale: 2, precision: 5
      t.decimal    :multiple_tier, scale: 2, precision: 5
      t.decimal    :extended_tier, scale: 2, precision: 5
      t.timestamps
    end
  end
end
