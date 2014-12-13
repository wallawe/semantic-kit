class ThemeMailer < ActionMailer::Base
  default :from => "SemanticKit <help@semantickit.com>",
          :return_path => "help@semantickit.com"

  def user_purchase(theme, user)
    @theme = theme
    @user  = user
    mail(:to => "#{@user.username} <#{@user.email}>", subject: t(:"mailers.themes.purchase_subject", theme_name: theme.name))
  end

  def guest_purchase(theme)
  end

end