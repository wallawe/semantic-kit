class Theme < ActiveRecord::Base
  PREPROCESSOR_OPTIONS = [ ["Select", nil], ["SASS", "SASS"],
                           ["LESS", "LESS"], ["Stylus", "Stylus"],
                           ["None", "None"]
                         ]
  BROWSER_OPTIONS      = [ "Chrome", "Safari", "IE10", "IE9", "IE8", "IE7" ]

  has_many :theme_categories
  has_many :categories, through: :theme_categories

  has_many :taggings
  has_many :tags, through: :taggings

  has_one :owner,      dependent: :destroy
  has_one :price_list, dependent: :destroy

  accepts_nested_attributes_for :price_list

  mount_uploader :image, ImageUploader
  mount_uploader :file_package, FilePackageUploader

  validates :name, :description, presence: true

  scope :approved,    -> { where(approved: true) }
  scope :pending,     -> { where(approved: false) }

  def default_image_url
    if image_url.present?
      image_url
    else
      "https://s3.amazonaws.com/wrapsemanticstatic/placeholder.png"
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

  def approve!
    update_attribute(:approved, true)
  end

  def disapprove!
    update_attribute(:approved, false)
  end

  def pay_owner(amount)
    Stripe::Transfer.create(
      :amount => (amount * PriceList::THEME_CREATOR_PERCENTAGE).to_i,
      :currency => "usd",
      :recipient => self.owner.stripe_account.recipient_id,
      :statement_description => I18n.t(:"transfers.notice", theme_name: self.name)
    )
  end
end
