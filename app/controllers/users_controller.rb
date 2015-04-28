class UsersController < ApplicationController
  layout "landing", only: [:new]

  def new
    if current_user
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_create_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to user_path(@user.username), notice: "Success! Add more about yourself below. Or don't. Completely up to you" }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @user = User.where(username: params[:id]).first
    redirect_to root_path, notice: "That user does not exist" unless @user
  end

  def edit
    @user = User.where(username: params[:id]).first
    redirect_to root_path if @user.id != current_user.id
  end

  def index
    if current_user && current_user.admin?
      @users = User.all
    else
      redirect_to root_path
    end
  end

  def update
    if current_user && current_user.update_attributes(user_update_params)
      redirect_to user_path(current_user.username), notice: "Your changes have been saved successfully."
    else
      render :edit
    end
  end

  def destroy
    @user = if current_user.admin?
      User.where(username: params[:id]).first
    else
      current_user
    end
    @user.destroy
    redirect_to users_path
  end

  private

    def user_create_params
      params.require(:user).permit(:email, :password, :password_confirmation, :username)
    end

    def user_update_params
      params.require(:user).permit(:username, :website, :location, :about, :password, :password_confirmation)
    end
end
