class Owner < ActiveRecord::Base
  belongs_to :user
  belongs_to :theme

  delegate :username, :name, :stripe_account,
    to: :user

  def user
    SemanticUsers.get("id", user_id)
  end

end
