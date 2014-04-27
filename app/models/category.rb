class Category < ActiveRecord::Base
  has_many :theme_categories
  has_many :themes, through: :theme_categories

  def to_param
    "#{name}".parameterize
  end
end
