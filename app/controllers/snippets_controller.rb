class SnippetsController < ApplicationController
  before_filter :get_snippet, only: [:show, :edit, :update, :iframe_content, :destroy]
  before_filter :authenticate, only: [:new, :create, :destroy, :update, :edit ]

  def new
    @snippet = Snippet.new
  end

  def iframe_content
    render layout: false
  end

  def create
    @snippet = Snippet.new(snippet_params)
    @snippet.user = current_user
    if @snippet.save
      redirect_to snippet_path(@snippet), notice: "Successfully created a new snippet"
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def index
    @snippets = Snippet.all
  end

  def update
    respond_to do |format|
      if @snippet.update(snippet_params)
        format.html { redirect_to snippet_path(@snippet), notice: 'Your snippet was successfully updated' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @snippet.destroy
    redirect_to semantic_ui_snippets_path, notice: 'Deletion successful'
  end

  private
    def get_snippet
      @snippet = Snippet.find(params[:id])
    end

    def snippet_params
      params.require(:snippet).permit(:title, :html, :css, :js, :user_id, :image)
    end
end
