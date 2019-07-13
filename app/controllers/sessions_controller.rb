class SessionsController < ApplicationController

  before_action :require_logged_out, only: [:new]

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash.now[:success] = "Successfully logged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Wrong email or password"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end

  private
  def require_logged_out
    if current_user
      flash[:danger] = "You are already logged in"
      redirect_to user_path(current_user)
    end
  end

end
