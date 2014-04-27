class UsersController < ApplicationController
  def new
  end

  def create
  end

  def show
    @user = User.where(username: params[:id]).first
  end
end
