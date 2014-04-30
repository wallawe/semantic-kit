class TagsController < ApplicationController
  def show
    @tag = Tag.where(name: params[:id]).first
  end
end
