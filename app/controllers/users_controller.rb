class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_logged_out, only: [:new]

  def index
    @users = User.paginate(page: params[:page], per_page: 4)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Alpha Blog, #{@user.username}"
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User has been edited successfully"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def show
    @articles = @user.articles
  end


  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if @user != current_user
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end
  end

  def require_logged_out
    if current_user
      redirect_to root_path
    end
  end
end
