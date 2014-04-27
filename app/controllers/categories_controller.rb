class CategoriesController < ApplicationController
  def show
    @category = Category.where(slug: params[:id]).first
  end
end
