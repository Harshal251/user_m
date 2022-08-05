class ArticlesController < ApplicationController
  before_action :get_article, only: [:show, :destroy, :update, :edit]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new()
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
   
     @article.user_id = session[:user_id]
    if @article.save
      flash[:notice] = "Article was created Successfully!!"
      redirect_to @article
    else
      render :new, status: :unprocessable_entity             #flashh
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully!!"
      redirect_to @article
    else
       render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, status: :see_other
     flash[:notice] = "Article was Deleted successfully!!"
  end

  private

  def get_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :discription, :user_id)
  end

end
