class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_create_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.username), notice: 'Success!'
    else
      render action: "new"
    end
  end

  def show
    @user = User.where(username: params[:id]).first
  end

  def edit
  end

  def index
    @users = User.all
  end

  def update
    if current_user.update_attributes(user_update_params)
      redirect_to user_path(current_user.username)
    else
      render :edit
    end
  end

  private

    def user_create_params
      params.require(:user).permit(:email, :password, :password_confirmation, :username, :name)
    end

    def user_update_params
      params.require(:user).permit(:name, :website, :location, :about)
    end
end
