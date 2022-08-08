class SessionsController < ApplicationController

  def new 
  
  end 

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
    flash[:notice]= "Login Success!!"
        if user.admin?
          redirect_to articles_path
        else
          redirect_to user
        end
    else
      flash.now[:alert] = "There was Some error!!" #using now because we are not redirecting
      render :new, status: :unprocessable_entity 
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice]= "Logged Out Successfully!!!"
    redirect_to root_path
  end

end