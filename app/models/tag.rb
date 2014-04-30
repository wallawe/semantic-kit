class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :themes, through: :taggings

  def to_param
    "#{name}".parameterize
  end
end
