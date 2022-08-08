class UsersController < ApplicationController
  before_action :get_article, only: [:show, :edit, :update, :destroy]

  def index
    @user = User.all
  end

  def show
    @articles = @user.articles
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "WELCOME #{@user.username} !! YOU HAVE SUCCESSFULLY SIGNED-UP!!"
      redirect_to @user
    else
      render :new, status: :unprocessable_entity             #flashh
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User Details were updated successfully!!"
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "User Details Were  Deleted successfully!!"
    redirect_to users_path, status: :see_other
  end

  private

  def get_article
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
