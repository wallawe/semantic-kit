class User < ActiveRecord::Base
  # take advantage of bcrypt setters for password
  # which sets password as password_hash
  # learn more here: https://github.com/codahale/bcrypt-ruby/blob/master/README.md
  has_secure_password

  validates :name, :username, :email, presence: true, uniqueness: true,  on: :create
  validates :password, length: { minimum: 6 }, on: :create
  validates :password, presence: true,         on: :create

  has_one :stripe_account
  has_many :subscriptions

  def to_param
    "#{username}"
  end

  def subscribed?(theme)
    subscriptions.where(theme_id: theme.id).any?
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

end