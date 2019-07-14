class CategoriesController < ApplicationController

  before_action :require_admin, only: [:new, :edit, :update]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 3)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category has been created successfully"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.paginate(page: params[:page], per_page: 4)
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = "Category was successfully edited"
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:success] = "Category was successfully deleted"
    redirect_to categories_path
  end


  private
  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !logged_in? || logged_in? && !current_user.admin?
      flash[:danger] = "Only admin can do this action"
      redirect_to categories_path
    end
  end

end