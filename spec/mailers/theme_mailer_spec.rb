require 'rails_helper'

RSpec.describe ThemeMailer, :type => :mailer do
  let(:user)  { User.create(email: "blah@testing.com", password: "password", username: "user") }
  let(:theme) { Theme.create(name: "Admin Theme", description: "stuff", preview_url: "url", file_package: "stuff.zip", image: "image.png") }

  describe "user_purchase" do
    it "sends a link to the theme" do
      mail = ThemeMailer.user_purchase(theme, user)
      mail.subject.should == "Thanks for purchasing Admin Theme"
      mail.to.should == [user.email]
      mail.from.should == ["help@semantickit.com"]
      mail.body.encoded.should include(theme_path(theme))
    end
  end

  describe "#guest_purchase" do
    it "sends a link to the theme" do
      mail = ThemeMailer.guest_purchase(theme, "test@testing.com", "1214u10934098")
      mail.subject.should == "Thanks for purchasing Admin Theme"
      mail.to.should == ["test@testing.com"]
      mail.from.should == ["help@semantickit.com"]
      mail.body.encoded.should include(theme_path(theme, token: "1214u10934098"))
    end
  end
end