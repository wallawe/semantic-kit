class Expo < ActiveRecord::Base
  validates :url, presence: true

  mount_uploader :image, ImageUploader

  scope :with_image, -> { where("image IS NOT NULL") }

end
