class UsersController < ApplicationController
  layout "landing", only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_create_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to user_path(@user.username), notice: 'Success!' }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @user = User.where(username: params[:id]).first
  end

  def edit
  end

  def index
    if current_user.admin?
      @users = User.all
    else
      redirect_to root_path
    end
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
      params.require(:user).permit(:email, :password, :password_confirmation, :username)
    end

    def user_update_params
      params.require(:user).permit(:username, :website, :location, :about)
    end
end
