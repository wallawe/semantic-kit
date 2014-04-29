class Theme < ActiveRecord::Base
  has_many :theme_categories
  has_many :categories, through: :theme_categories

  has_one :owner

  has_one :price_list

  mount_uploader :image, ImageUploader

  validates :name, :description, :image, presence: true

  def default_image_url
    if image_url.present?
      image_url
    else
      "/assets/placeholder.png"
    end
  end
end
