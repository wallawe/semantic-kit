class User < ActiveRecord::Base
  # take advantage of bcrypt setters for password
  # which sets password as password_hash
  # learn more here: https://github.com/codahale/bcrypt-ruby/blob/master/README.md
  has_secure_password

  validates :password, length: { minimum: 6 }
  validates :password, presence: true

  has_many :subscriptions

  def to_param
    "#{username}"
  end
end
