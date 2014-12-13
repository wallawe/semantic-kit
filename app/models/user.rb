class User < ActiveRecord::Base
  # take advantage of bcrypt setters for password
  # which sets password as password_hash
  # learn more here: https://github.com/codahale/bcrypt-ruby/blob/master/README.md
  has_secure_password

  validates :username, :email, presence: true, uniqueness: true,  on: :create
  validates :password, length: { minimum: 6 }, on: :create
  validates :password, presence: true,         on: :create

  has_many :downloads

  has_many :favorites, dependent: :destroy
  has_many :favorite_snippets, through: :favorites, source: :favorited, source_type: 'Snippet'
  has_many :favorite_themes, through: :favorites, source: :favorited, source_type: 'Theme'

  has_many :subscriptions
  has_many :snippets, dependent: :destroy
  has_many :expos, dependent: :destroy

  has_many :owners
  has_many :themes, through: :owners, dependent: :destroy

  def to_param
    "#{username}"
  end

  def admin?
    admin
  end

  def make_admin!
    update_attribute(:admin, true)
  end

  def remove_admin!
    update_attribute(:admin, false)
  end

  def owns_theme?(theme)
    theme.owner.user_id == self.id
  end

  def owns_snippet?(snippet)
    snippet.user_id == self.id
  end

  def can_edit_theme?(theme)
    admin? || owns_theme?(theme)
  end

  def can_edit_snippet?(snippet)
    admin? || owns_snippet?(snippet)
  end

  def favorited_snippet?(snippet)
    favorite_snippets.include?(snippet)
  end

  def favorited_theme?(theme)
    favorite_themes.include?(theme)
  end

  def can_download?(theme)
    subscribed?(theme)
  end

  def can_purchase?(theme)
    !subscribed?(theme)
  end

  def subscribed?(theme)
    !!subscriptions_for(theme).detect {|s| s.downloads.any? && s.has_remaining_downloads?(theme) }
  end

  def subscriptions_for(theme)
    subscriptions.where(theme_id: theme.id)
  end

  def purchase_and_notify!(theme, params)
    user.subscriptions.create!(
      theme_id: params[:id],
      price_tier: params[:price]
    )

    if params[:paypal]
      theme.sales_tracker.increment!(params[:count].to_sym)
      theme.sales_tracker.increment!(:sale_count)
    end

    ThemeMailer.user_purchased(theme, self)
  end

end