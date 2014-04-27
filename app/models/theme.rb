class Theme < ActiveRecord::Base
  has_many :theme_categories
  has_many :categories, through: :theme_categories

  has_one :owner
end
