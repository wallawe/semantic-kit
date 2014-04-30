class Theme < ActiveRecord::Base
  has_many :theme_categories
  has_many :categories, through: :theme_categories

  has_many :taggings
  has_many :tags, through: :taggings

  has_one :owner,      dependent: :destroy
  has_one :price_list, dependent: :destroy

  accepts_nested_attributes_for :price_list

  mount_uploader :image, ImageUploader

  validates :name, :description, presence: true

  def default_image_url
    if image_url.present?
      image_url
    else
      "/assets/placeholder.png"
    end
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(tag_names)
    self.tags = tag_names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
