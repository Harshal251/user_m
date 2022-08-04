class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "WELCOME #{@user.username} !! YOU HAVE SUCCESSFULLY SIGNED-UP!!"
      redirect_to @user
    else
      render :new, status: :unprocessable_entity             #flashh
    end
  end
  private
    def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
