class ArticlesController < ApplicationController
  before_action :set_article, only: [ :edit, :update, :destroy, :show ]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update,:destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit

  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was succesfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "The article has been updated."
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def show

  end

  def destroy
    if @article.destroy
      flash[:danger] = "The article has been deleted"
      redirect_to articles_path
    else
      flash[:danger] = "Can't delete this article"
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

    def require_same_user
      if current_user != @article.user && !current_user.admin?
        flash[:danger] = "You can only edit or deleted your own article"
        redirect_to root_path
      end
    end

end
