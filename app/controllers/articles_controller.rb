class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :discription))
    if @article.save
      flash[:notice] = "Article was created Successfully!!"
      redirect_to @article
    else
      render :new, status: :unprocessable_entity             #flashh
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title, :discription))
      flash[:notice] = "Article was updated successfully!!"
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, status: :see_other
     flash[:notice] = "Article was Deleted successfully!!"
  end
end
