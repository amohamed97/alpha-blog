class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show, :search]
  before_action :require_same_user, except: [:index, :show, :new, :create, :search]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 4)

  end

  def new
    @article = Article.new
  end

  def create
    # render plain:params[:article].inspect
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:danger] = "Article was successfully deleted"
    redirect_to articles_path
  end

  def search
    query = params[:query]
    @articles = Article.all.select {|article| article.description.include?(query) ||
                                    article.title.include?(query)}
    @articles.each do |article|
      if article.description[query]
        article.description[query] = "<span class='search-query'> #{query}</span>"
      end
      if article.title[query]
        article.title[query] = "<span class='search-query'> #{query}</span>"
      end
    end
  end


  private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_same_user
    if @article.user != current_user && !current_user.admin?
      flash[:danger] = "You can only edit your articles"
      redirect_to root_path
    end
  end
end
