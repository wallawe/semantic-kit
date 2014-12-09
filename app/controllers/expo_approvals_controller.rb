class ExpoApprovalsController < ApplicationController
  def update
    expo.approve!
    redirect_to expos_path
  end

  def destroy
    expo.disapprove!
    redirect_to expos_path
  end

  private

    def expo
      Expo.find(params[:id])
    end
end
