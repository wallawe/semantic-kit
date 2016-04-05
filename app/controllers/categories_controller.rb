class CategoriesController < ApplicationController
  def show
    if category.nil?
      redirect_to themes_path, notice: "That category doesn't exist."
      return
    end
    @category = category
  end

  private

    def category
      @category ||= Category.where(slug: params[:id]).first
    end
end
