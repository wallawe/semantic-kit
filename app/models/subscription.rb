class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :theme

  def create_customer_and_charge(token, amount)
    customer = Stripe::Customer.create(
      :email => self.user.email,
      :card  => token
    )

    Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => amount,
      :description => I18n.t(:"subscriptions.purchase", theme_name: self.theme.name, amount: self.price_tier),
      :currency    => 'usd'
    )
  end
end
