class CategoriesController < ApplicationController

  before_action :require_admin, only: [:new]

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
    @articles = Article.all
  end


  private
  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !logged_in? || logged_in? && !current_user.admin?
      flash[:danger] = "Only admin can create a new category"
      redirect_to categories_path
    end
  end

end