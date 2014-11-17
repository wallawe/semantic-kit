class SnippetsController < ApplicationController
  def new
    @snippet = Snippet.new
  end

  def iframe_content
    @snippet = Snippet.find(params[:id])
    render layout: false
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

  def edit
    @snippet = Snippet.find(params[:id])
  end

  def index
    @snippets = Snippet.all
  end

  def update
    @snippet = Snippet.find(params[:id])
    respond_to do |format|
      if @snippet.update(snippet_params)
        format.html { redirect_to snippet_path(@snippet), notice: 'Your snippet was successfully updated' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  private

    def snippet_params
      params.require(:snippet).permit(:title, :description, :html, :css, :js)
    end
end
