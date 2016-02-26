class ArticlesController < ApplicationController
  before_action :set_article, only: [ :edit, :update, :destroy, :show ]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit

  end

  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:notice] = "Article was succesfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "The article has been updated."
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def show

  end

  def destroy
    if @article.destroy
      flash[:notice] = "The article has been deleted"
      redirect_to articles_path
    else
      flash[:notice] = "Can't delete this article"
      redirect_to articles_path
    end
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end

end
