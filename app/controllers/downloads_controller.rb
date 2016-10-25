class DownloadsController < ApplicationController
  def create
    theme = Theme.find_by_id(params[:theme_id])

    # Sometimes a user tries to download after making a guest purchase, then creating an account
    # This would throw an error because the user would exist, but the subscription would not
    # So we'll take precedence of GuestSubscription over checking current_user with Subscription
    if theme && params[:token]
      guest_subscription = GuestSubscription.where(theme_id: theme.id, token: params[:token]).first
      if guest_subscription
        guest_subscription.guest_downloads.create!(theme_id: theme.id)
        redirect_to theme.file_package.url
      end
    elsif theme && current_user
      if current_user.can_download?(theme)
        valid_subscription = current_user.subscription_with_remaining_downloads_for(theme)
        current_user.downloads.create!(theme_id: theme.id, subscription_id: valid_subscription.id)
        redirect_to theme.file_package.url
      end
    else
      redirect_to theme_path(theme), notice: "You can't download at this time. Please contact help"
    end
  end

end
