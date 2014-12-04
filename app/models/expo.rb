require 'screencap'

class Expo < ActiveRecord::Base
  validates :url, presence: true

  mount_uploader :image, ImageUploader

  scope :with_image, -> { where("image IS NOT NULL") }

  def assign_image!
    fetcher       = ::Screencap::Fetcher.new(self.url)
    random_string = SecureRandom.urlsafe_base64(nil, false)

    screenshot = fetcher.fetch(
      :output => "tmp/images/#{self.url}_#{random_string}.png"
    )

    self.image = screenshot
    self.save!
  end
end
