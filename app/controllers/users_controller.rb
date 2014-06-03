class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Success!' }
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
    @users = User.all
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
