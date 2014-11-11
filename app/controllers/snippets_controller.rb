class SnippetsController < ApplicationController
  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new(snippet_params)
    if @snippet.save
    else
    end
  end

  def show
    @snippet = Snippet.find(params[:id])
  end

  def index
    @snippets = Snippet.all
  end

  private

    def snippet_params
      params.require(:snippet).permit(:title, :description, :html, :css, :js)
    end
end
