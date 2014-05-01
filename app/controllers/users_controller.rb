class UsersController < ApplicationController
  def new
  end

  def create
  end

  def show
    @user = User.where(username: params[:id]).first
  end

  def edit
  end

  def update
    if current_user.update_attributes(user_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :website, :location, :about)
    end
end
