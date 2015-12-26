class ChangePrecisionOfExtendedTier < ActiveRecord::Migration
  def change
    change_column :price_lists, :extended_tier, :decimal, scale: 2, precision: 8
  end
end
