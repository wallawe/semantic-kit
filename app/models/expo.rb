class Expo < ActiveRecord::Base
  validates :url, presence: true
  belongs_to :user, :foreign_key => "user_id"

  mount_uploader :image, ImageUploader

  scope :with_image,  -> { where("image IS NOT NULL") }
  scope :approved,    -> { where(approved: true) }
  scope :pending,     -> { where(approved: false) }

  def status
    approved? ? "Approved" : "Pending"
  end

  def approve!
    update_attribute(:approved, true)
  end

  def disapprove!
    update_attribute(:approved, false)
  end

end
