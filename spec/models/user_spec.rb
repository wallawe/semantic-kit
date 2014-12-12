require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user)  { User.create(email: "blah@testing.com", password: "password", username: "user") }
  let(:theme) { Theme.create(name: "Blah", description: "stuff", preview_url: "url", file_package: "stuff.zip", image: "image.png") }

  before do
    user
    theme
  end

  describe "#can_purchase?" do
    context "when a User has no subscriptions" do
      it "returns true" do
        expect(user.can_purchase?(theme)).to eq(true)
      end
    end

    context "when a User has subscriptions" do
      context "with one subscription that has less than 5 downloads" do
        before do
          subscription = user.subscriptions.create(theme_id: theme.id, user_id: user.id)
          2.times do |i|
            subscription.downloads.create(
              theme_id: theme.id,
              subscription_id: subscription.id,
              user_id: user.id
            )
          end
        end

        it "returns false" do
          expect(user.can_purchase?(theme)).to eq(false)
        end
      end

      context "with multiple subscriptions, one of which has less than 5 downloads" do
        before do
          subscription = Subscription.create(theme_id: theme.id, user_id: user.id)
          subscription_2 = Subscription.create(theme_id: theme.id, user_id: user.id)

          subscription_2.downloads.create(
            id: 3,
            theme_id: theme.id,
            subscription_id: subscription.id,
            user_id: user.id
          )

          2.times do |i|
            subscription.downloads.create(
              theme_id: theme.id,
              subscription_id: subscription.id,
              user_id: user.id
            )
          end
        end

        it "returns false" do
          expect(user.can_purchase?(theme)).to eq(false)
        end
      end

      context "with one subscription that has 5 downloads" do
        before do
          subscription = user.subscriptions.create(id: 1, theme_id: theme.id, user_id: user.id)
          1.upto(5) do |n|
            subscription.downloads.create(
              id: n,
              theme_id: theme.id,
              subscription_id: subscription.id,
              user_id: user.id
            )
          end
        end

        it "returns true" do
          expect(user.can_purchase?(theme)).to eq(true)
        end
      end

      context "with multiple subscriptions, each of which has 5 downloads" do
        before do
          subscription = Subscription.create(theme_id: theme.id, user_id: user.id)
          subscription_2 = Subscription.create(theme_id: theme.id, user_id: user.id)

          1.upto(5) do |n|
            subscription_2.downloads.create(
              id: n,
              theme_id: theme.id,
              subscription_id: subscription.id,
              user_id: user.id
            )
          end

          6.upto(10) do |n|
            subscription.downloads.create(
              id: n,
              theme_id: theme.id,
              subscription_id: subscription.id,
              user_id: user.id
            )
          end
        end

        it "returns true" do
          expect(user.can_purchase?(theme)).to eq(true)
        end
      end
    end
  end

  describe "#can_download?" do
    context "when a User has no subscriptions" do
      it "returns false" do
        expect(user.can_download?(theme)).to eq(false)
      end
    end

    context "when a User has subscriptions" do
      context "with one subscription that has less than 5 downloads" do
        before do
          subscription = Subscription.create(theme_id: theme.id, user_id: user.id)
          1.upto(2) do |n|
            subscription.downloads.create(
              id: n,
              theme_id: theme.id,
              subscription_id: subscription.id,
              user_id: user.id
            )
          end
        end

        it "returns true" do
          p "spec inspect #{user.subscriptions.inspect}"
          expect(user.can_download?(theme)).to eq(true)
        end
      end

      context "with multiple subscriptions, one of which has less than 5 downloads" do
        before do
          subscription = user.subscriptions.create(theme_id: theme.id, user_id: user.id)
          subscription_2 = user.subscriptions.create(theme_id: theme.id, user_id: user.id)

          subscription_2.downloads.create(
            id: 6,
            theme_id: theme.id,
            subscription_id: subscription.id,
            user_id: user.id
          )

          1.upto(5) do |n|
            subscription.downloads.create(
              id: n,
              theme_id: theme.id,
              subscription_id: subscription.id,
              user_id: user.id
            )
          end
        end

        it "returns true" do
          expect(user.can_download?(theme)).to eq(true)
        end
      end

      context "with one subscription that has 5 downloads" do
        before do
          subscription = Subscription.create(theme_id: theme.id, user_id: user.id)
          1.upto(5) do |n|
            subscription.downloads.create(
              id: n,
              theme_id: theme.id,
              subscription_id: subscription.id,
              user_id: user.id
            )
          end
        end

        it "returns false" do
          expect(user.can_download?(theme)).to eq(false)
        end
      end

      context "with multiple subscriptions, each of which has 5 downloads" do
        before do
          subscription = Subscription.create(theme_id: theme.id, user_id: user.id)
          subscription_2 = Subscription.create(theme_id: theme.id, user_id: user.id)

          1.upto(5) do |n|
            subscription_2.downloads.create(
              id: n,
              theme_id: theme.id,
              subscription_id: subscription.id,
              user_id: user.id
            )
          end

          6.upto(10) do |n|
            subscription.downloads.create(
              id: n,
              theme_id: theme.id,
              subscription_id: subscription.id,
              user_id: user.id
            )
          end
        end

        it "returns false" do
          expect(user.can_download?(theme)).to eq(false)
        end
      end
    end
  end
end