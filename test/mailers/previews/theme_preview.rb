class ThemePreview < ActionMailer::Preview
  def user_purchase
    ThemeMailer.user_purchase(Theme.first, User.first)
  end

  def guest_purchase
    ThemeMailer.guest_purchase(Theme.first, "help@semantickit.com", GuestSubscription.random_token)
  end
end