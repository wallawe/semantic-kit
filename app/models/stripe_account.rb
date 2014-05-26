class StripeAccount < ActiveRecord::Base
  belongs_to :user


  def update_from_card(token)
    recipient = Stripe::Recipient.create(
      name: user.name,
      type: "individual",
      email: user.email,
      card: token
    )
    self.update_attributes(recipient_id: recipient.id, payment_type: "card")
  end

  def update_from_bank_account(token)
    recipient = Stripe::Recipient.create(
      name: user.name,
      type: "individual",
      email: user.email,
      bank_account: token
    )
    self.update_attribute(recipient_id: recipient.id, payment_type: "bank_account")
  end
end
